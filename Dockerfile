# https://github.com/ipxe/ipxe.git
FROM centos:centos8
#FROM registry.access.redhat.com/ubi8/ubi
# set labels for metadata
LABEL maintainer="Oliver Guggenbuehl<info@containerize.ch>" \
  name="ipxe" \
  description="Container for building ipxe iso images" \
  summary="container for building ipxe"

ENV TZ=Europe/Zurich \
    TERM=xterm

WORKDIR /ipxe

RUN RPMS="gcc binutils make perl xz xz-libs* xz-devel mtools mkisofs syslinux git" && \  
   yum install --setopt=tsflags=nodocs -y ${RPMS} && yum clean all && mkdir -p /ipxe && \
   cd /ipxe && git clone https://github.com/ipxe/ipxe.git
 
