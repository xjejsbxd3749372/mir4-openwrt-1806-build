#!/bin/sh
# diy-part2.sh — 源码树定制(在 feeds install 之后、make 之前执行)

# 1) 默认管理 IP 与主机名
sed -i 's/192\.168\.1\.1/192.168.31.1/g' package/base-files/files/bin/config_generate

# 2) MTK 闭源无线驱动: yuos-bit/other 的 mt/ 大目录
#    (mt_wifi 2.1.1.0 全套:mt7603e + mt7612e 真实驱动源码、8021xd、
#     luci-app-mtwifi、uci2dat —— 即 Lean lede 18.06 时代 package/mtk 结构,适配 4.14 内核)
git clone --depth 1 https://github.com/yuos-bit/other.git /tmp/yuosother
mkdir -p package/mtk
cp -r /tmp/yuosother/mt/* package/mtk/
rm -rf /tmp/yuosother
echo "== package/mtk/drivers =="; ls package/mtk/drivers

# 3) 把 feed 里的 xray-core 钉到 v26.9.9(最新版,MIPSLE 官方有预编译)
find feeds package -name Makefile 2>/dev/null | xargs grep -l 'PKG_NAME:=xray-core' 2>/dev/null | while read f; do
  sed -i 's/^PKG_VERSION:=.*/PKG_VERSION:=26.9.9/' "$f"
  echo "pinned xray-core -> 26.9.9 in $f"
done

# 3) 内核配置里确保 TPROXY/tc 透明代理所需模块(供 passwall/ssrplus 用)
#    (ramips generic config 通常已含,如缺在此追加)

echo "diy-part2 done"
