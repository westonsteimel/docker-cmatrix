FROM alpine:edge as builder

RUN apk upgrade && apk add --no-cache \
    ncurses-dev \
    git \
    build-base \
    autoconf \
    automake \
    && git clone --depth 1 https://github.com/abishekvashok/cmatrix \
    && cd cmatrix \
    && autoreconf -i \
    && ./configure \
    && make \
    && make install \
    && addgroup cmatrix \
    && adduser -G cmatrix -s /bin/sh -D cmatrix

FROM alpine:edge

RUN apk upgrade && apk add --no-cache \
    ncurses

COPY --from=builder /usr/local/bin/cmatrix /usr/local/bin/cmatrix
COPY --from=builder /etc/passwd /etc/passwd

USER cmatrix

ENTRYPOINT ["/usr/local/bin/cmatrix"]
