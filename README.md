This is the initial work for some scripts that can generate cryptography manylinux1 wheels that work on (almost) any x86 or x86_64 linux machine.

To build the wheels clone this repository and run `./build_docker_image_and_wheels.sh`.

This is not yet mature. For example, the current openssldir set won't be the one your system has so you won't have any trust roots available. Since different linux distros keep their OpenSSL in different places it's unclear how to resolve this problem.
