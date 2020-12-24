#!/usr/bin/env bash

SCRIPTDIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

helpme()
{
  cat <<HELPMEHELPME
Syntax: $0 [-h|--help]

Stop and delete all containers.

HELPMEHELPME
}

if [[ "$1" == "-h" || "$1" == "--help" ]] ; then
  helpme
  exit 1
fi

cd $SCRIPTDIR

./run.sh -rm
