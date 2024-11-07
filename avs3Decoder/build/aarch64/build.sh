#!/bin/bash

FF_ARCH=$1

mkdir -p ../../../libs/{arm64-v8a,armeabi-v7a,x86,x86_64}

if [ "$FF_ARCH" = "armv7a" ]; then
  make -f ./AVS3AudioDec_arm7_android.mk clean
  make -f ./AVS3AudioDec_arm7_android.mk
elif [ "$FF_ARCH" = "arm64" ]; then
  make -f ./AVS3AudioDec_arm_android.mk clean
  make -f ./AVS3AudioDec_arm_android.mk
elif [ "$FF_ARCH" = "x86" ]; then
  make -f ./AVS3AudioDec_x86_android.mk clean
  make -f ./AVS3AudioDec_x86_android.mk
elif [ "$FF_ARCH" = "x86_64" ]; then
  make -f ./AVS3AudioDec_x86-64_android.mk clean
  make -f ./AVS3AudioDec_x86-64_android.mk
else
    echo "unknown architecture $FF_ARCH";
    exit 1
fi

#cp -r ../../../libs/* ../../../../ffmpeg/ffmpeg-6.1/android-libs/
