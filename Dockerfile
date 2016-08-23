# vim:set ft=dockerfile:
FROM alpine:edge

ENV UID 110245
ENV GID 110245

RUN addgroup -g "${GID}" -S nzbget && adduser -S -u "${UID}" -G nzbget nzbget && \
    echo "@testing http://dl-3.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories

RUN apk add --no-cache bash nzbget@testing unrar

RUN mkdir /data /config && cp /usr/share/nzbget/nzbget.conf /config && \
    sed -i 's/MainDir=~\/downloads/MainDir=\/data/g' /config/nzbget.conf && \
    chown -R nzbget:nzbget /data /config
VOLUME /data

EXPOSE 6789
USER nzbget
CMD ["nzbget", "-s", "-c", "/config/nzbget.conf"] 
