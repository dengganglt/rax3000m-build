#!/bin/bash

# 1. 【解决身份不符】强行将固件机型名改为 rax3000m-emmc，对齐 U-Boot
# 这样做能让你在网页端直接升级，不用 -F，极大降低风险
sed -i 's/cmcc,rax3000me/cmcc,rax3000m-emmc/g' target/linux/mediatek/image/filogic.mk

# 2. 【1GB 内存补丁】针对 25.12 源码结构的精准修改
# 我们只修改对应的 DTS 文件，将 512MB (0x20000000) 提升至 1GB (0x40000000)
DTS_FILE="target/linux/mediatek/dts/mt7981b-cmcc-rax3000m-emmc.dts"
if [ -f "$DTS_FILE" ]; then
    sed -i 's/<0x0 0x40000000 0x0 0x20000000>/<0x0 0x40000000 0x0 0x40000000>/g' $DTS_FILE
    echo "1GB RAM DTS patch applied to $DTS_FILE"
fi

# 3. 定制主机名
sed -i 's/ImmortalWrt/RAX3000M-1GB/g' package/base-files/files/bin/config_generate

# 4. 设置默认密码为 password
sed -i 's/root:::0:99999:7:::/root:$1$V4UetPzk$CYXluq4wUazHjmCDBCqXF.:0:99999:7:::/g' package/base-files/files/etc/shadow
