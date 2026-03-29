#!/bin/bash

# 1. 智能识别路径 (自动判断是否在 openwrt 目录下)
[ -f feeds.conf.default ] && CONF_FILE="feeds.conf.default"
[ -f openwrt/feeds.conf.default ] && CONF_FILE="openwrt/feeds.conf.default"

# 2. 清理旧的源，防止重复导致解析错误
sed -i '/helloworld/d' $CONF_FILE
sed -i '/passwall/d' $CONF_FILE

# 3. 添加新的插件源 (使用强制指定分支 main 的写法，解决 Username 报错)
echo 'src-git helloworld https://github.com/fw876/helloworld;main' >> $CONF_FILE
echo 'src-git passwall https://github.com/xiaorouji/openwrt-passwall;main' >> $CONF_FILE
echo 'src-git passwall_packages https://github.com/xiaorouji/openwrt-passwall-packages;main' >> $CONF_FILE

# 4. (可选) 如果官方源依然抽风，备用方案是换成同步率极高的镜像源
# echo 'src-git passwall https://github.com/sbwml/openwrt-passwall;main' >> $CONF_FILE
