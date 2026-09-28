#!/bin/sh
# diy-part2.sh — 源码树定制(feeds install 之后、make 之前执行)

# 1) 默认管理 IP 改回小米原厂网段
sed -i 's/192\.168\.1\.1/192.168.31.1/g' package/base-files/files/bin/config_generate

# 2) MTK 闭源无线驱动: yuos-bit/other 的 mt/ (= 大雕 lede 18.06 时代 package/mtk)
git clone --depth 1 https://github.com/yuos-bit/other.git /tmp/yuosother
mkdir -p package/mtk
cp -r /tmp/yuosother/mt/* package/mtk/
rm -rf /tmp/yuosother

# 2a) 删 19.07+ 新栈目录:mtwifi-cfg 依赖 wifi-dats/datconf-lua,18.06 feed 没有这些包
rm -rf package/mtk/mtwifi-cfg package/mtk/datconf package/mtk/regs

# 2b) 删 ImmortalWrt 自带的 emortal/luci-app-mtwifi(依赖不存在的 kmod-mt_wifi);
#     改用 yuos 的 mt/luci-app-mtwifi(依赖 +mt_wifi,与拷入的配置包匹配)
rm -rf package/emortal/luci-app-mtwifi

# 2c) 删自带 package/kernel/mt-drivers(避免与 yuos 驱动重名/被默认勾选干扰)
rm -rf package/kernel/mt-drivers

echo "== package/mtk/drivers =="; ls package/mtk/drivers

# 3) 把 feed 里的 xray-core 钉到 v26.9.9
find feeds package -name Makefile 2>/dev/null | xargs grep -l 'PKG_NAME:=xray-core' 2>/dev/null | while read f; do
  sed -i 's/^PKG_VERSION:=.*/PKG_VERSION:=26.9.9/' "$f"
  echo "pinned xray-core -> 26.9.9 in $f"
done

echo "diy-part2 done"
