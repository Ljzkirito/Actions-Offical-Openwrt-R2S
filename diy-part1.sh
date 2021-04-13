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

mkdir package/diy
#关机（增加关机功能）
git clone --depth=1 https://github.com/esirplayground/luci-app-poweroff package/diy/luci-app-poweroff
# 获取luci-app-ssr-plus缺失的依赖
pushd package/diy
svn co https://github.com/coolsnowwolf/lede/trunk/package/lean/shadowsocksr-libev
svn co https://github.com/coolsnowwolf/lede/trunk/package/lean/pdnsd-alt
svn co https://github.com/coolsnowwolf/lede/trunk/package/lean/microsocks
svn co https://github.com/coolsnowwolf/lede/trunk/package/lean/dns2socks
svn co https://github.com/coolsnowwolf/lede/trunk/package/lean/simple-obfs
svn co https://github.com/coolsnowwolf/lede/trunk/package/lean/v2ray-plugin
svn co https://github.com/coolsnowwolf/lede/trunk/package/lean/trojan
svn co https://github.com/coolsnowwolf/lede/trunk/package/lean/ipt2socks
svn co https://github.com/coolsnowwolf/lede/trunk/package/lean/redsocks2
popd
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
# Add luci-theme-argon
git clone --depth=1 https://github.com/jerrykuku/luci-theme-argon package/diy/luci-theme-argon
#git clone --depth=1 https://github.com/jerrykuku/luci-app-argon-config package/diy/luci-app-argon-config
# Change dnsmasq to dnsmasq-full
sed -i 's/dnsmasq/dnsmasq-full/g' include/target.mk
