#!/bin/bash

# 1. 清理重复项（确保路径正确，ImmortalWrt 源码目录通常就是当前目录，如果你的 Actions 源码在 openwrt/ 文件夹下则保留）
sed -i '/helloworld/d' openwrt/feeds.conf.default
sed -i '/passwall/d' openwrt/feeds.conf.default

# 2. 添加插件源（使用更稳定的写法）
# 去掉 .git 并加上 ;main 分支标识，这是 Actions 环境下的“黄金写法”
echo 'src-git helloworld https://github.com/fw876/helloworld' >> openwrt/feeds.conf.default
echo 'src-git passwall https://github.com/xiaorouji/openwrt-passwall;main' >> openwrt/feeds.conf.default
echo 'src-git passwall_packages https://github.com/xiaorouji/openwrt-passwall-packages;main' >> openwrt/feeds.conf.default
