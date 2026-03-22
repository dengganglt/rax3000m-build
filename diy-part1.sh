#!/bin/bash
#
# https://github.com/P3TERX/Actions-OpenWrt
# File name: diy-part1.sh
# Description: OpenWrt DIY script part 1 (Before Update feeds)
#

# 1. 清理可能存在的重复项（防止多次执行产生冲突）
sed -i '/helloworld/d' feeds.conf.default
sed -i '/passwall/d' feeds.conf.default

# 2. 添加插件源（使用带 .git 后缀的完整 HTTPS 地址，提高兼容性）
# Helloworld 插件源
echo 'src-git helloworld https://github.com/fw876/helloworld.git' >>feeds.conf.default

# Passwall 插件源（主程序）
echo 'src-git passwall https://github.com/xiaorouji/openwrt-passwall.git' >>feeds.conf.default

# Passwall 依赖包源（必须添加，否则会缺少依赖导致编译失败）
echo 'src-git passwall_packages https://github.com/xiaorouji/openwrt-passwall-packages.git' >>feeds.conf.default
