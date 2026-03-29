#!/bin/bash

# 1. 智能识别路径
[ -f feeds.conf.default ] && CONF_FILE="feeds.conf.default"
[ -f openwrt/feeds.conf.default ] && CONF_FILE="openwrt/feeds.conf.default"

# 2. 清理旧的源
sed -i '/helloworld/d' $CONF_FILE
sed -i '/passwall/d' $CONF_FILE

# 3. 添加插件源 (只保留一个 passwall 源)
echo 'src-git helloworld https://github.com/fw876/helloworld;main' >> $CONF_FILE

# 推荐：使用 sbwml 的优化版，他在 25.12 分支上通常更稳，包含了很多特定的修复
echo 'src-git passwall https://github.com/sbwml/openwrt-passwall;main' >> $CONF_FILE

# 注意：sbwml 的版本通常不需要额外的 passwall_packages，它会自动处理依赖
