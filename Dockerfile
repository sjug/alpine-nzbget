# vim:set ft=dockerfile:
FROM alpine:edge

RUN addgroup -S nzbget && adduser -S -G nzbget nzbget && \
    echo "@testing http://dl-3.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories

RUN apk add --no-cache bash nzbget@testing su-exec unrar

RUN mkdir /data /config && cp /usr/share/nzbget/nzbget.conf /config && \
    sed -i 's/MainDir=~\/downloads/MainDir=\/data/g' /config/nzbget.conf && \
    chown -R nzbget:nzbget /config /data
VOLUME /data
WORKDIR /data

COPY docker-entrypoint.sh /usr/local/bin/
ENTRYPOINT ["docker-entrypoint.sh"]

EXPOSE 6789
CMD ["nzbget", "-s", "-c", "/config/nzbget.conf"] 
