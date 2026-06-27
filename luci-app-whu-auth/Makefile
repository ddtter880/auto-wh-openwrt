# LuCI App WHU Auth - WHU Campus Network Auto-Authentication
# Makefile for OpenWrt ipk package
# NOTE: This Makefile is intended for use inside the OpenWrt build system.

include $(TOPDIR)/rules.mk

PKG_NAME:=luci-app-whu-auth
PKG_VERSION:=1.0.0
PKG_RELEASE:=1

PKG_LICENSE:=MIT
PKG_MAINTAINER:=cccht

LUCI_TITLE:=LuCI WHU Auth - WHU Campus Network Auto-Authentication
LUCI_DESCRIPTION:=Automatically authenticate to WuHan University campus network portal
LUCI_DEPENDS:=+luci-base +curl +jsonfilter

include $(TOPDIR)/feeds/luci/luci.mk

# call BuildPackage - OpenWrt buildroot signature
