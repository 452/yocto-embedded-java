#!/bin/bash
rm -rf build/conf /builded-images/*
source poky/oe-init-build-env
bitbake-layers add-layer ../meta-raspberrypi
bitbake-layers add-layer ../meta-openembedded/meta-oe
bitbake-layers add-layer ../meta-java
bitbake-layers add-layer ../meta-openembedded/meta-python
bitbake-layers add-layer ../meta-openembedded/meta-networking

sed -i 's/qemux86/raspberrypi3-64/g' conf/local.conf

cat >> conf/local.conf <<'EOL'
LICENSE_FLAGS_WHITELIST_append="commercial_faad2"
DISTRO_FEATURES_append=" polkit"
DL_DIR ?= "/downloads"
SSTATE_MIRRORS ?= "\
file://.* http://sstate.yoctoproject.org/dev/PATH;downloadfilename=PATH \n \
file://.* http://sstate.yoctoproject.org/2.7.1/PATH;downloadfilename=PATH \n \
file://.* http://sstate.yoctoproject.org/2.8/PATH;downloadfilename=PATH \n \
"
PREFERRED_PROVIDER_virtual/java-initial-native = "cacao-initial-native"
PREFERRED_PROVIDER_virtual/java-native = "cacao-native"
PREFERRED_PROVIDER_virtual/javac-native = "ecj-bootstrap-native"
IMAGE_INSTALL_append = " openjdk-8"
EOL

bitbake -k core-image-minimal
cp -r tmp/deploy/images/* /builded-images
