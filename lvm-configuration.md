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
> **Note**  
> Removing a 'Physical Volume (PV)'
```
$ sudo pvremove /dev/<partition_name>
# pvremove /dev/<partition_name>

#### Example ###
$ sudo pvremove /dev/sdc1
# pvremove /dev/sdc1
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
### Mount the Formatted 'Logical Volume (LV)'
#### Append one of the following configuration lines to '/etc/fstab' (Note: Change the mounted device accordingly)
```
/dev/<volume_group_name>/<logical_volume_name>  /mnt/nfs_share  xfs   defaults  0 0
UUID=<Device_UUID>  /mnt/nfs_share  xfs   defaults  0 0
```
> **Note**  
> To get the correct UUID of the LV
```
$ sudo blkid /dev/<volume_group_name>/<logical_volume_name>
# blkid /dev/<volume_group_name>/<logical_volume_name>

### Example ###
$ sudo blkid /dev/vg-pool-1/lv-linear
# blkid /dev/vg-pool-1/lv-linear
```

#### Verify the mount is successful
```
mount -a
```
---

## Extending a LVM
### Add a new 'Physical Volume (PV)' to the existing 'Volume Group (VG)'
```
$ sudo vgextend <existing_volume_group_name> /dev/<partition_name>
# vgextend <existing_volume_group_name> /dev/<partition_name>
```
#### Example
```
$ sudo vgextend vg-pool-1 /dev/sdd1
# vgextend vg-pool-1 /dev/sdd1
```
> **Note**  
> Reducing a 'Volume Group (VG)'
```
$ sudo vgreduce <existing_volume_group_name> /dev/<partition_name>
# vgreduce <existing_volume_group_name> /dev/<partition_name>

### Example ###
$ sudo vgreduce vg-pool-1 /dev/sdd1
# vgreduce vg-pool-1 /dev/sdd1
```
> **Note**  
> Removing a 'Volume Group (VG)'
```
$ sudo vgremove <existing_volume_group_name>
# vgremove <existing_volume_group_name>

### Example ###
$ sudo vgremove vg-pool-1
# vgremove vg-pool-1
```
---

## Removing a LVM
```
$ sudo lvremove <volume_group_name>/<logical_volume_name>
# lvremove <volume_group_name>/<logical_volume_name>
```
#### Example
```
$ sudo lvremove vg-pool-1/lv-linear
# lvremove vg-pool-1/lv-linear
```
---




