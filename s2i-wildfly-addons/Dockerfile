FROM openshift/base-centos7

MAINTAINER Jorge Morales <jmorales@redhat.com>

EXPOSE 8080

ENV WILDFLY_VERSION=10.0.0.Final \
    MAVEN_VERSION=3.3.9

LABEL io.k8s.description="Platform for building and running JEE applications on WildFly 10.0.0.Final (Addons enabled)" \
      io.k8s.display-name="WildFly 10.0.0.Final (Addons)" \
      io.openshift.expose-services="8080:http" \
      io.openshift.tags="builder,wildfly,wildfly10,addons" \
      io.openshift.s2i.destination="/opt/s2i/destination"

# Install Maven, Wildfly 10
RUN INSTALL_PKGS="tar unzip bc which lsof java-1.8.0-openjdk java-1.8.0-openjdk-devel" && \
    yum install -y --enablerepo=centosplus $INSTALL_PKGS && \
    rpm -V $INSTALL_PKGS && \
    yum clean all -y && \
    (curl -v https://www.apache.org/dist/maven/maven-3/$MAVEN_VERSION/binaries/apache-maven-$MAVEN_VERSION-bin.tar.gz | \
    tar -zx -C /usr/local) && \
    ln -sf /usr/local/apache-maven-$MAVEN_VERSION/bin/mvn /usr/local/bin/mvn && \
    mkdir -p /wildfly && \
    (curl -v https://download.jboss.org/wildfly/$WILDFLY_VERSION/wildfly-$WILDFLY_VERSION.tar.gz | tar -zx --strip-components=1 -C /wildfly) && \
    mkdir -p /opt/s2i/destination

# Add s2i wildfly customizations
#ADD ./contrib/wfmodules/ /wildfly/modules/
ADD ./contrib/standalone.conf /wildfly/bin/standalone.conf
#ADD ./contrib/wfcfg/standalone.xml /wildfly/standalone/configuration/standalone.xml

# Copy the S2I scripts from the specific language image to $STI_SCRIPTS_PATH
COPY ./contrib/s2i/bin/ $STI_SCRIPTS_PATH

RUN chown -R 1001:0 /wildfly && chown -R 1001:0 $HOME/.pki && \
    chmod -R ug+rw /wildfly && \
    chmod -R g+rw /opt/s2i/destination

USER 1001

CMD $STI_SCRIPTS_PATH/usage
