NDK=/home/dzhao2x/android-ndk-r8e

PREBUILT=$NDK/toolchains/arm-linux-androideabi-4.4.3/prebuilt

PLATFORM=$NDK/platforms/android-8/arch-arm

PREFIX=/home/dzhao2x/android-ffmpeg-x264-faac-latest/output

./configure --prefix=$PREFIX \
            --enable-static \
            --enable-pic \
            --disable-asm \
            --disable-cli \
            --host=arm-linux \
            --cross-prefix=$PREBUILT/linux-x86_64/bin/arm-linux-androideabi- \
            --sysroot=$PLATFORM

make

make install
