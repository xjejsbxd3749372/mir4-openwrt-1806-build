#
# Xray-core 26.9.9 — prebuilt official binary (linux-mips32le)
# Upstream Xray-core does NOT publish a source tarball for 26.x; it ships
# prebuilt release binaries only. Building from the feed's PKG_SOURCE fails
# (codeload 403/404), so we consume the official release artifact instead.
#
include $(TOPDIR)/rules.mk

PKG_NAME:=xray-core
PKG_VERSION:=26.9.9
PKG_RELEASE:=1

PKG_SOURCE_URL:=https://github.com/XTLS/Xray-core/releases/download/v$(PKG_VERSION)
PKG_SOURCE:=Xray-linux-mips32le.zip
PKG_HASH:=e572d2cdd819318383460443140898e6117e8e0da5f0c359b25f6c890b8d81a2
PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)-$(PKG_VERSION)

PKG_MAINTAINER:=prebuilt
PKG_LICENSE:=MPL-2.0

include $(INCLUDE_DIR)/package.mk

define Package/xray-core
  SECTION:=net
  CATEGORY:=Network
  TITLE:=A platform for building proxies to bypass network restrictions
  URL:=https://xtls.github.io
  DEPENDS:=+ca-bundle
endef

define Package/xray-core/description
  Xray 26.9.9 official linux-mips32le release binary.
endef

define Build/Prepare
	mkdir -p $(PKG_BUILD_DIR)
	cd $(PKG_BUILD_DIR) && unzip -o $(DL_DIR)/$(PKG_SOURCE)
endef

define Build/Configure
endef

define Build/Compile
endef

define Package/xray-core/install
	$(INSTALL_DIR) $(1)/usr/bin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/xray $(1)/usr/bin/xray
endef

$(eval $(call BuildPackage,xray-core))
