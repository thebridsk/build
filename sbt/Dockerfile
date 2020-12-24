FROM build/baseimage:latest

WORKDIR /opt

ARG VERSION_NODEJS=14.x

# install nodejs
RUN curl -sL https://deb.nodesource.com/setup_${VERSION_NODEJS} | bash - \
    && apt-get install -y nodejs

# install sbt
RUN echo "deb https://dl.bintray.com/sbt/debian /" |  tee -a /etc/apt/sources.list.d/sbt.list \
    && curl -sL "https://keyserver.ubuntu.com/pks/lookup?op=get&search=0x2EE0EA64E40A89B84B2DF73499E82A75642AC823" |  apt-key add \
    && apt-get update \
    && apt-get install -y sbt

# port for manual testing
EXPOSE 8080/tcp
# port for automated testing
EXPOSE 8081/tcp
# port for automated testing
EXPOSE 8082/tcp
# port for selenium grid.  Use http://localhost:4444/grid/console

USER build

ENV HUBURL="http://seleniumhub:4444" \
    UseBridgeScorerHost=sbt

ENV WebDriverDebug=true \
    BuildProduction=true \
    # ParallelUtilsUseSerial=true \
    ChromeNoSandbox=true \
    UseBrowser="remote chrome ${HUBURL}/wd/hub" \
    StartTestServer="true" \
    HOME=/opt/build/home

WORKDIR /opt/build/bridgescorer

CMD bash
