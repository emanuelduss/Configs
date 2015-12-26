Configs
=======

My personal configuration files.

etc (/etc)
----------
* `locale.conf`: Local-Specifit Settings
* `modprobe.d/eris.conf`: Modprobe Config for host `eris`
* `modules-load.d/iptables.conf`: Nötige Module für `iptables`
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
* `papersize`: System wide paper size configuration
* `profile.d/libreoffice-common.sh`: LibreOffice Environment
* `profile.d/mpd.sh`: MPD Hostname and Password
* `resolv.conf`: Zu verwendende DNS-Server
* `slim.conf`: Slim Login Manager
* `systemd/logind.conf`: Systemd `logind.conf`
* `sysctl.d/ipv6_tempaddr.conf`: Enables IPv6 Privacy Extensions
* `vconsole.conf`: Virtual Console Configuration
* `vpnc/hsr_remote.conf`: vpnc Konfigurationsdatei für die HSR
* `X11/xorg.conf.d/10-keyboard.conf`: X11 Keyboard Configuration
* `X11/xorg.conf.d/20-trackpoint.conf`: X11-Konfigurationsdatei für ThinkPad Trackpoint


home (/home/username)
---------------------
* `.bash_profile`: Bash-Profile
* `.bashrc`: Konfigurationsdatei für die Bash
* `.conkyrc`: conky (Light-weight system monitor)
* `.exrc`: vi (Classic Unix text editor)
* `.fehbg`: Set wallpaper using `feh`
* `..gdbinit`: gdb configuration file
* `.gitconfig`: git (Version Control System)
* `.inputrc`: Readline Bibliothek (Usereingaben über Konsole einlesen)
* `.i3status.conf`: i3status configuration
* `.psqlrc`: PostgreSQL RC Script
* `.screenrc`: screen (screen manager)
* `.tmux.conf`: tmux (screen manager)
* `.vimrc`: Konfigurationsdatei für vim Texteditor
* `.Xdefaults`: Konfigurationsdatei fuer X-Anwendungen
* `.xprofile`: Shell script which starts wit X11 login
* `.xbindkeysrc`: Konfigurationsdatei für xbindkeys
* `.xmodmaprc`: Konfigurationsdatei für xmodmap

* `.config/tint2/tint2rc`: Konfiguration für tint2 (Panel)
* `.config/user-dirs.dirs`: XDG Default Dirs
* `.config/openbox/menu.xml`: Openbox Menu Configuration
* `.config/openbox/menu_ssh.xml`: Openbox Menu SSH entries
* `.config/openbox/xdgmenu`: Generates XDG Menu for Openbox

systemd (/lib/systemd)
----------------------
* `services/disablebluetooth.service`: systemd Service: Disable Bluetoot at start


various
-------

* `grub_multiboot_stick/grub.cfg`: Multiboot USB Stick Grub Config

