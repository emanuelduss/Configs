Configs
=======

My personal configuration files.

etc
---
* `network.d/eth0-dhcp`: Netcfg Profil: eth0 dhclient
* `network.d/eth0-static`: Netcfg Profil: eth0 statisch zu Hause
* `network.d/usb0-android`: Netcfg Profil: usb0 dhclient (Android Phone)
* `network.d/wlan0-discordia`: Netcfg Profil: wlan0 discordia dhclient
* `network.d/wlan0-hsr_secure`: Netcfg Profil: wlan0 HSR-Secure mit wpa\_supplicant dhclient
* `network.d/wlan0-HSR-WLAN`: Netcfg Profil: wlan0 HSR-WLAN dhcpcd
* `network.d/wlan0-sonnenbuehlstrasse`: Netcfg Profil: wlan0 sonnenbuehlstrasse dhcpcd

* `vpnc/hsr_remote.conf`: vpnc Konfigurationsdatei für die HSR

* `X11/xorg.conf.d/10-keymap.conf`: X11-Konfigurationsdatei für schweizer Tastaturlayout
* `X11/xorg.conf.d/20-trackpoint.conf`: X11-Konfigurationsdatei für ThinkPad Trackpoint

home
----
* `.conkyrc`: conky (Light-weight system monitor)
* `.exrc`: vi (Classic Unix text editor)
* `.inputrc`: Readline Bibliothek (Usereingaben über Konsole einlesen)
* `.xinitrc`: Shell script which starts my windowmanager
* `.screenrc`: screen (screen manager)

systemd
-------
* `services/disablebluetooth.service`: systemd Service: Disable Bluetoot at start
