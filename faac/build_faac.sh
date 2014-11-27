#!/bin/bash

# Set NDK to the full path to your NDK install
NDK="/home/dzhao2x/android-ndk-r8e"

DIR="/home/dzhao2x/android-ffmpeg-x264-faac-latest/"

export PATH=$PATH:$NDK:$DIR/toolchain/bin

ANDROID_CFLAGS="-DANDROID -D__ARM_ARCH_7__ -D__ARM_ARCH_7A__ -ffunction-sections -funwind-tables -Wno-psabi -march=armv7-a -mfloat-abi=softfp -mfpu=vfpv3-d16 -fomit-frame-pointer -fstrict-aliasing -funswitch-loops -Wa,--noexecstack -Os "
ANDROID_CXXFLAGS="-DANDROID -D__ARM_ARCH_7__ -D__ARM_ARCH_7A__ -ffunction-sections -funwind-tables -Wno-psabi -march=armv7-a -mfloat-abi=softfp -mfpu=vfpv3-d16 -fno-exceptions -fno-rtti -mthumb -fomit-frame-pointer -fno-strict-aliasing -finline-limit=64 -Wa,--noexecstack -Os "

PREFIX=arm-linux-androideabi-
export AR=${PREFIX}ar
export AS=${PREFIX}gcc
export CC=${PREFIX}gcc
export CXX=${PREFIX}g++
export LD=${PREFIX}ld
export NM=${PREFIX}nm
export RANLIB=${PREFIX}ranlib
export STRIP=${PREFIX}strip
export CFLAGS=${ANDROID_CFLAGS}
export CXXFLAGS=${ANDROID_CXXFLAGS}
export CPPFLAGS=${ANDROID_CPPFLAGS}

config_clean()
{
	make distclean &>/dev/null
	rm config.cache &>/dev/null
	rm config.log &>/dev/null
}

config_faac()
{
	echo -e "Configuring FAAC"
	config_clean
	./configure --host=arm-linux \
                --prefix=/home/dzhao2x/android-ffmpeg-x264-faac-latest/output \
                --disable-dependency-tracking \
                --disable-shared \
                --enable-static \
                --with-pic \
                --without-mp4v2
}

compile_faac()
{
	echo -e "Compiling FAAC"
    make clean
    make install
    cp -v libfaac/.libs/libfaac.a ../ffmpeg
}

config_faac
compile_faac
