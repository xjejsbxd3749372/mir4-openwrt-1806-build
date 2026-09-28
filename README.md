# Xiaomi Mi Router 4 — ImmortalWrt openwrt-18.06 云编译

- 基座: ImmortalWrt `openwrt-18.06`(内核 4.14,含 `xiaomi_mir4` 双分区 kernel1/rootfs0 镜像)
- WiFi 闭源驱动: `yuos-bit/other` 的 `mt/`(= 大雕 lede 旧版 package/mtk:mt_wifi 2.1.1.0,
  mt7603e + mt7612e 完整源码 + luci-app-mtwifi + uci2dat),由 diy-part2.sh 自动拷入
- 插件: PassWall(Leslie-Wong 18.06 移植线)、SSR-Plus(P0lari5 大雕末代镜像)、xray-core 钉到 **v26.9.9**

## 使用
1. Fork 本仓库,Actions 页面 Run workflow(可勾选 ssh 调试)。
2. 产物在 artifact `openwrt-mir4-18.06`:`openwrt-ramips-mt7621-xiaomi_mir4-squashfs-kernel1.bin` / `-rootfs0.bin`。
3. 小米4 原厂 stok 开 root 后:
   `mtd write kernel1.bin kernel1 && mtd write rootfs0.bin rootfs0 && nvram set flag_try_sys1_failed=1 && nvram commit && reboot`
4. 进 OpenWrt 后用同目录 sysupgrade.bin 收敛。
5. 装 xray 26.9.9:下载 `Xray-linux-mips32le.zip`,见主对话脚本。

## 已知风险
- Leslie-Wong passwall 线是 18.06/k5.4 时代移植,个别依赖(chinadns-ng/tproxy)可能需要在 feed 里降级或删掉对应 CONFIG 行——编译失败时用 ssh 模式进 Actions 现场修 `.config`。
- 若只想省事:passwall 官方现行版 + 全套新核心需要 21.02+,对应 ImmortalWrt `openwrt-21.02` 分支(同样有 mir4);把 workflow 里 REPO_BRANCH 改掉即可,但内核 5.4,闭源 mt_wifi 不可用。
