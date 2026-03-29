#!/bin/bash

# 1. 智能识别路径
[ -f feeds.conf.default ] && CONF_FILE="feeds.conf.default"
[ -f openwrt/feeds.conf.default ] && CONF_FILE="openwrt/feeds.conf.default"

# 2. 清理旧的重复项（确保文件是干净的）
sed -i '/helloworld/d' $CONF_FILE
sed -i '/passwall/d' $CONF_FILE

# 3. 添加新的插件源
# 使用最标准的 src-git 格式，不加分号，让系统自动抓取默认分支
echo 'src-git helloworld https://github.com/fw876/helloworld' >> $CONF_FILE

# 换回官方 PassWall 源，它对 ImmortalWrt 25.12 的兼容性最稳
echo 'src-git passwall https://github.com/xiaorouji/openwrt-passwall' >> $CONF_FILE
echo 'src-git passwall_packages https://github.com/xiaorouji/openwrt-passwall-packages' >> $CONF_FILE
