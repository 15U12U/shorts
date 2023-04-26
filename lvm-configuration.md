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
$ sudo mount -a
# mount -a
```
---

## Extending a LVM
### Verify the available storage space in a 'Volume Group (VG)'
```
$ sudo vgs -S vgname=<volume_group_name> -o vg_free
# vgs -S vgname=<volume_group_name> -o vg_free
```
#### Example
```
$ sudo vgs -S vgname=vg-pool-1 -o vg_free
# vgs -S vgname=vg-pool-1 -o vg_free
```

> **Note**  
> Extending a 'Volume Group (VG)'
```
$ sudo vgextend <existing_volume_group_name> /dev/<partition_name>
# vgextend <existing_volume_group_name> /dev/<partition_name>

#### Example ###
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

### Extending a 'Logical Volume (LV)'
```
$ sudo lvextend -l +<FREE_LE> /dev/<volume_group_name>/<logical_volume_name>
# lvextend -l +<FREE_LE> /dev/<volume_group_name>/<logical_volume_name>

$ sudo lvextend -L <desired_size> /dev/<volume_group_name>/<logical_volume_name>
# lvextend -L <desired_size> /dev/<volume_group_name>/<logical_volume_name>

$ sudo lvextend -L +<additional_size> /dev/<volume_group_name>/<logical_volume_name>
# lvextend -L +<additional_size> /dev/<volume_group_name>/<logical_volume_name>

$ sudo lvextend -L +100%FREE /dev/<volume_group_name>/<logical_volume_name>
# lvextend -L +100%FREE /dev/<volume_group_name>/<logical_volume_name>
```
#### Example
```
## Increase the 'lv-linear' LV size with available Logical Extents (-l/--extents)
$ sudo lvextend -l +4720 /dev/vg-pool-1/lv-linear
# lvextend -l +4720 /dev/vg-pool-1/lv-linear

## Increase the 'lv-linear' LV size to 12 GB (-L/--size) [Assumption: 'lv-linear' LV's original size before extention is less than 12 GB]
$ sudo lvextend -L 12G /dev/vg-pool-1/lv-linear
# lvextend -L 12G /dev/vg-pool-1/lv-linear

## Increase the 'lv-linear' LV size by 1 GB (-L/--size)
$ sudo lvextend -L +1G /dev/vg-pool-1/lv-linear
# lvextend -L +1G /dev/vg-pool-1/lv-linear

## Increase the 'lv-linear' LV size to fill all of the unallocated space in the 'vg-pool-1' VG (-L/--size)
$ sudo lvextend -L +100%FREE /dev/vg-pool-1/lv-linear
# lvextend -L +100%FREE /dev/vg-pool-1/lv-linear

## Increase the 'lv-linear' LV size and resize the underlying file system with a single command (-r/--resizefs)
$ sudo lvextend -r -L 10G /dev/vg-pool-1/lv-linear
# lvextend -r -L 10G /dev/vg-pool-1/lv-linear
```
> **Note**  
> If the (-r/--resizefs) option was not used previously, the filesystem must be resized
```
$ sudo resize2fs /dev/<volume_group_name>/<logical_volume_name>
# resize2fs /dev/<volume_group_name>/<logical_volume_name>

### Example ###
$ sudo resize2fs /dev/vg-pool-1/lv-linear
# resize2fs /dev/vg-pool-1/lv-linear
```
---

## Reducing a LVM
```
$ sudo lvreduce -l -<FREE_LE> /dev/<volume_group_name>/<logical_volume_name>
# lvreduce -l -<FREE_LE> /dev/<volume_group_name>/<logical_volume_name>

$ sudo lvreduce -L <desired_size> /dev/<volume_group_name>/<logical_volume_name>
# lvreduce -L <desired_size> /dev/<volume_group_name>/<logical_volume_name>

$ sudo lvreduce -L -<reducing_size> /dev/<volume_group_name>/<logical_volume_name>
# lvreduce -L -<reducing_size> /dev/<volume_group_name>/<logical_volume_name>
```
#### Example
```
## Shrink the 'lv-linear' LV size by specific Logical Extents (-l/--extents)
$ sudo lvreduce -l -4720 /dev/vg-pool-1/lv-linear
# lvreduce -l -4720 /dev/vg-pool-1/lv-linear

## Shrink the 'lv-linear' LV size to 12 GB (-L/--size) [Assumption: 'lv-linear' LV's original size before reduction is more than 12 GB]
$ sudo lvreduce -L 12G /dev/vg-pool-1/lv-linear
# lvreduce -L 12G /dev/vg-pool-1/lv-linear

## Shrink the 'lv-linear' LV size by 1 GB  (-L/--size)
$ sudo lvreduce -L -1G /dev/vg-pool-1/lv-linear
# lvreduce -L -1G /dev/vg-pool-1/lv-linear

## Shrink the 'lv-linear' LV size and resize the underlying file system with a single command (-r/--resizefs)
$ sudo lvreduce -r -L 10G /dev/vg-pool-1/lv-linear
# lvreduce -r -L 10G /dev/vg-pool-1/lv-linear
```
> **Note**  
> If the (-r/--resizefs) option was not used previously, the filesystem must be resized
```
$ sudo resize2fs /dev/<volume_group_name>/<logical_volume_name>
# resize2fs /dev/<volume_group_name>/<logical_volume_name>

### Example ###
$ sudo resize2fs /dev/vg-pool-1/lv-linear
# resize2fs /dev/vg-pool-1/lv-linear
```
---

## Resizing a LVM
```
$ sudo lvresize -l (+/-)<FREE_LE> /dev/<volume_group_name>/<logical_volume_name>
# lvresize -l (+/-)<FREE_LE> /dev/<volume_group_name>/<logical_volume_name>

$ sudo lvresize -L <desired_size> /dev/<volume_group_name>/<logical_volume_name>
# lvresize -L <desired_size> /dev/<volume_group_name>/<logical_volume_name>

$ sudo lvresize -L (+/-)<reducing_size> /dev/<volume_group_name>/<logical_volume_name>
# lvresize -L (+/-)<reducing_size> /dev/<volume_group_name>/<logical_volume_name>
```
#### Example
```
## Shrink the 'lv-linear' LV size by specific Logical Extents (-l/--extents)
$ sudo lvresize -l -4720 /dev/vg-pool-1/lv-linear
# lvresize -l -4720 /dev/vg-pool-1/lv-linear

## Shrink/Increase the 'lv-linear' LV size to 12 GB (-L/--size) [Assumption: 'lv-linear' LV's original size before reduction is more than 12 GB/before extention is less than 12 GB]
$ sudo lvresize -L 12G /dev/vg-pool-1/lv-linear
# lvresize -L 12G /dev/vg-pool-1/lv-linear

## Increase the 'lv-linear' LV size by 1 GB  (-L/--size)
$ sudo lvresize -L +1G /dev/vg-pool-1/lv-linear
# lvresize -L +1G /dev/vg-pool-1/lv-linear

## Shrink/increase the 'lv-linear' LV size and resize the underlying file system with a single command (-r/--resizefs)
$ sudo lvresize -r -L 10G /dev/vg-pool-1/lv-linear
# lvresize -r -L 10G /dev/vg-pool-1/lv-linear
```
> **Note**  
> If the (-r/--resizefs) option was not used previously, the filesystem must be resized
```
$ sudo resize2fs /dev/<volume_group_name>/<logical_volume_name>
# resize2fs /dev/<volume_group_name>/<logical_volume_name>

### Example ###
$ sudo resize2fs /dev/vg-pool-1/lv-linear
# resize2fs /dev/vg-pool-1/lv-linear
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
