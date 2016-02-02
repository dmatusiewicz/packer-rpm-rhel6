#!/bin/bash

set -e
NAME='packer.io'
URL='https://releases.hashicorp.com/packer/0.8.6/packer_0.8.6_linux_amd64.zip'
VERSION=${BUILD_NUMBER}
curl -k -L -o ${URL##*/} $URL || {
    echo $"URL or version not found!" >&2
    exit 1
}

mkdir -p packer/target/${NAME}/opt/packer
unzip -qq ${URL##*/} -d packer/target/${NAME}/opt/packer

/opt/ruby22/bin/fpm -s dir -t rpm -f \
	-C packer/target \
	-v ${VERSION} \
	-n ${NAME} \
	-p packer/target \
	-a amd64 \
        --rpm-ignore-iteration-in-dependencies \
        --description "Simple Packer RPM package for RedHat Enterprise Linux 6" \
        --url "https://github.com/dmatusiewicz/packer-rpm-rhel6" \
        opt/packer

