# 1. Set the console keyboard layout

The default [console keymap](https://wiki.archlinux.org/title/Console_keymap) is [US](https://en.wikipedia.org/wiki/File:KB_United_States-NoAltGr.svg). Available layouts can be listed with:
```bash
ls /usr/share/kbd/keymaps/**/*.map.gz
```
To set the keyboard layout, pass a corresponding file name to [loadkeys(1)](https://man.archlinux.org/man/loadkeys.1), omitting path and file extension. For example, to set a [German](https://en.wikipedia.org/wiki/File:KB_Germany.svg) keyboard layout:
```bash
loadkeys de-latin1
```
[Console fonts](https://wiki.archlinux.org/title/Console_fonts) are located in /usr/share/kbd/consolefonts/ and can likewise be set with [setfont(8)](https://man.archlinux.org/man/setfont.8).

# 2. Verify the boot mode
To verify the boot mode, list the [efivars](https://wiki.archlinux.org/title/Efivars) directory:
```bash
ls /sys/firmware/efi/efivars
```
If the command shows the directory **without error**, then the system **is booted in UEFI mode**. If the directory does not exist, the system may be booted in [BIOS](https://en.wikipedia.org/wiki/BIOS) (or [CSM](https://en.wikipedia.org/wiki/Compatibility_Support_Module)) mode. If the system did not boot in the mode you desired, refer to your motherboard's manual.

# 3. Connect to the internet

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

> __Note__:
> In the installation image, [systemd-networkd](https://wiki.archlinux.org/title/Systemd-networkd), [systemd-resolved](https://wiki.archlinux.org/title/Systemd-resolved), [iwd](https://wiki.archlinux.org/title/Iwd) and [ModemManager](https://wiki.archlinux.org/title/ModemManager) are preconfigured and enabled by default. That will not be the case for the installed system.


## 3.1 Connect to a Wireless Network
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
iwctl station <device> get-networks
```

Finally, to connect to a network:
```bash
iwctl station <device> connect <SSID>
```

If a passphrase is required, you will be prompted to enter it. Alternatively, you can supply it as a command line argument:
```bash
iwctl --passphrase <passphrase> station <device> connect <SSID>
```

### 3.1.1. Show device and connection information

To display the details of a WiFi device, like MAC address:
```bash
iwctl device <device> show
```

To display the connection state, including the connected network of a Wi-Fi device:
```bash
iwctl station <device> show
```

# 4. Update the system clock
In the live environment [systemd-timesyncd](https://wiki.archlinux.org/title/Systemd-timesyncd) is enabled by default and time will be synced automatically once a connection to the internet is established.
Use [timedatectl(1)](https://man.archlinux.org/man/timedatectl.1) to ensure the system clock is accurate:
```bash
timedatectl status
```

To enable Network Time Protocols (NTP) and allow the system to update the time via the Internet:
```bash
timedatectl set-ntp true
```

# 5. Partition the disks
When recognized by the live system, disks are assigned to a [block device](https://wiki.archlinux.org/title/Block_device) such as `/dev/sda`, `/dev/nvme0n1` or `/dev/mmcblk0`. To identify these devices, use [lsblk](https://wiki.archlinux.org/title/Lsblk) or [fdisk](https://wiki.archlinux.org/title/fdisk).
```bash
fdisk -l
```

Results ending in `rom`, `loop` or `airoot` may be ignored.

The following [partitions](https://wiki.archlinux.org/title/Partition) are required for a chosen device:
- One partition for the [root directory](https://en.wikipedia.org/wiki/Root_directory) `/`.
- For booting in [UEFI](https://wiki.archlinux.org/title/UEFI) mode: an [EFI system partition](https://wiki.archlinux.org/title/EFI_system_partition).
If you want to create any stacked block devices for [LVM](https://wiki.archlinux.org/title/LVM), [system encryption](https://wiki.archlinux.org/title/Dm-crypt) or [RAID](https://wiki.archlinux.org/title/RAID), do it now.

Use [fdisk](https://wiki.archlinux.org/title/fdisk) or [parted](https://wiki.archlinux.org/title/Parted) to modify partition tables. For example:
```bash
fdisk /dev/<the_disk_to_be_partitioned>
```

> __Note__:
> - If the disk does not show up, [make sure the disk controller is not in RAID mode](https://wiki.archlinux.org/title/Partitioning#Drives_are_not_visible_when_firmware_RAID_is_enabled).
> - If the disk from which you want to boot [already has an EFI system partition](https://wiki.archlinux.org/title/EFI_system_partition#Check_for_an_existing_partition), do not create another one, but use the existing partition instead.
> - [Swap](https://wiki.archlinux.org/title/Swap) space can be set on a [swap file](https://wiki.archlinux.org/title/Swap_file) for file systems supporting it.

## 5.1. Using fdisk

