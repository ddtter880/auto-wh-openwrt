include $(TOPDIR)/rules.mk

PKG_NAME:=luci-app-whu-auth
PKG_VERSION:=1.0.0
PKG_RELEASE:=1

PKG_LICENSE:=MIT
PKG_MAINTAINER:=cccht

LUCI_TITLE:=WHU Campus Network Auto-Authentication
LUCI_DESCRIPTION:=Automatically authenticate to WuHan University campus network portal.
LUCI_DEPENDS:=+luci-base +curl

PKGARCH:=all

include $(INCLUDE_DIR)/package.mk

define Build/Compile
endef

define Package/luci-app-whu-auth/conffiles
/etc/config/whu-auth
endef

define Package/luci-app-whu-auth/install
	$(CP) ./root/* $(1)/
endef

$(eval $(call BuildPackage,luci-app-whu-auth))
