#
# This software is licensed under the Public Domain.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=dawn
PKG_RELEASE:=1

PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=https://github.com/berlin-open-wireless-lab/DAWN.git
PKG_SOURCE_VERSION:=1a5509a0450dade79df5412b49a7267227140d92
PKG_MAINTAINER:=Nick Hainke <vincent@systemli.org>
CMAKE_INSTALL:=1

include $(INCLUDE_DIR)/package.mk
include $(INCLUDE_DIR)/cmake.mk

define Package/dawn
	SECTION:=net
	CATEGORY:=Network
	TITLE:=Decentralized wifi controller.
	MAINTAINER:=Nick Hainke <vincent@systemli.org>
	URL:=https://github.com/berlin-open-wireless-lab/DAWN.git
	DEPENDS:=$(DRV_DEPENDS) +libubus +libubox +libblobmsg-json +libuci +libgcrypt +libiwinfo +umdns
endef

define Package/dawn/description
	This package implements a decentralized wireless daemon.
endef

define Package/dawn/install
	$(INSTALL_DIR) $(1)/usr/sbin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/src/dawn $(1)/usr/sbin/dawn
	$(INSTALL_DIR) $(1)/etc/init.d
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/files/dawn.init $(1)/etc/init.d/dawn
	$(INSTALL_DIR) $(1)/etc/config
	$(INSTALL_CONF) $(PKG_BUILD_DIR)/files/dawn.config $(1)/etc/config/dawn
	$(INSTALL_DIR) $(1)/tmp
	$(INSTALL_CONF) $(PKG_BUILD_DIR)/files/mac_list $(1)/tmp/dawn_mac_list
endef

$(eval $(call BuildPackage,dawn))
