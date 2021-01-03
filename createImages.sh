#!/usr/bin/env bash

SCRIPTDIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

helpme()
{
  cat <<HELPMEHELPME
Syntax: $0 [-h|--help]

Creates the docker images used to build and test the BridgeScoreKeeper jar file.

HELPMEHELPME
}

if [[ "$1" == "-h" || "$1" == "--help" ]] ; then
  helpme
  exit 1
fi

cd $SCRIPTDIR

createImage() {

  cd $1
  docker build -t build/${1}:latest .
  if [[ $? != 0 ]] ; then
    echo Failed to build $1
    exit 1
  fi
  cd ..
}

createImage "baseimage"
createImage "seleniumbase"
createImage "seleniumhub"
createImage "seleniumnode"
createImage "sbt"
createImage "allinone"
