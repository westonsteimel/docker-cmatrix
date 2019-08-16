ARG CMATRIX_VERSION="master"

FROM alpine:edge as builder

ARG CMATRIX_VERSION
ENV CMATRIX_VERSION "${CMATRIX_VERSION}"

RUN apk upgrade && apk add --no-cache \
    ncurses-dev \
    git \
    build-base \
    autoconf \
    automake \
    && git clone --branch "${CMATRIX_VERSION}" --depth 1 https://github.com/abishekvashok/cmatrix \
    && cd cmatrix \
    && autoreconf -i \
    && ./configure \
    && make \
    && make install \
    && addgroup cmatrix \
    && adduser -G cmatrix -s /bin/sh -D cmatrix

FROM scratch

ARG CMATRIX_VERSION

COPY --from=builder /lib/ld-musl-x86_64.so.1 /lib/ld-musl-x86_64.so.1
COPY --from=builder /usr/lib/libncursesw.so.6 /usr/lib/libncursesw.so.6
COPY --from=builder /etc/terminfo /etc/terminfo
COPY --from=builder /usr/share/terminfo /usr/share/terminfo
COPY --from=builder /usr/local/bin/cmatrix /usr/local/bin/cmatrix
COPY --from=builder /etc/passwd /etc/passwd

USER cmatrix

ENTRYPOINT ["/usr/local/bin/cmatrix"]

LABEL org.opencontainers.image.title="cmatrix" \
    org.opencontainers.image.description="cmatrix in Docker" \  
    org.opencontainers.image.url="https://github.com/westonsteimel/docker-cmatrix" \ 
    org.opencontainers.image.source="https://github.com/westonsteimel/docker-cmatrix" \
    org.opencontainers.image.version="${CMATRIX_VERSION}"

