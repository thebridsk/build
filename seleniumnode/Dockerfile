FROM build/seleniumbase:latest

USER root

WORKDIR /opt/selenium

RUN apt-get install -y firefox firefox-geckodriver

ARG VERSION_CHROMEDRIVER=87.0.4280.88

# install chrome and chromedriver
RUN curl -sS -o - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add \
    && echo "deb [arch=amd64]  http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google-chrome.list \
    && apt-get update \
    && apt-get install -y google-chrome-stable \
    && wget https://chromedriver.storage.googleapis.com/${VERSION_CHROMEDRIVER}/chromedriver_linux64.zip \
    && unzip chromedriver_linux64.zip \
    && mv chromedriver /usr/bin/chromedriver

COPY \
     nodeConfig.json \
    #  node4Config.toml \
     /opt/selenium/

USER build

# ADD supervisor.conf /etc/supervisor.conf
# ADD xvfb.sv.conf /etc/supervisor/conf.d/
# ADD hub.sv.conf /etc/supervisor/conf.d/

# CMD supervisord -c /etc/supervisor.conf

ENV DISPLAY=:99
ENV HUBURL=http://seleniumhub:4444

# CMD xvfb-run --server-args='-screen 0 1920x1080x24' java -jar ${BASE_NAME_SELENIUMGRID}-${VERSION_SELENIUMGRID}.jar -role node -hub ${HUBURL} -nodeConfig nodeConfig.json -log /opt/selenium/seleniumGridNode.log
CMD xvfb-run --server-args='-screen 0 1920x1080x24' java -jar ${BASE_NAME_SELENIUMGRID}-${VERSION_SELENIUMGRID}.jar node --config node4Config.toml
