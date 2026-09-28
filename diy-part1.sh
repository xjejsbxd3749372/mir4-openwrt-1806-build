#!/bin/sh
# diy-part1.sh — feeds 定制(在 ./scripts/feeds update 之前执行)

# 换国内源加速(可选,注释掉即用官方)
sed -i 's|https://downloads.openwrt.org|https://mirrors.nju.edu.cn/openwrt|g' feeds.conf.default 2>/dev/null || true

# PassWall 18.06 兼容线 + SSR-Plus 镜像 + xray 等组件
# 注意:18.06 不能用 PassWall 上游 main(只支持 21.02+),这里用 small8 系移植
cat >> feeds.conf.default <<'EOF'
src-git passwall1806 https://github.com/Leslie-Wong/luci-app-passwall-18.06-k5.4.git;main
src-git ssrplus https://github.com/P0lari5/luci-app-ssr-plus.git;master
EOF
