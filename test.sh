#!/usr/bin/env bash

# tests would be here, will just check if correct value used in config

function test_build {
  DEPLOY_ENV=$(cat repo/config.ini | grep DEPLOY_ENV= | cut -d= -f2)
  if [ "$DEPLOY_ENV" != DEV ] && [ "$DEPLOY_ENV" != PROD ] ; then
    echo 0
  else
    echo 1
  fi
}
