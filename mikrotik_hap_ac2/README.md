# Mikrotik hAP ac² Profiles

## Idea

This repository contains some useful configurations for the Mikrotik hAP ac² I
use from time to time for testing purposes.

Please adjust the configuration to your needs and also **change the
credentials** for the admin interface and WiFi networks.

## Product Information

| Description  | Configuration                                                |
| ------------ | ------------------------------------------------------------ |
| Product Name | Mikrotik hAP ac²                                             |
| Product Page | https://mikrotik.com/product/hap_ac2                         |
| Architecture | 32 bit ARM                                                   |
| OS           | RouterOS (https://wiki.mikrotik.com/wiki/Manual:TOC)         |
| RAM          | 128 MB                                                       |
| Storage      | 16 MB Flash                                                  |
| Ethernet     | 5 x 10/100/1000 Mbps ports                                   |
| Wireless     | 2.4 GHz (300 Mbps), 802.11b/g/n<br />5 GHz (867 Mbps), 802.11a/n/ac |
| USB          | 1 port, can be used for tethering                            |
| Power        | 12-28 V input, max. 21 W                                     |

Image (source: https://mikrotik.com/product/hap_ac2#fndtn-gallery):

![Mikrotik hAP ac²](images/mikrotik_hap_ac2.png)

## Usage

Reset the RouterOS configuration:

1. unplug the device from power
2. press and hold the button right after applying power
3. hold the button until LED will start flashing
4. release the button to clear configuration

Connect your ethernet port (e.g. `eth0`) to the port `2` of the router.

Get a network configuration:

```
$ sudo ip link set dev eth0 up
$ sudo dhcpcd eth0 # or alternatively sudo dhclient eth0
dhcpcd-9.4.0 starting
DUID 00:04:72:00:e4:cc:34:85:11:b2:a8:5c:9c:8f:de:f5:73:f7
enp0s31f6: IAID 9d:b3:7e:ce
enp0s31f6: soliciting an IPv6 router
enp0s31f6: rebinding lease of 192.168.88.254
enp0s31f6: leased 192.168.88.254 for 600 seconds
enp0s31f6: adding route to 192.168.88.0/24
enp0s31f6: adding default route via 192.168.88.1
forked to background, child pid 1944315
```

Take the profile you want, modify it to your needs (IP addresses, credentials,
wifi name, ...) and upload it to the router via FTP:

```
$ curl -T wifi-nat-router ftp://admin:@192.168.88.1/flash/myconfig.rsc
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
100  5376    0     0  100  5376      0  86709 --:--:-- --:--:-- --:--:-- 88131
```

Connect to the router on `192.168.88.1` and login using the default credentials
(username `admin` / empty password):

```
$ telnet 192.168.88.1
Trying 192.168.88.1...
Connected to 192.168.88.1.
Escape character is '^]'.

MikroTik v6.45.8 (long-term)
Login: admin
Password: 

[...]
```

Perform a reset and apply the configuration:

```
[admin@MikroTik] > /system reset-configuration run-after-reset=flash/myconfig.rsc 
Dangerous! Reset anyway? [y/N]: 
y
system configuration will be reset
Connection closed by foreign host.
```

The router will reboot and the configuration will be applied. Enjoy.

## Profiles

### Ethernet Switch

| Description                       | Configuration                                             |
| --------------------------------- | --------------------------------------------------------- |
| Profile Name                      | `ethernet-switch`                                         |
| File                              | [ethernet-switch](profiles/ethernet-switch)               |
| Hostname                          | myrouter                                                  |
| Credentials                       | `admin:password`                                          |
| Mode                              | Bridge                                                    |
| Wireless                          | Disabled                                                  |
| Local Network<br />(Port `1`-`5)` | - IP Address: `10.5.23.1/24`<br />- Statically configured |

### WiFi Ethernet Switch

| Description                       | Configuration                                                |
| :-------------------------------- | ------------------------------------------------------------ |
| Profile Name                      | `wifi-ethernet-switch`                                       |
| File                              | [wifi-ethernet-switch](profiles/wifi-ethernet-switch)        |
| Hostname                          | myrouter                                                     |
| Credentials                       | `admin:password`                                             |
| Mode                              | Bridge                                                       |
| Wireless                          | - WiFi: Enabled<br />- SSID: `mywifi`<br />- Security: WPA2, AES/CCM<br />- Password: `wifipassword` |
| Local Network<br />(Port `1`-`5)` | - IP Address: `10.5.23.1/24`<br />- Statically configured    |

### NAT Router

| Description                       | Configuration                                                |
| --------------------------------- | ------------------------------------------------------------ |
| Profile Name                      | `nat-router`                                                 |
| File                              | [nat-router](profiles/nat-router)                            |
| Hostname                          | myrouter                                                     |
| Credentials                       | `admin:password`                                             |
| Mode                              | Router                                                       |
| Wireless                          | Disabled                                                     |
| Uplink<br />(Port `1`)            | - Address Acquisition: automatic (DHCP)<br />- MAC Address: `48:8F:5A:11:22:33` |
| Local Network<br />(Port `2`-`5)` | - Router IP Address: `10.5.23.1/24`<br />- DHCP server for client connections: `10.5.23.50-100` |

### WiFi NAT Router

| Description                       | Configuration                                                |
| --------------------------------- | ------------------------------------------------------------ |
| Profile Name                      | `wifi-nat-router`                                            |
| File                              | [wifi-nat-router](profiles/wifi-nat-router)                  |
| Hostname                          | myrouter                                                     |
| Credentials                       | `admin:password`                                             |
| Mode                              | Router                                                       |
| Wireless                          | - WiFi: Enabled<br />- SSID: `mywifi`<br />- Security: WPA2, AES/CCM<br />- Password: `wifipassword` |
| Uplink<br />(Port `1`)            | - Address Acquisition: automatic (DHCP)<br />- MAC Address: `48:8F:5A:11:22:33` |
| Local Network<br />(Port `2`-`5)` | - Router IP Address: `10.5.23.1/24`<br />- DHCP server for client connections: `10.5.23.50-100` |

### LTE NAT Router

| Description                       | Configuration                                                |
| --------------------------------- | ------------------------------------------------------------ |
| Profile Name                      | `lte-nat-router`                                             |
| File                              | [lte-nat-router](profiles/lte-nat-router)                    |
| Hostname                          | myrouter                                                     |
| Credentials                       | `admin:password`                                             |
| Mode                              | Router                                                       |
| USB                               | - USB: Enabled<br />- LTE Interface: Enabled<br />- Connect Mobile Phone via USB<br />- Address Acquisition: automatic (DHCP) |
| Wireless                          | Disabled                                                     |
| Local Network<br />(Port `1`-`5)` | - Router IP Address: `10.5.23.1/24`<br />- DHCP server for client connections: `10.5.23.50-100` |

### LTE WiFi NAT Router

| Description                       | Configuration                                                |
| --------------------------------- | ------------------------------------------------------------ |
| Profile Name                      | `lte-wifi-nat-router`                                        |
| File                              | [lte-wifi-nat-router](profiles/lte-wifi-nat-router)          |
| Hostname                          | myrouter                                                     |
| Credentials                       | `admin:password`                                             |
| Mode                              | Router                                                       |
| USB                               | - USB: Enabled<br />- LTE Interface: Enabled<br />- Connect Mobile Phone via USB<br />- Address Acquisition: automatic (DHCP) |
| Wireless                          | - WiFi: Enabled<br />- SSID: `mywifi`<br />- Security: WPA2, AES/CCM<br />- Password: `wifipassword` |
| Local Network<br />(Port `1`-`5)` | - Router IP Address: `10.5.23.1/24`<br />- DHCP server for client connections: `10.5.23.50-100` |

## Other Configurations

Export configuration:

```
[admin@myrouter] > export compact terse
```

Mirror `ether2` interface to `ether5` interface:

```
 [admin@myrouter] > /interface ethernet switch set numbers=0 mirror-source=ether2 mirror-target=ether5
```
