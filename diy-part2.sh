#!/bin/sh
# diy-part2.sh — padavanonly/immortalwrt 定制(闭源驱动已在源码树内,无需外部注入)

# 1) 默认管理 IP 改回小米原厂网段
sed -i 's/192\.168\.1\.1/192.168.31.1/g' package/base-files/files/bin/config_generate

# 2) uci2dat: Nossiac/mtk-openwrt-feeds 提供(dat 配置转换工具)
git clone --depth 1 https://github.com/Nossiac/mtk-openwrt-feeds.git /tmp/nossiac
cp -r /tmp/nossiac/applications/uci2dat package/uci2dat
rm -rf /tmp/nossiac
ls package/uci2dat

# 3) xray-core 钉到 v26.9.9
find feeds package -name Makefile 2>/dev/null | xargs grep -l 'PKG_NAME:=xray-core' 2>/dev/null | while read f; do
  sed -i 's/^PKG_VERSION:=.*/PKG_VERSION:=26.9.9/' "$f"
  echo "pinned xray-core -> 26.9.9 in $f"
done

# 4) 确认闭源栈存在
ls package/emortal/mt-drivers
echo "diy-part2 done"
