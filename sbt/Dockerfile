FROM build/baseimage:latest

WORKDIR /opt

ARG VERSION_NODEJS=14.x
ARG VERSION_HUGO=0.79.1

# install nodejs
RUN curl -sL https://deb.nodesource.com/setup_${VERSION_NODEJS} | bash - \
    && apt-get install -y nodejs

# install sbt
RUN echo "deb https://dl.bintray.com/sbt/debian /" |  tee -a /etc/apt/sources.list.d/sbt.list \
    && curl -sL "https://keyserver.ubuntu.com/pks/lookup?op=get&search=0x2EE0EA64E40A89B84B2DF73499E82A75642AC823" |  apt-key add \
    && apt-get update \
    && apt-get install -y sbt

RUN mkdir /opt/hugo

WORKDIR /opt/hugo

RUN \
    wget https://github.com/gohugoio/hugo/releases/download/v${VERSION_HUGO}/hugo_${VERSION_HUGO}_checksums.txt \
    && wget https://github.com/gohugoio/hugo/releases/download/v${VERSION_HUGO}/hugo_${VERSION_HUGO}_Linux-64bit.tar.gz \
    && grep "hugo_${VERSION_HUGO}_Linux-64bit.tar.gz" "hugo_${VERSION_HUGO}_checksums.txt" | sha256sum -c - \
    && tar -xvzf hugo_${VERSION_HUGO}_Linux-64bit.tar.gz \
    && mv hugo /usr/local/bin

# port for manual testing
EXPOSE 8080/tcp
# port for automated testing
EXPOSE 8081/tcp
# port for automated testing
EXPOSE 8082/tcp
# port for selenium grid.  Use http://localhost:4444/grid/console

USER build

ENV HUBURL="http://seleniumhub:4444" \
    TestServerListen="http://sbt:8081" \
    TestServerFixHostInURL=true

ENV WebDriverDebug=true \
    BuildProduction=true \
    # ParallelUtilsUseSerial=true \
    ChromeNoSandbox=true \
    UseBrowser="remote chrome ${HUBURL}/wd/hub" \
    HOME=/opt/build/home

WORKDIR /opt/build/bridgescorer

CMD bash
