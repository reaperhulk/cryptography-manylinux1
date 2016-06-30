#!/bin/bash
set -xe

LIBFFI_URL="ftp://sourceware.org/pub/libffi"
LIBFFI_NAME="libffi-3.2.1"
LIBFFI_SHA256="d06ebb8e1d9a22d19e38d63fdb83954253f39bedc5d46232a05645685722ca37"

function check_sha256sum {
    local fname=$1
    local sha256=$2
    echo "${sha256}  ${fname}" > ${fname}.sha256
    sha256sum -c ${fname}.sha256
    rm ${fname}.sha256
}

curl -#O ${LIBFFI_URL}/${LIBFFI_NAME}.tar.gz
check_sha256sum ${LIBFFI_NAME}.tar.gz ${LIBFFI_SHA256}
tar zxvf ${LIBFFI_NAME}.tar.gz
cd ${LIBFFI_NAME}
#CFLAGS needed to override the Makefile and prevent -march optimization
#This flag set taken from Ubuntu 14.04's defaults
./configure --host=x86_64-linux-gnu --build=x86_64-linux-gnu CFLAGS="-g -O2 -fstack-protector --param=ssp-buffer-size=4 -Wformat -Werror=format-security"
make install
