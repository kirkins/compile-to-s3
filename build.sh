#!/usr/bin/env bash
#
# Downloads a repo, builds file, tests, and uploads to S3

source test.sh
source s3.sh

IP=$(hostname -I | cut -d ' ' -f1)
echo Running build on hostname:$IP

rm -rf repo
ssh-agent bash -c 'ssh-add id_rsa; \
  git clone git@bitbucket.org:PKirkbride/test.git repo'

if grep -q DEPLOY_ENV= repo/config.ini; then
  sed -i 's/^\(DEPLOY_ENV=\).*/\1'"$1"'/' repo/config.ini
else
  echo DEPLOY_ENV=$1 >> repo/config.ini;
fi

T=$(test_build $1)
if [ "$T" -eq 0 ] ; then
  echo "build failed, will try again in 5 seconds"
  sleep 5
  T2=$(test_build $1)
  if [ "$T2" -eq 0 ] ; then
    echo "build failed, will try again in 5 seconds"
    sleep 5
    T3=$(test_build $1)
    if [ "$T3" -eq 0 ] ; then
      rm -rf repo
      echo "build failed, exiting"
      exit
    fi 
  fi
fi

date=$(date '+%d-%m-%Y_%H:%M:%S');
#file=$(printf .tar.gz && printf $1 && printf $date)
file=$(printf $date && printf "-" && printf "$1" && printf .tar.gz)
echo "$file"

tar --force-local -zcf "$file" repo/bin/
rm -rf repo
s3_upload "$file"
rm "$file"
printf "\nFile can be downloaded at: \n\n"
echo https://s3-us-west-2.amazonaws.com/vutest/"$file"
