#!/bin/bash

# 1. 强制进入 openwrt 目录（如果是从根目录运行）
[ -d openwrt ] && cd openwrt

# 2. 彻底清空现有的 helloworld 和 passwall 相关行
# 我们使用非常激进的匹配模式，确保彻底删干净旧的定义
sed -i '/helloworld/d' feeds.conf.default
sed -i '/passwall/d' feeds.conf.default

# 3. 添加新的插件源
# 注意：去掉所有分号和分支后缀，使用最标准的 src-git 格式
echo 'src-git helloworld https://github.com/fw876/helloworld.git' >> feeds.conf.default
echo 'src-git passwall https://github.com/xiaorouji/openwrt-passwall.git' >> feeds.conf.default
echo 'src-git passwall_packages https://github.com/xiaorouji/openwrt-passwall-packages.git' >> feeds.conf.default

# 4. (可选) 如果你还想要 sbwml 的优化版，请给它起一个不同的名字（例如 passwall_optim）
# 但建议第一次先用上面的 xiaorouji 官方源跑通。
