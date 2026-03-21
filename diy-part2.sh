#!/bin/bash
#
# https://github.com/P3TERX/Actions-OpenWrt
# File name: diy-part2.sh
# Description: OpenWrt DIY script part 2 (After Update feeds)
#
# Copyright (c) 2019-2024 P3TERX <https://p3terx.com>
#
# This is free software, licensed under the MIT License.
# See /LICENSE for more information.
#

# Modify default IP (kept as 192.168.1.1)
# sed -i 's/192.168.1.1/192.168.1.1/g' package/base-files/files/bin/config_generate

# Modify hostname to RAX3000M-1GB
sed -i 's/ImmortalWrt/RAX3000M-1GB/g' package/base-files/files/bin/config_generate

# Core: 1GB Memory Addressing Patch (精准匹配 memory 节点的 reg 参数)
# Official DTS default: <0x0 0x40000000 0x0 0x20000000> (512MB)
# Modified to: <0x0 0x40000000 0x0 0x40000000> (1GB)
find target/linux/mediatek/dts/ -name "*rax3000m*.dts" | xargs sed -i 's/<0x0 0x40000000 0x0 0x20000000>/<0x0 0x40000000 0x0 0x40000000>/g'

# Modify terminal banner
sed -i "s/OpenWrt /RAX3000M-1GB-$(date +%Y%m%d) /g" package/base-files/files/etc/banner

echo "Memory Patch Applied Success."
