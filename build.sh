IMAGENAME=ocp-coreos-ipxe
VERSION=v1
docker build  -t bigg01/${IMAGENAME}:${VERSION} .
#docker build --no-cache -t bigg01/${IMAGENAME}:${VERSION} .
#docker push bigg01/${IMAGENAME}:${VERSION}
