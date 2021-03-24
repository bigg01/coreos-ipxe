IMAGENAME=ocp-coreos-ipxe
VERSION=v1
alias docker="podman"
docker build  -t quay.io/bigg01/coreos-ipxe/${IMAGENAME}:${VERSION} .
#docker build --no-cache -t bigg01/${IMAGENAME}:${VERSION} .
docker push quay.io/bigg01/coreos-ipxe/${IMAGENAME}:${VERSION}


docker build  -t quay.io/bigg01/coreos-ipxe/${IMAGENAME}:${VERSION} .
#docker build --no-cache -t bigg01/${IMAGENAME}:${VERSION} .
docker push quay.io/bigg01/coreos-ipxe/${IMAGENAME}:${VERSION}