# Yocto Embedded Java example

## Embedded Java minimal image for raspberry pi 3
Example how to build minimal size bootable image for raspberry pi 3 with installed openjdk-8 Java programming language, used yocto project.
git branch warrior
DISTRO_VERSION 2.7.1
SSTATE_MIRRORS sstate.yoctoproject.org/2.7.1
```sh
mkdir -p downloads builded-images;chmod 777 downloads builded-images
docker build -f docker/embedded-java-minimal-example/Dockerfile -t embedded-java docker/embedded-java-minimal-example
docker run --rm -it -v $(pwd)/downloads:/downloads -v $(pwd)/builded-images --name embedded-java embedded-java
```

## How to install Docker
https://docs.docker.com/install