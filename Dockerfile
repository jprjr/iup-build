FROM ubuntu:18.04

FROM ubuntu:18.04

RUN apt-get update && \
    apt-get install -y mingw-w64 curl make patch build-essential git

RUN mkdir -p /src/iup
COPY . /src/iup/build
WORKDIR /src/iup/build

RUN \
    make TARGET=i686-w64-mingw32 && \
    make TARGET=i686-w64-mingw32 dist && \
    make TARGET=x86_64-w64-mingw32 && \
    make TARGET=x86_64-w64-mingw32 dist && \
    tar xzf output/lua-i686-w64-mingw32.tar.gz -C /usr/i686-w64-mingw32 && \
    tar xzf output/ftgl-i686-w64-mingw32.tar.gz -C /usr/i686-w64-mingw32 && \
    tar xzf output/freetype-i686-w64-mingw32.tar.gz -C /usr/i686-w64-mingw32 && \
    tar xzf output/zlib-i686-w64-mingw32.tar.gz -C /usr/i686-w64-mingw32 && \
    tar xzf output/im-i686-w64-mingw32.tar.gz -C /usr/i686-w64-mingw32 && \
    tar xzf output/cd-i686-w64-mingw32.tar.gz -C /usr/i686-w64-mingw32 && \
    tar xzf output/iup-i686-w64-mingw32.tar.gz -C /usr/i686-w64-mingw32 && \
    tar xzf output/lua-x86_64-w64-mingw32.tar.gz -C /usr/x86_64-w64-mingw32 && \
    tar xzf output/ftgl-x86_64-w64-mingw32.tar.gz -C /usr/x86_64-w64-mingw32 && \
    tar xzf output/freetype-x86_64-w64-mingw32.tar.gz -C /usr/x86_64-w64-mingw32 && \
    tar xzf output/zlib-x86_64-w64-mingw32.tar.gz -C /usr/x86_64-w64-mingw32 && \
    tar xzf output/im-x86_64-w64-mingw32.tar.gz -C /usr/x86_64-w64-mingw32 && \
    tar xzf output/cd-x86_64-w64-mingw32.tar.gz -C /usr/x86_64-w64-mingw32 && \
    tar xzf output/iup-x86_64-w64-mingw32.tar.gz -C /usr/x86_64-w64-mingw32 && \
    make TARGET=i686-w64-mingw32 clean && \
    make TARGET=x86_64-w64-mingw32 clean && \
    cd / && \
    rm -rf /src/iup

WORKDIR /

