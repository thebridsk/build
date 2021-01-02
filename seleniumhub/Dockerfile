FROM build/seleniumbase:latest

USER build

EXPOSE 4444

WORKDIR /opt/selenium

COPY \
     # hubConfig.json \
     hub4Config.toml \
     /opt/selenium/

#
# VERSION_SELENIUMGRID environment variable comes from base image
#
# CMD java -jar ${BASE_NAME_SELENIUMGRID}-${VERSION_SELENIUMGRID}.jar -role hub -hubConfig hubConfig.json -log /opt/selenium/seleniumGridHub.log
CMD java -jar ${BASE_NAME_SELENIUMGRID}-${VERSION_SELENIUMGRID}.jar hub --config hub4Config.toml
