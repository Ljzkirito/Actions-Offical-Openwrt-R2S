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

# Modify default IP
sed -i 's/192.168.1.1/192.168.5.1/g' package/base-files/files/bin/config_generate
# 更改时区
sed -i "s/'UTC'/'CST-8'\n        set system.@system[-1].zonename='Asia\/Shanghai'/g" package/base-files/files/bin/config_generate
sed -i 's/0.openwrt.pool.ntp.org/ntp1.aliyun.com/g' package/base-files/files/bin/config_generate
sed -i 's/1.openwrt.pool.ntp.org/time1.cloud.tencent.com/g' package/base-files/files/bin/config_generate
sed -i 's/2.openwrt.pool.ntp.org/time.ustc.edu.cn/g' package/base-files/files/bin/config_generate
sed -i 's/3.openwrt.pool.ntp.org/cn.pool.ntp.org/g' package/base-files/files/bin/config_generate
# 修改 argon 为默认主题
sed -i 's/luci-theme-bootstrap/luci-theme-argon/g' feeds/luci/collections/luci/Makefile
# Custom miniupnp
sed -i 's/ipv6_disable\ 0/ipv6_disable\ 1/' feeds/packages/net/miniupnpd/files/miniupnpd.init                       #默认关闭ipv6
sed -i 's/ext_ip_reserved_ignore\ 0/ext_ip_reserved_ignore\ 1/' feeds/packages/net/miniupnpd/files/miniupnpd.init   #默认关闭保留地址检查
# Add po2lmo
git clone https://github.com/openwrt-dev/po2lmo.git
pushd po2lmo
make && sudo make install
popd
# Convert Translation
cp $GITHUB_WORKSPACE/convert-translation.sh .
chmod +x ./convert-translation.sh
./convert-translation.sh || true
# Remove upx
cp $GITHUB_WORKSPACE/remove-upx.sh .
chmod +x ./remove-upx.sh
./remove-upx.sh || true
