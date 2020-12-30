#!/usr/bin/env bash

SCRIPTDIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

helpme()
{
  cat <<HELPMEHELPME
Syntax:
  $0 numberOfBrowsers
  $0 -sbt
  $0 -rm
  $0 [-h|--help]

When specifying the number of browser, then start the containers for testing the BridgeScoreKeeper jar.
When specifying -sbt, then a stopped sbt container is started, and entered.
when specifying -rm, stop and delete all containers

HELPMEHELPME
}

if [[ "$1" == "-h" || "$1" == "--help" ]] ; then
  helpme
  exit 1
fi

cd $SCRIPTDIR

export hubIP=10.11.0.100
export hubURL=http://${hubIP}:4444
export sbtIP=10.11.0.101

buildoptions="--label com.github.thebridsk.bridge.build --user build"

rmAll() {
  containers=$(docker ps --all --quiet -f "label=com.github.thebridsk.bridge.build")
  if [[ -n $containers ]] ; then
    echo Deleting containers
    docker rm --force ${containers}
  fi
}

startAll() {
  createHub
  createNodes $1
  createSbt
}

createHub() {
  echo Starting Hub
  docker run ${buildoptions} \
      -dit \
      --name seleniumhub \
      -p 127.0.0.1:4444:4444/tcp \
      --network="buildnet" \
      build/seleniumhub
}

createNodes() {
  echo Starting $1 Nodes
  for i in $(seq 1 $1)
  do
    docker run ${buildoptions} \
        --memory "2G" \
        --memory-reservation "1G" \
        --shm-size "1G" \
        -dit \
        --name seleniumnode$i \
        --network "buildnet" \
        build/seleniumnode
  done
}

createSbt() {
  echo Starting SBT
  docker run ${buildoptions} \
      -it \
      --name sbt \
      -p 127.0.0.1:7080-7082:8080-8082/tcp \
      --mount type=volume,source=bridgescorer,destination=/opt/build \
      --network="buildnet" \
      build/sbt
}

startSbt() {
  echo Entering SBT
  docker start -i sbt
}

if [[ "$1" == "-rm" ]] ; then
  rmAll
elif [[ "$1" == "-sbt" ]] ; then
  startSbt
else
  rmAll
  startAll $1
fi
