FROM ubuntu:14.04.3

RUN apt-get -y update
RUN apt-get install software-properties-common python-software-properties -y
RUN add-apt-repository ppa:openjdk-r/ppa -y
RUN apt-get -y update
RUN apt-get install openjdk-8-jdk -y
RUN apt-get install curl -y

ENV MAVEN_VERSION 3.3.9

RUN curl --insecure -fsSL https://archive.apache.org/dist/maven/maven-3/$MAVEN_VERSION/binaries/apache-maven-$MAVEN_VERSION-bin.tar.gz | tar xzf - -C /usr/share \
  && mv /usr/share/apache-maven-$MAVEN_VERSION /usr/share/maven \
  && ln -s /usr/share/maven/bin/mvn /usr/bin/mvn

ENV MAVEN_HOME /usr/share/maven

VOLUME /root/.m2
VOLUME /root/.gnupg

RUN mkdir /data

VOLUME /data

WORKDIR /data

COPY settings.xml /

ENV GPG_PASSPHRASE=setit
ENV SONATYPE_USERNAME=setit
ENV SONATYPE_PASSWORD=setit
ENV POM_NAME=pom.xml
ENV KEY_FILE_NAME=KEY.asc

CMD ["sh", "-c", "gpg --import ${KEY_FILE_NAME} && mvn clean deploy --settings /settings.xml -P release-sign-artifacts -f ${POM_NAME}"]
