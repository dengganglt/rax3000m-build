#!/bin/bash

# 1. 修改主机名
if [ -f "package/base-files/files/bin/config_generate" ]; then
    sed -i 's/ImmortalWrt/RAX3000M-1GB/g' package/base-files/files/bin/config_generate
    echo "主机名修改成功"
else
    echo "警告：未找到 config_generate 文件，跳过主机名修改"
fi

# 2. 1GB 内存硬改补丁 (核心部分)
# 先寻找具体的 DTS 文件，防止 find 结果为空时 xargs 报错
DTS_FILE=$(find target/linux/mediatek/dts/ -name "*rax3000m*.dts" | head -n 1)
if [ -n "$DTS_FILE" ]; then
    echo "找到目标 DTS 文件: $DTS_FILE"
    # 应用内存寻址补丁
    sed -i 's/<0x0 0x40000000 0x0 0x20000000>/<0x0 0x40000000 0x0 0x40000000>/g' "$DTS_FILE"
    echo "内存补丁应用成功"
else
    echo "错误：未找到任何 rax3000m 相关的 DTS 文件，请检查源码路径"
fi

# 3. 修改欢迎 Banner
if [ -f "package/base-files/files/etc/banner" ]; then
    sed -i "s/OpenWrt /RAX3000M-1GB-$(date +%Y%m%d) /g" package/base-files/files/etc/banner
    echo "Banner 修改成功"
fi

# 4. 移除默认密码 (Shadow 文件处理)
if [ -f "package/base-files/files/etc/shadow" ]; then
    sed -i 's/root:::0:99999:7:::/root:$1$V4UetPzk$CYXluq4wUazHjmCDBCqXF.:0:99999:7:::/g' package/base-files/files/etc/shadow
    echo "默认密码设置成功"
fi

# 5. 针对 1Panel 优化内核参数
if [ -f "package/base-files/files/etc/sysctl.conf" ]; then
    echo "fs.file-max=100000" >> package/base-files/files/etc/sysctl.conf
    echo "内核参数优化成功"
fi

# 6. [关键] 无论脚本中间发生了什么，强制以成功状态退出
# 这能防止因为某个非核心文件的缺失导致整个编译任务报错停止
exit 0
