#!/bin/bash
#===============================================================
#  OpenWrt 官方源码 + 个人第三方插件（共 4 个）
#  1. luci-app-adguardhome        – kongfl888
#  2. luci-theme-argon            – msylgj/randomPic
#  3. luci-app-accesscontrol-plus – kingyond
#  其余保持官方纯净
#===============================================================

clear

### 1. 基础优化（官方）###
sed -i 's/Os/O2/g' include/target.mk
./scripts/feeds update -a
./scripts/feeds install -a

### 2. 个人插件 ###
# 2.1 AdGuardHome
git clone --depth=1 https://github.com/kongfl888/luci-app-adguardhome package/luci-app-adguardhome

# 2.2 Argon 主题（随机壁纸）
rm -rf feeds/luci/themes/luci-theme-argon
git clone -b randomPic --depth 1 https://github.com/msylgj/luci-theme-argon.git feeds/luci/themes/luci-theme-argon

# 2.3 访问控制增强版
git clone --depth=1 https://github.com/kingyond/luci-app-accesscontrol-plus package/luci-app-accesscontrol-plus

### 3. 默认细节（官方文件）###
build_date=$(date +%Y.%m.%d)
sed -i "s/%D %V %C/Built by Situ(${build_date})@%D %V %C/g" package/base-files/files/usr/lib/os-release
sed -i "/%D/a\ Built by Situ(${build_date})" package/base-files/files/etc/banner
sed -i 's/1608/1800/g; s/2016/2208/g; s/1512/1608/g' package/emortal/cpufreq/files/cpufreq.uci

### 4. 清理 ###
find ./ -name '*.orig' -o -name '*.rej' -delete
rm -f .config

exit 0
