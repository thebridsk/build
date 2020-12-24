# build

Docker stuff for doing builds and tests.

# Images

This repository contains 4 dockerfiles to create images.  The images can be created with the [createImage.sh](createImage.sh) or using Docker Compose.

With Docker Compose, the [.env](.env) file contains the project name that is used as a prefix for all created entities.

## baseimage

A base image for all the other images, that contains an [AdoptOpenJDK](https://adoptopenjdk.net/) JDK.

The base image for this [Docker Official Images' adoptopenjdk](https://hub.docker.com/_/adoptopenjdk/).

The base image defines the userid build for running all builds and tests.  The home directory for the userid is `/opt/build/home`.

It is recommended that a persistent volume be mounted at `/opt/build`.

## Selenium Grid

See [Selenium Grid](https://www.selenium.dev/documentation/en/grid/) for documentation.

### seleniumbase

This image contains a Selenium Grid server jar file.  There is no configuration in this image.

#### Arguments:

The dockerfile has the following arguments with the defaults shown.

    ARG FOLDER_SELENIUMGRID=4.0-alpha-7
    ARG ARG_VERSION_SELENIUMGRID=4.0.0-alpha-7
    ARG ARG_BASE_NAME_SELENIUMGRID=selenium-server

The **FOLDER_SELENIUMGRID** arg is the folder that contains the Selenium grid download.
The **ARG_VERSION_SELENIUMGRID** arg is the Selenium grid version.
The **ARG_BASE_NAME_SELENIUMGRID** arg is the base name of the Selenium Grid jar file.

These arguments are used to generate the download URL: `https://selenium-release.storage.googleapis.com/${FOLDER_SELENIUMGRID}/${ARG_BASE_NAME_SELENIUMGRID}-${ARG_VERSION_SELENIUMGRID}.jar`

#### Environment

This image provides the environment variable **VERSION_SELENIUMGRID**, which identifies the selenium grid version to the container.  The value is obtained from **ARG_VERSION_SELENIUMGRID**.

### seleniumhub

This image contains a Selenium Grid Hub.  The hub starts when the container is started.

The container will expose port 4444, the port the hub listens on.  If this is mapped to the docker host, it is recommended, for security, that it be bound only to interface `127.0.0.1`.

To view the Grid console, use http://*hubipaddr*:4444/ui/index.html.  If the container is running locally and port 4444 has been mapped to port 4444, then http://localhost:4444/ui/index.html can be used.

When writing Selenium tests, configure the Selenium RemoteWebDriver to use URL http://*hubipaddr*:4444/wd/hub

The hub is configured with the [hubConfig.json](seleniumhub/hubConfig.json) file.

For the *hubipaddr*, the docker container name can be used.  If [run.sh](run.sh) is used to start the container, then the container name is **seleniumhub**.

### seleniumnode

This image contains a Selenium Grid Node, with firefox and chrome.

The Selenium Node starts up when the container starts.

The node is configured with the [nodeConfig.json](seleniumnode/nodeConfig.json) file.

#### Environment

The environment variable HUBURL should point to the Selenium Hub's exposed port, example:
`HUBURL=http://seleniumhub:4444`

## sbt

This image contains [AdoptOpenJDK](https://adoptopenjdk.net/), from base image, [SBT](https://www.scala-sbt.org/) and [Node.js](https://nodejs.org/en/).

#### Environment

The environment variable HUBURL should point to the Selenium Hub's exposed port, example:
`HUBURL=http://seleniumhub:4444`

The following environment variables are set for building and testing the BridgeScorer application:

- `UseBridgeScorerHost=10.11.0.101` - the host the tests should use to access the BridgeScoreKeeper server.
- `WebDriverDebug=true` - turn on WebDriver debugging
- `BuildProduction=true` - production builds should be done
- `ChromeNoSandbox=true` - Chrome must run with no-sandbox=true when running in a container.  See https://github.com/jessfraz/dockerfiles/issues/149 and https://github.com/jessfraz/dockerfiles/issues/65
- `UseBrowser="remote chrome ${HUBURL}/wd/hub"` - the browser to use for testing
- `StartTestServer="true"` - the test server should be started
- `HOME=/opt/build/home` - the home directory

Note: if setting the **HUBURL** env variable, the **UseBrowser** must also be set.

# Running

These images can be deployed two ways, using the [run.sh](run.sh) script or using docker-compose.

## run.sh

Syntax:

    ./run.sh numberOfBrowsers
    ./run.sh -sbt
    ./run.sh -rm

Where:
- *numberOfBrowsers* - is a number greater than 0 of the number of browser nodes to start.
- **-sbt** - indicates to start only the sbt container, and enter it.
- **-rm** - remove all containers.

The run.sh script expects the network **buildnet** be defined.  All containers are attached to this network.  The volume **bridgescorer** must also be defined.  The volume will be mounted to `/opt/build` in the `sbt` container.

## Docker Compose

Running `docker-compose up` will create the volume and network if necessary and create and start all containers.

See [Docker Compose](https://docs.docker.com/compose/) documentation for more.
