#!/bin/bash

NDK=/home/dzhao2x/android-ndk-r8e

PREBUILT=$NDK/toolchains/arm-linux-androideabi-4.4.3/prebuilt

PLATFORM=$NDK/platforms/android-8/arch-arm

PREFIX=/home/dzhao2x/android-ffmpeg-x264-faac-latest/output

./configure --target-os=linux \
            --prefix=$PREFIX \
            --enable-cross-compile \
            --enable-runtime-cpudetect \
            --disable-asm \
            --arch=arm \
            --cc=$PREBUILT/linux-x86_64/bin/arm-linux-androideabi-gcc \
            --cross-prefix=$PREBUILT/linux-x86_64/bin/arm-linux-androideabi- \
            --disable-stripping \
            --nm=$PREBUILT/linux-x86_64/bin/arm-linux-androideabi-nm \
            --sysroot=$PLATFORM \
            --enable-nonfree \
            --enable-version3 \
            --disable-everything \
            --enable-gpl \
            --disable-doc \
            --enable-avresample \
            --enable-demuxer=rtsp \
            --enable-muxer=rtsp \
            --disable-ffplay \
            --disable-ffserver \
            --enable-ffmpeg \
            --disable-ffprobe \
            --enable-libx264 \
            --enable-encoder=libx264 \
            --enable-decoder=h264 \
            --enable-libfaac \
            --enable-encoder=libfaac \
            --enable-decoder=acc \
            --enable-protocol=rtp \
            --enable-hwaccels \
            --enable-zlib \
            --disable-devices \
            --disable-avdevice \
            --extra-cflags="-I$PREFIX/include -fPIC -DANDROID -D__thumb__ -mthumb -Wfatal-errors -Wno-deprecated -mfloat-abi=softfp -mfpu=vfpv3-d16 -marm -march=armv7-a" \
            --extra-ldflags="-L$PREFIX/lib"

make clean

make -j4 install

$PREBUILT/linux-x86_64/bin/arm-linux-androideabi-ar d libavcodec/libavcodec.a inverse.o

$PREBUILT/linux-x86_64/bin/arm-linux-androideabi-ld -rpath-link=$PLATFORM/usr/lib -L$PLATFORM/usr/lib -L$PREFIX/lib  -soname libffmpeg.so -shared -nostdlib  -z,noexecstack -Bsymbolic --whole-archive --no-undefined -o $PREFIX/libffmpeg.so libavcodec/libavcodec.a libavfilter/libavfilter.a libavresample/libavresample.a libavformat/libavformat.a libavutil/libavutil.a libswscale/libswscale.a -lc -lm -lz -ldl -llog -lx264 -lfaac --warn-once --dynamic-linker=/system/bin/linker $PREBUILT/linux-x86_64/lib/gcc/arm-linux-androideabi/4.4.3/libgcc.a
