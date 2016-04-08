FROM scratch

MAINTAINER Jorge Morales <jmorales@redhat.com>

LABEL addon.type="jdbc-driver"
LABEL addon.vendor="mysql"
LABEL addon.version="1.0"
LABEL addon.compatibility="wildfly:10"

COPY files/ /addon/files/
COPY config/ /addon/config/
COPY apply /addon/apply

CMD ["/bin/sh"]