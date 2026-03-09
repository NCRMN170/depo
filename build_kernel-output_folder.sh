#!/bin/bash

OUT_DIR="$(pwd)/out"
LOG_FILE="$(pwd)/build.log"

# Hazırlık
[ -f "$LOG_FILE" ] && rm -f "$LOG_FILE"
mkdir -p "$OUT_DIR"

# Dizine gir
cd kernel || exit 1

# Değişkenler
export PATH="$HOME/kernel_build/bin:$PATH"
export CROSS_COMPILE=arm-linux-androideabi-
export ARCH=arm

# Derleme (16GB RAM ile paralel işlem)
make O="$OUT_DIR" a3a84g_defconfig 2>&1 | tee "$LOG_FILE"
make O="$OUT_DIR" -j$(nproc) zImage-dtb 2>&1 | tee -a "$LOG_FILE"
#make O="$OUT_DIR" -j1 zImage-dtb 2>&1 | tee -a "$LOG_FILE"    # for debug

# Basit Kontrol
if [ -f "$OUT_DIR/arch/arm/boot/zImage-dtb" ]; then
    echo "BAŞARILI: Kernel derlendi."
else
    echo "HATA: Derleme başarısız oldu!"
fi

read -n1 -s
