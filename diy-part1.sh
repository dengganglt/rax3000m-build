#!/bin/bash
# File name: diy-part1.sh
# Description: OpenWrt DIY script part 1 (Before Update feeds)

# 即使精简，也建议保留清理逻辑，防止云端缓存干扰
sed -i '/helloworld/d' feeds.conf.default
sed -i '/passwall/d' feeds.conf.default

# 如果你想加点别的（比如非常规的主题或特殊插件），可以在这里添加，否则，留空即可
