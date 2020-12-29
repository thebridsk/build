FROM build/baseimage3:latest

USER root

RUN mkdir -p /opt/selenium \
    && chown -R build:build /opt/selenium

WORKDIR /opt/selenium

ARG FOLDER_SELENIUMGRID=3.141
ARG ARG_VERSION_SELENIUMGRID=3.141.59
ARG ARG_BASE_NAME_SELENIUMGRID=selenium-server-standalone
# ARG FOLDER_SELENIUMGRID=4.0-alpha-7
# ARG ARG_VERSION_SELENIUMGRID=4.0.0-alpha-7
# ARG ARG_BASE_NAME_SELENIUMGRID=selenium-server

# https://selenium-release.storage.googleapis.com/3.141/selenium-server-standalone-3.141.59.jar
# https://selenium-release.storage.googleapis.com/4.0-alpha-7/selenium-server-4.0.0-alpha-7.jar
RUN wget https://selenium-release.storage.googleapis.com/${FOLDER_SELENIUMGRID}/${ARG_BASE_NAME_SELENIUMGRID}-${ARG_VERSION_SELENIUMGRID}.jar

USER build

RUN mkdir -p /opt/build/home

ENV VERSION_SELENIUMGRID=${ARG_VERSION_SELENIUMGRID}
ENV BASE_NAME_SELENIUMGRID=${ARG_BASE_NAME_SELENIUMGRID}

CMD bash
