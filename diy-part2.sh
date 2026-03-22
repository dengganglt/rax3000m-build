#!/bin/bash
#
# https://github.com/P3TERX/Actions-OpenWrt
# File name: diy-part2.sh
# Description: OpenWrt DIY script part 2 (After Update feeds)
#

# 1. 修改默认 IP (如果你想改成 192.168.10.1，取消下面一行的注释)
# sed -i 's/192.168.1.1/192.168.10.1/g' package/base-files/files/bin/config_generate

# 2. 修改主机名为 RAX3000M-1GB
sed -i 's/ImmortalWrt/RAX3000M-1GB/g' package/base-files/files/bin/config_generate

# 3. [核心] 1GB 内存硬改补丁
# 25.12 分支的 DTS 文件路径可能存在微调，使用更稳健的搜索替换
echo "正在应用 1GB 内存补丁..."
find target/linux/mediatek/dts/ -name "*rax3000m*.dts" | xargs -r sed -i 's/<0x0 0x40000000 0x0 0x20000000>/<0x0 0x40000000 0x0 0x40000000>/g'

# 4. 修改欢迎 Banner (显示编译日期和 1GB 标识)
sed -i "s/OpenWrt /RAX3000M-1GB-$(date +%Y%m%d) /g" package/base-files/files/etc/banner

# 5. [新增] 移除默认登录密码 (刷完直接进去，方便调试)
sed -i 's/root:::0:99999:7:::/root:$1$V4UetPzk$CYXluq4wUazHjmCDBCqXF.:0:99999:7:::/g' package/base-files/files/etc/shadow

# 6. [针对 1Panel] 优化内核参数以支持更多的 Docker 容器
# 提高文件句柄上限
echo "fs.file-max=100000" >> package/base-files/files/etc/sysctl.conf

echo "diy-part2 脚本执行完毕。"
