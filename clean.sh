#!/bin/bash


cd kernel && PATH=$HOME/kernel_build/bin:$PATH CROSS_COMPILE=arm-linux-androideabi- ARCH=arm make a3a84g_defconfig && PATH=$HOME/kernel_build/bin:$PATH CROSS_COMPILE=arm-linux-androideabi- ARCH=arm 

make -j$(nproc) mrproper

rm -f arch/arm/boot/zImage 
rm -f arch/arm/boot/zImage-dtb
rm -f arch/arm/boot/Image
rm -f arch/arm/boot/dts/a3a84g.dtb.merge
rm -f arch/arm/boot/dts/a3a84g.mdtb
rm -f arch/arm/boot/dts/a3a84g.mimg
rm -rf arch/arm/boot/dts/a3a84g

# .dtb ve .img uzantılı dosyaları sil
TARGET_DIR="arch/arm/boot/dts/"
find "$TARGET_DIR" -type f \( -iname "*.dtb" -o -iname "*.img" \) -exec rm -f {} \;

rm -rf ~/kernel_build/out

echo "İşlem tamamlandı. Devam etmek için bir tuşa basın..."
read -n1 -s

