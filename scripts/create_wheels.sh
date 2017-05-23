#!/bin/bash
set -x -e

for PYBIN in /opt/python/*/bin; do
    ${PYBIN}/pip install cffi
    ${PYBIN}/pip wheel cryptography -w wheelhouse/
done
exit

for whl in wheelhouse/cryptography*.whl; do
    auditwheel repair $whl -w /build/wheelhouse/
done

for PYBIN in /opt/python/*/bin/; do
    ${PYBIN}/pip install cryptography -f /build/wheelhouse
    ${PYBIN}/python -c "from cryptography.hazmat.backends.openssl.backend import backend;print('Loaded: ' + backend.openssl_version_text());print('Linked Against: ' + backend._ffi.string(backend._lib.OPENSSL_VERSION_TEXT).decode('ascii'))"
done
