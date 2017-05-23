#!/bin/bash
set -xe

OPENSSL_URL="https://www.openssl.org/source/"
OPENSSL_NAME="openssl-1.1.0e"
OPENSSL_SHA256="57be8618979d80c910728cfc99369bf97b2a1abd8f366ab6ebdee8975ad3874c"

function check_sha256sum {
    local fname=$1
    local sha256=$2
    echo "${sha256}  ${fname}" > ${fname}.sha256
    sha256sum -c ${fname}.sha256
    rm ${fname}.sha256
}

curl -#O ${OPENSSL_URL}/${OPENSSL_NAME}.tar.gz
check_sha256sum ${OPENSSL_NAME}.tar.gz ${OPENSSL_SHA256}
tar zxvf ${OPENSSL_NAME}.tar.gz
PATH=/opt/perl/bin:$PATH
cd ${OPENSSL_NAME}
if [[ $1 == "x86_64" ]]; then
    echo "Configuring for x86_64"
    ./Configure linux-x86_64 no-ssl2 no-comp enable-ec_nistp_64_gcc_128 shared --prefix=/usr/local --openssldir=/usr/local
else
    echo "Configuring for i686"
    ./Configure linux-generic32 no-ssl2 no-comp shared --prefix=/usr/local --openssldir=/usr/local
fi
make depend
make install
