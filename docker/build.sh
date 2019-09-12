#!/bin/bash
WORKDIR=/root/yocto
TARGET=/builded-images
pwd
ls -lah
source poky/oe-init-build-env
pwd
ls -lah ../
bitbake-layers add-layer ../meta-raspberrypi
bitbake-layers add-layer ../meta-openembedded/meta-oe
bitbake-layers add-layer ../meta-java
bitbake-layers add-layer ../meta-openembedded/meta-python
bitbake-layers add-layer ../meta-openembedded/meta-perl
bitbake-layers add-layer ../meta-openembedded/meta-multimedia
bitbake-layers add-layer ../meta-openembedded/meta-networking
#bitbake-layers add-layer ../meta-openembedded/meta-gnome
#bitbake-layers add-layer ../meta-openembedded/meta-xfce

sed -i 's/qemux86/raspberrypi3-64/g' conf/local.conf

cat >> conf/local.conf <<'EOL'
LICENSE_FLAGS_WHITELIST_append="commercial_faad2"
DISTRO_FEATURES_append=" polkit"
DL_DIR ?= "/home/yocto/downloads"
SSTATE_MIRRORS ?= "\
file://.* http://sstate.yoctoproject.org/dev/PATH;downloadfilename=PATH \n \
file://.* http://sstate.yoctoproject.org/2.6/PATH;downloadfilename=PATH \n \
file://.* http://sstate.yoctoproject.org/2.7/PATH;downloadfilename=PATH \n \
"

PREFERRED_PROVIDER_virtual/java-initial-native = "cacao-initial-native"
# Possible provider: cacao-native and jamvm-native
PREFERRED_PROVIDER_virtual/java-native = "cacao-native"
# Optional since there is only one provider for now
PREFERRED_PROVIDER_virtual/javac-native = "ecj-bootstrap-native"
IMAGE_INSTALL_append = " openjdk-8"
EOL

#cat conf/local.conf
#cat conf/bblayers.conf

#bitbake -s
#bitbake -k core-image-minimal
bitbake -k core-image-base
#bitbake -k core-image-sato
#bitbake -k core-image-minimal-xfce
#cp -r tmp/deploy/images/* $TARGET/