#!/bin/bash

LOG_FILE="$(dirname "$0")/build.log"

# Önce eski log'u sil
if [ -f "$LOG_FILE" ]; then
    rm -f "$LOG_FILE"
fi

# Kernel dizinine gir
cd kernel || exit 1

# Ortam değişkenleri
export PATH="$HOME/kernel_build/bin:$PATH"
export CROSS_COMPILE=arm-linux-androideabi-
export ARCH=arm

# Defconfig + build (stdout ve stderr loglanır)
make a3a84g_defconfig 2>&1 | tee "$LOG_FILE"
make -j$(nproc) zImage-dtb 2>&1 | tee -a "$LOG_FILE"

echo "İşlem tamamlandı. Devam etmek için bir tuşa basın..."
read -n1 -s
