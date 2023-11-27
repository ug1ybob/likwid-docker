FROM ubuntu:mantic-20231011 AS builder

ARG likwid_tarball=http://ftp.fau.de/pub/likwid/likwid-5.3.0.tar.gz

RUN apt-get update
RUN apt-get install --no-install-recommends -y build-essential curl

WORKDIR /root
RUN curl -O $likwid_tarball && \
    mkdir -p /root/likwid && \
    tar -C /root/likwid --strip-components=1 -xaf likwid-*.tar.gz

WORKDIR /root/likwid
RUN make -j && make -j install

FROM ubuntu:mantic-20231011
COPY --from=builder /usr/local /usr/local
