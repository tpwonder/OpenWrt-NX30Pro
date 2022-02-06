#!/bin/bash
#
# Copyright (c) 2019-2020 P3TERX <https://p3terx.com>
#
# This is free software, licensed under the MIT License.
# See /LICENSE for more information.
#
# https://github.com/P3TERX/Actions-OpenWrt
# File name: diy-part2.sh
# Description: OpenWrt DIY script part 2 (After Update feeds)
#

###### Modify default IP
sed -i 's/192.168.1.1/192.168.1.2/g' package/base-files/files/bin/config_generate

###### Modify hostname
sed -i 's/OpenWrt/K2P/g' package/base-files/files/bin/config_generate

####### Modify the version number
sed -i "s/OpenWrt /复工快乐！Steven build from Lede $(TZ=UTC-8 date "+%Y.%m.%d") @ OpenWrt /g" package/lean/default-settings/files/zzz-default-settings

###### K2P 32M Support
sed -i 's/15744k/32128k/g' target/linux/ramips/image/mt7621.mk
sed -i 's/"Phicomm K2P";/"Phicomm K2P (32M)";/g' target/linux/ramips/dts/mt7621_phicomm_k2p.dts
sed -i 's/<80000000>/<10000000>/g' target/linux/ramips/dts/mt7621_phicomm_k2p.dts
sed -i 's/m25p,fast-read;/broken-flash-reset;/g' target/linux/ramips/dts/mt7621_phicomm_k2p.dts
sed -i 's/<0xa0000 0xf60000>/<0xa0000 0x1f60000>/g' target/linux/ramips/dts/mt7621_phicomm_k2p.dts

###### Set argon as default theme
sed -i 's/luci-theme-bootstrap/luci-theme-argon/g' feeds/luci/collections/luci/Makefile

###### Replace with JerryKuKu’s Argon
rm openwrt/package/lean/luci-theme-argon -rf #delete original argon theme
git clone -b 18.06 https://github.com/jerrykuku/luci-theme-argon.git  #repleace with JerryKuKu’s Argon
