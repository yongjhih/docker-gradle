# ref. https://docs.gradle.org/current/userguide/installation.html
FROM java:8

ENV GRADLE_VERSION 2.13
ENV GRADLE_URL https://services.gradle.org/distributions/gradle-${GRADLE_VERSION}-bin.zip
#ENV GRADLE_SHA1

RUN cd /usr/lib && \
    curl -L $GRADLE_URL -o gradle-bin.zip && \
    unzip gradle-bin.zip && \
    ln -s "/usr/lib/gradle-${GRADLE_VERSION}/bin/gradle" /usr/bin/gradle && \
    rm gradle-bin.zip && \
    mkdir -p /src

WORKDIR /src

ENV GRADLE_HOME /usr/lib/gradle-${GRADLE_VERSION}
ENV PATH $PATH:${GRADLE_HOME}/bin

CMD gradle
