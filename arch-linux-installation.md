# Set the console keyboard layout

The default [console keymap](https://wiki.archlinux.org/title/Console_keymap) is [US](https://en.wikipedia.org/wiki/File:KB_United_States-NoAltGr.svg). Available layouts can be listed with:
```bash
ls /usr/share/kbd/keymaps/**/*.map.gz
```
To set the keyboard layout, pass a corresponding file name to [loadkeys(1)](https://man.archlinux.org/man/loadkeys.1), omitting path and file extension. For example, to set a [German](https://en.wikipedia.org/wiki/File:KB_Germany.svg) keyboard layout:
```bash
loadkeys de-latin1
```
[Console fonts](https://wiki.archlinux.org/title/Console_fonts) are located in /usr/share/kbd/consolefonts/ and can likewise be set with [setfont(8)](https://man.archlinux.org/man/setfont.8).

# Verify the boot mode
To verify the boot mode, list the [efivars](https://wiki.archlinux.org/title/Efivars) directory:
```bash
ls /sys/firmware/efi/efivars
```
If the command shows the directory **without error**, then the system **is booted in UEFI mode**. If the directory does not exist, the system may be booted in [BIOS](https://en.wikipedia.org/wiki/BIOS) (or [CSM](https://en.wikipedia.org/wiki/Compatibility_Support_Module)) mode. If the system did not boot in the mode you desired, refer to your motherboard's manual.

# Connect to the internet

To set up a network connection in the live environment, go through the following steps:
- Ensure your [network interface](https://wiki.archlinux.org/title/Network_interface) is listed and enabled, for example with [ip-link(8)](https://man.archlinux.org/man/ip-link.8):
```bash
ip link
```
- For wireless and WWAN, make sure the card is not blocked with [rfkill](https://wiki.archlinux.org/title/Rfkill).
  - Connect to the network:
  - Ethernet—plug in the cable.
  - Wi-Fi—authenticate to the wireless network using [iwctl](https://wiki.archlinux.org/title/Iwctl).
  - Mobile broadband modem—connect to the mobile network with the [mmcli](https://wiki.archlinux.org/title/Mmcli) utility.
- Configure your network connection:
  - [DHCP](https://wiki.archlinux.org/title/DHCP): dynamic IP address and DNS server assignment (provided by [systemd-networkd](https://wiki.archlinux.org/title/Systemd-networkd) and [systemd-resolved](https://wiki.archlinux.org/title/Systemd-resolved)) should work out of the box for Ethernet, WLAN, and WWAN network interfaces.
  - Static IP address: follow [Network configuration#Static IP address](https://wiki.archlinux.org/title/Network_configuration#Static_IP_address).
- The connection may be verified with [ping](https://wiki.archlinux.org/title/Ping):
```bash
ping archlinux.org
```

## Connect to a Wireless Network
First, if you do not know your wireless device name, list all Wi-Fi devices:
```bash
iwctl device list
```

Then, to initiate a scan for networks (note that this command will not output anything):
```bash
iwctl station <device> scan
```

You can then list all available networks:
```bash
iwctl device list
```

```bash
iwctl device list
```

```bash
iwctl device list
```
