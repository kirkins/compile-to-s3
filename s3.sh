#!/usr/bin/env bash

function s3_upload {
  file=$1
  bucket=$AWS_BUCKET
  resource="/${bucket}/${file}"
  contentType="application/x-compressed-tar"
  dateValue=`date -R`
  stringToSign="PUT\n\n${contentType}\n${dateValue}\n${resource}"
  s3Key=$S3KEY
  s3Secret=$S3SECRET
  signature=`echo -en ${stringToSign} | openssl sha1 -hmac ${s3Secret} -binary | base64`
  curl -X PUT -T "${file}" \
       -H "Host: ${bucket}.s3.amazonaws.com" \
       -H "Date: ${dateValue}" \
       -H "Content-Type: ${contentType}" \
       -H "Authorization: AWS ${s3Key}:${signature}" \
       https://${bucket}.s3.amazonaws.com/${file}
}
