#!/bin/bash

# 1. 清理重复项（加上 openwrt/ 路径）
sed -i '/helloworld/d' openwrt/feeds.conf.default
sed -i '/passwall/d' openwrt/feeds.conf.default

# 2. 添加插件源（加上 openwrt/ 路径）
echo 'src-git helloworld https://github.com/fw876/helloworld.git' >> openwrt/feeds.conf.default
echo 'src-git passwall https://github.com/xiaorouji/openwrt-passwall.git' >> openwrt/feeds.conf.default
echo 'src-git passwall_packages https://github.com/xiaorouji/openwrt-passwall-packages.git' >> openwrt/feeds.conf.default
