#!/bin/bash
# set for debug
# set -xv

TARGET=MacOSFullScreen
TARGET64=MacOSFullScreen64

rm -f $TARGET

#FLEX_SDK=/Users/xtendx/Workspace/Alex/SDK/Flex4.14_AIR17_FP17
#FLEX_SDK=/Development/flex4.15_air20_fp20
FLEX_SDK="/Development/Flex 15.0 - AIR 20 - Flash Player 20"
ADT=$FLEX_SDK/bin/adt

echo $FLEX_SDK
echo $ADT

rm -rf build
mkdir -p build/mac

cp -r MacOS-x86-64/Output/$TARGET/Build/Products/Release/$TARGET.framework build/mac
cp as3-library/MacOS-x86-64/extension.xml build
cp as3-library/MacOS-x86-64/bin/$TARGET64.swc build
unzip -o -q build/$TARGET64.swc library.swf
mv library.swf build/mac

"$ADT" -package \
	-target ane $TARGET64.ane build/extension.xml \
	-swc build/$TARGET64.swc  \
	-platform MacOS-x86-64 \
	-C build/mac .
#	library.swf libIOSMightyLib.a
#	-platformoptions platformoptions.xml


if [ -f ./$TARGET64.ane ];
then
    echo "SUCCESS"
	rm -rf build
else
    echo "FAILED"
fi
