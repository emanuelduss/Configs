Configs
=======

My personal configuration files.

etc (/etc)
----------
* `locale.conf`: Local-Specifit Settings
* `modprobe.d/eris.conf`: Modprobe Config for host `eris`
* `modules-load.d/virtualbox.conf`: Nötige Module für VirtualBox
* `netctl/enp0s25-dhcp`: Netctl Profile: Ethernet dhcp
* `netctl/wlp2s0-discordia`: Netctl Profile: WLAN WPA2
* `netctl/wlp2s0-HSR-Secure`: Netctl Profile: WLAN HSR
* `netctl/wlp2s0-HSR-WLAN`: Netctl Profile: WLAN HSR-WLAN (Excluded from `netctl-auto`)
* `network.d/eth0-dhcp`: Netcfg Profil: eth0 dhclient
* `network.d/eth0-static`: Netcfg Profil: eth0 statisch zu Hause
* `network.d/usb0-android`: Netcfg Profil: usb0 dhclient (Android Phone)
* `network.d/wlan0-discordia`: Netcfg Profil: wlan0 discordia dhclient
* `network.d/wlan0-hsr_secure`: Netcfg Profil: wlan0 HSR-Secure mit wpa\_supplicant dhclient
* `network.d/wlan0-HSR-WLAN`: Netcfg Profil: wlan0 HSR-WLAN dhcpcd
* `network.d/wlan0-sonnenbuehlstrasse`: Netcfg Profil: wlan0 sonnenbuehlstrasse dhcpcd
* `profile.d/libreoffice-common.sh`: LibreOffice Environment
* `profile.d/mpd.sh`: MPD Hostname and Password
* `resolv.conf`: Zu verwendende DNS-Server
* `slim.conf`: Slim Login Manager
* `systemd/logind.conf`: Systemd `logind.conf`
* `vconsole.conf`: Virtual Console Configuration
* `vpnc/hsr_remote.conf`: vpnc Konfigurationsdatei für die HSR
* `X11/xorg.conf.d/10-keymap.conf`: X11-Konfigurationsdatei für schweizer Tastaturlayout
* `X11/xorg.conf.d/20-trackpoint.conf`: X11-Konfigurationsdatei für ThinkPad Trackpoint

home (/home/username)
---------------------
* `.bash_profile`: Bash-Profile
* `.bashrc`: Konfigurationsdatei für die Bash
* `.conkyrc`: conky (Light-weight system monitor)
* `.exrc`: vi (Classic Unix text editor)
* `.gitconfig`: git (Version Control System)
* `.inputrc`: Readline Bibliothek (Usereingaben über Konsole einlesen)
* `.psqlrc`: PostgreSQL RC Script
* `.screenrc`: screen (screen manager)
* `.tmux.conf`: tmux (screen manager)
* `.vimrc`: Konfigurationsdatei für vim Texteditor
* `.Xdefaults`: Konfigurationsdatei fuer X-Anwendungen
* `.xinitrc`: Shell script which starts my windowmanager
* `.xbindkeysrc`: Konfigurationsdatei für xbindkeys
* `.xmodmaprc`: Konfigurationsdatei für xmodmap

* `.config/tint2/tint2rc`: Konfiguration für tint2 (Panel)
* `.config/user-dirs.dirs`: XDG Default Dirs

systemd (/lib/systemd)
----------------------
* `services/disablebluetooth.service`: systemd Service: Disable Bluetoot at start




