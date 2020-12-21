FROM centos:7

# Expose the HTTP and the JVM debug ports
EXPOSE 8080 5005

# Define all static environment variables
ENV \
  JAVA_HOME="/etc/alternatives/jre" \
  JAVA_MAX_MEM="512m" \
  JVM_ENCODING_OPTS="-Dfile.encoding=utf-8" \
  DEMO_HOME="/opt/kubernetes-demo-backend" \
  DEMO_USER="demo" \
  DEMO_GROUP="demo"

# Create the group and user
RUN \
  groupadd -g 10650 $DEMO_GROUP && \
  useradd -u 650 -r -g $DEMO_GROUP $DEMO_USER

RUN \
  mkdir $DEMO_HOME && \
  chown $DEMO_USER:$DEMO_GROUP $DEMO_HOME -R  && \
  yum install -y \
    java-11-openjdk \
    nano && \
  yum clean all && \
  curl https://letsencrypt.org/certs/lets-encrypt-x3-cross-signed.pem  > /tmp/lets-encrypt-x3-cross-signed.pem && \
  keytool -trustcacerts  -keystore /etc/pki/ca-trust/extracted/java/cacerts --storepass changeit -noprompt -importcert -file /tmp/lets-encrypt-x3-cross-signed.pem && \
  rm /tmp/lets-encrypt-x3-cross-signed.pem

ADD build/libs/kubernetes-demo-backend-0.1.0.jar $DEMO_HOME

LABEL vendor=Valtech \
  name=Demo \
  license=""

# Set custom script as entrypoint
COPY entrypoint.sh /entrypoint.sh
RUN chown $DEMO_USER:$DEMO_GROUP /entrypoint.sh
RUN ["chmod", "+x", "/entrypoint.sh"]

USER $DEMO_USER

ENTRYPOINT ["/bin/bash", "/entrypoint.sh"]