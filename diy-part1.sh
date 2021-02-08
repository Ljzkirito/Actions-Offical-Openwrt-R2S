#!/bin/bash
#
# Copyright (c) 2019-2020 P3TERX <https://p3terx.com>
#
# This is free software, licensed under the MIT License.
# See /LICENSE for more information.
#
# https://github.com/P3TERX/Actions-OpenWrt
# File name: diy-part1.sh
# Description: OpenWrt DIY script part 1 (Before Update feeds)
#

# Add a feed source
sed -i '$a src-git helloworld https://github.com/fw876/helloworld' feeds.conf.default

#关机（增加关机功能）
sed -i '$a src-git poweroff https://github.com/esirplayground/luci-app-poweroff.git' feeds.conf.default

mkdir package/diy
# 获取luci-app-passwall以及缺失的依赖
pushd package/diy
svn co https://github.com/xiaorouji/openwrt-passwall/trunk/luci-app-passwall
svn co https://github.com/xiaorouji/openwrt-passwall/trunk/ssocks
svn co https://github.com/xiaorouji/openwrt-passwall/trunk/trojan-go
svn co https://github.com/xiaorouji/openwrt-passwall/trunk/trojan-plus
svn co https://github.com/xiaorouji/openwrt-passwall/trunk/brook
svn co https://github.com/xiaorouji/openwrt-passwall/trunk/chinadns-ng
popd
# Add luci-app-adguardhome
svn co https://github.com/Lienol/openwrt/trunk/package/diy/luci-app-adguardhome package/diy/luci-app-adguardhome
# Add luci-app-diskman
#git clone --depth=1 https://github.com/SuLingGG/luci-app-diskman package/lean/luci-app-diskman
#mkdir package/lean/parted
#cp package/lean/luci-app-diskman/Parted.Makefile package/lean/parted/Makefile
# Add luci-theme-argon
git clone --depth=1 https://github.com/jerrykuku/luci-theme-argon package/diy/luci-theme-argon
git clone --depth=1 https://github.com/jerrykuku/luci-app-argon-config package/diy/luci-app-argon-config
