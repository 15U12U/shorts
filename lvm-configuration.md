# LVM Configuration Guide
## Creating a LVM
### Identify the correct physical disk
```
$ sudo fdisk -l
# fdisk -l
```
---
### Create a new primary partition and change partiton type to Linux LVM
```
$ sudo fdisk /dev/<device_name>
# fdisk /dev/<device_name>
```
#### Example
```
$ sudo fdisk /dev/sdc
Command (m for help): n
Select (default p): p
Command (m for help): t
Hex Code: 8e
Command (m for help): p
Command (m for help): w

# fdisk /dev/sdc
Command (m for help): n
Select (default p): p
Command (m for help): t
Hex Code: 8e
Command (m for help): p
Command (m for help): w
```
---
### Create a new 'Physical Volume (PV)' using the newly created partition
```
$ sudo pvcreate /dev/<partition_name>
# pvcreate /dev/<partition_name>
```
#### Example
```
$ sudo pvcreate /dev/sdc1
# pvcreate /dev/sdc1
```
#### Verify the 'Physical Volume (PV)' creation
```
$ sudo pvscan; sudo pvs; sudo pvdisplay
# pvscan; pvs; pvdisplay
```
---
### Create a new 'Volume Group (VG)' using the newly created 'Physical Volume (PV)'
```
$ sudo vgcreate <volume_group_name> /dev/<partition_name>
# vgcreate <volume_group_name> /dev/<partition_name>
```
#### Example
```
$ sudo vgcreate vg-pool-1 /dev/sdc1
# vgcreate vg-pool-1 /dev/sdc1
```
#### Verify the 'Volume Group (VG)' creation
```
$ sudo vgscan; sudo vgs; sudo vgdisplay
# vgscan; vgs; vgdisplay
```
---
### Create a new linear 'Logical Volume (LV)' from the newly created 'Volume Group (VG)'
```
$ sudo lvcreate -L <logical_volume_size> -n <logical_volume_name> <volume_group_name>
# lvcreate -L <logical_volume_size> -n <logical_volume_name> <volume_group_name>
```
#### Example
```
$ sudo lvcreate -L 1G -n lv-linear vg-pool-1
# lvcreate -L 500M -n lv-linear vg-pool-1
```
#### Verify the 'Logical Volume (LV)' creation
```
$ sudo lvscan; sudo lvs; sudo lvdisplay
# lvscan; lvs; lvdisplay
```
---
### Format the newly created 'Logical Volume (LV)' to create the File System
```
$ sudo mkfs.ext4 /dev/<volume_group_name>/<logical_volume_name>
# mkfs.ext4 /dev/<volume_group_name>/<logical_volume_name>
```
#### Example
```
$ sudo mkfs.ext4 /dev/vg-pool-1/lv-linear
# mkfs.ext4 /dev/vg-pool-1/lv-linear
```
---

## Extending a LVM

