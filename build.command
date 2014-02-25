#!/bin/bash

# set for debug
# set -xv

TARGET=MacOSFullScreen

rm -f $TARGET

FLEX_SDK=/Users/booster/Documents/Flash/airsdk_4.0
ADT=$FLEX_SDK/bin/adt

echo $FLEX_SDK
echo $ADT

rm -rf build
mkdir -p build/mac

cp -r MacOS-x86/Output/$TARGET/Build/Products/Release/$TARGET.framework build/mac
cp as3-library/MacOS-x86/extension.xml build
cp as3-library/MacOS-x86/bin/$TARGET.swc build
unzip -o -q build/$TARGET.swc library.swf
mv library.swf build/mac

"$ADT" -package \
	-target ane $TARGET.ane build/extension.xml \
	-swc build/$TARGET.swc  \
	-platform MacOS-x86 \
	-C build/mac .
#	library.swf libIOSMightyLib.a
#	-platformoptions platformoptions.xml


if [ -f ./$TARGET.ane ];
then
    echo "SUCCESS"
	rm -rf build
else
    echo "FAILED"
fi
