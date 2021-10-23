这里只要模仿openwrt的/etc目录修改配置文件就可以了，下面对这些目录及文件作简单说明：

|   路径    | 备注说明   |
| :-----------------: | :-------------: |
|/www/|luci web页面的目录。|
|/etc/banner|命令行登陆Openwrt的欢迎信息|
|/etc/opkg.conf|Openwrt的opkg更新源配置文件|
|/etc/profile|系统环境变量|
|/etc/dnsmasq.conf|Dns解析配置文件|
|/etc/config/dhcp|Dhcp服务配置文件|
|/etc/config/firewall|防火墙配置文件|
|/etc/config/fstab|文件系统挂载配置文件|
|/etc/config/luci|Luci界面配置文件|
|/openwrt/trunk/package/base-files/files/etc/config/system|系统主机名、时区、NTP及LED配置文件|
|/etc/config/wireless|无线配置文件|
