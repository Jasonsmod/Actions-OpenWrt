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


# 自定义固件设置
# rm -rf package/default-settings/files/zzz-default-settings
# cp -f ../zzz-default-settings package/lean/default-settings/files/
# Modify default IP
sed -i 's/192.168.1.1/192.168.50.1/g' package/base-files/files/bin/config_generate
sed -i "2i uci set vsftpd.@listen[0].enable4=0" ./package/lean/default-settings/files/zzz-default-settings    # 关闭FTP
sed -i "3i uci commit vsftpd" ./package/lean/default-settings/files/zzz-default-settings
#sed -i "4i echo "conf-dir=/etc/dnsmasq.d" >> /etc/dnsmasq.conf" ./package/lean/default-settings/files/zzz-default-settings #DNSMASQ 设置
#sed -i "5i uci set turboacc.config.sw_flow='1'" ./package/lean/default-settings/files/zzz-default-settings # 默认开启网络加速
#sed -i "6i uci set turboacc.config.hw_flow='1'" ./package/lean/default-settings/files/zzz-default-settings
#sed -i "7i uci set turboacc.config.fullcone_nat='1'" ./package/lean/default-settings/files/zzz-default-settings
#sed -i "8i uci set turboacc.config.bbr_cca='1'" ./package/lean/default-settings/files/zzz-default-settings
#sed -i "9i uci commit turboacc" ./package/lean/default-settings/files/zzz-default-settings


# 更新feeds文件
# sed -i 's#diy1 https://github.com/xiaorouji/openwrt-package#diy1 https://github.com/db-one/Lienol-openwrt-package#g' feeds.conf.default #更换默认包源
sed -i 's#src-git luci https://github.com/Lienol/openwrt-luci.git;17.01#src-git luci https://github.com/Lienol/openwrt-luci.git;19.07#g' feeds.conf.default #更换luci版本
cat feeds.conf.default

# 添加第三方软件包
git clone https://github.com/kenzok8/openwrt-packages package/openwrt-packages
git clone https://github.com/destan19/OpenAppFilter package/OpenAppFilter
git clone https://github.com/tty228/luci-app-serverchan package/luci-app-serverchan
git clone https://github.com/garypang13/luci-theme-edge package/luci-theme-edge -b 19.07

# 更新并安装源
./scripts/feeds clean
./scripts/feeds update -a && ./scripts/feeds install -a

# 替换更新passwall和ssrplus+
rm -rf package/openwrt-packages/luci-app-passwall && svn co https://github.com/xiaorouji/openwrt-package/trunk/lienol/luci-app-passwall package/openwrt-packages/luci-app-passwall
rm -rf package/openwrt-packages/luci-app-ssr-plus && svn co https://github.com/fw876/helloworld package/openwrt-packages/helloworld

# 为19.07添加libcap-bin依赖
rm -rf feeds/packages/libs/libcap
svn co https://github.com/openwrt/packages/trunk/libs/libcap feeds/packages/libs/libcap

# WIFI名为MAC后六位
# rm -rf package/kernel/mac80211/files/lib/wifi/mac80211.sh
# cp -f ../mac80211.sh package/kernel/mac80211/files/lib/wifi/

# 添加温度显示(By YYiiEt)
#sed -i 's/or "1"%>/or "1"%> ( <%=luci.sys.exec("expr `cat \/sys\/class\/thermal\/thermal_zone0\/temp` \/ 1000") or "?"%> \&#8451; ) /g' feeds/luci/modules/luci-mod-admin-full/luasrc/view/admin_status/index.htm

# 修改固件生成名字,增加当天日期(by:左右）
sed -i 's/IMG_PREFIX:=$(VERSION_DIST_SANITIZED)/IMG_PREFIX:=$(shell date +%Y%m%d)-$(VERSION_DIST_SANITIZED)/g' include/image.mk

# 修改版本号
#cid=$(date "+%Y-%m-%d")
#sed -i 's/R2020/R[${cid}]/g' package/lean/default-settings/files/zzz-default-settings

# 修改版本号
#sed -i 's/V2020/V${{ env.DATE }}/g' package/base-files/files/etc/banner
#


git clone https://github.com/BoringCat/luci-app-mentohust.git package/luci-app-mentohust
git clone https://github.com/KyleRicardo/MentoHUST-OpenWrt-ipk.git package/mentohust
git clone https://github.com/Lienol/openwrt-package.git

cd package/lean  
rm -rf luci-theme-argon  
git clone -b 18.06 https://github.com/jerrykuku/luci-theme-argon.git
git clone https://github.com/jerrykuku/luci-app-jd-dailybonus.git
git clone https://github.com/jerrykuku/lua-maxminddb.git  #git lua-maxminddb 依赖
#git clone https://github.com/jerrykuku/luci-app-vssr.git

git clone https://github.com/destan19/OpenAppFilter.git package/OpenAppFilter
# git clone https://github.com/OpenWrt-Actions/luci-app-serverchan.git package/luci-app-serverchan
# git clone https://github.com/OpenWrt-Actions/luci-app-adguardhome.git package/luci-app-adguardhome
# git clone https://github.com/vernesong/OpenClash package/luci-app-OpenClash
# git clone https://github.com/OpenWrt-Actions/smartdns.git package/smartdns
# git clone https://github.com/OpenWrt-Actions/luci-app-smartdns-compat.git package/luci-app-smartdns-compat
# svn co https://github.com/project-openwrt/openwrt/trunk/package/ctcgfw/luci-theme-atmaterial package/luci-theme-atmaterial
