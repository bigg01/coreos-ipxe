# https://github.com/ipxe/ipxe.git
FROM centos:centos8
#FROM registry.access.redhat.com/ubi8/ubi
# set labels for metadata
LABEL maintainer="Oliver Guggenbuehl<info@containerize.ch>" \
  name="ipxe" \
  description="Container for compliance" \
  summary="container for building ipxe"

ENV TZ=Europe/Zurich \
    TERM=xterm


RUN RPMS="gcc binutils make perl liblzma or xz header files mtools mkisofs syslinux" \
   yum install --setopt=tsflags=nodocs -y $RPM && yum clean all && \
 
