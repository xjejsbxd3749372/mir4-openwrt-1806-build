#!/bin/sh
# diy-part2.sh — padavanonly/immortalwrt 定制

# 1) 默认管理 IP 改回小米原厂网段
sed -i 's/192\\.168\\.1\\.1/192.168.31.1/g' package/base-files/files/bin/config_generate

# 2) uci2dat: Nossiac/mtk-openwrt-feeds 提供(dat 配置转换工具)
if [ ! -d package/uci2dat ]; then
  git clone --depth 1 https://github.com/Nossiac/mtk-openwrt-feeds.git /tmp/nossiac
  cp -r /tmp/nossiac/applications/uci2dat package/uci2dat
  rm -rf /tmp/nossiac
fi
ls package/uci2dat

# 3) 闭源 MTK 驱动(已在 padavanonly 树内,仅确认)
ls package/emortal/mt-drivers

# 4) 移除 feed 里那个从源码编译的 xray-core(26.x 无 tarball,必 404),
#    改用 package/xray-core 预编译包
for f in $(find feeds -path '*xray-core/Makefile' 2>/dev/null); do
  echo "removing feed xray-core: $f"
  rm -rf "$(dirname $f)"
done
# 把本仓库的预编译包拷进 openwrt 树(package/ 不会被自动扫描)
mkdir -p package/xray-core
cp -f $GITHUB_WORKSPACE/package/xray-core/Makefile package/xray-core/Makefile
ls -la package/xray-core

echo "diy-part2 done"
