FROM alpine:edge
MAINTAINER Evgeniy Slizevich <evgeniy@slizevich.net>

WORKDIR /

RUN apk add --no-cache \
       pdns \
       pdns-backend-sqlite3 \
       sqlite \
    && rm -f /etc/pdns/pdns.conf \
    && mkdir /var/lib/pdns \
    && mkdir /usr/share/pdns

ADD entry /
ADD pdns.conf /etc/pdns/
ADD schema.sqlite3.sql /usr/share/pdns/

EXPOSE 53/udp 53/tcp

VOLUME [/var/lib/pdns]

ENTRYPOINT ["/entry"]
