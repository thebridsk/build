FROM adoptopenjdk:11.0.9.1_1-jdk-hotspot

USER root

RUN apt-get update \
    && apt-get install -y \
          gnupg \
          unzip \
          xvfb \
          libxi6 \
          libgconf-2-4 \
          net-tools \
          iproute2 \
          vim \
          sudo \
          curl \
          wget \
          iputils-ping \
          dnsutils \
          tcpdump

RUN chmod a+wrx /opt

RUN useradd -d /opt/build/home -s /bin/bash -u 1001 -U build \
    && usermod -a -G audio,video build
    # && echo "build ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/build \
    # && chmod 0440 /etc/sudoers.d/build

CMD [ "bash" ]
