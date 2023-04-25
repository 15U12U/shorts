# Server-side Configuration
## NFS Service
### Installing NFS Service
#### CentOS / Fedora / Rocky Linux / Oracle Linux / Red hat Enterprise Linux
```
$ sudo dnf install -y nfs-utils
# dnf install -y nfs-utils
```

### Enabling/Starting NFS Service
```
$ sudo systemctl start nfs-server.service
$ sudo systemctl enable nfs-server.service
# systemctl start nfs-server.service
# systemctl enable nfs-server.service
```


## Creating a NFS Share
### Create a new directory
```
$ sudo mkdir -p /mnt/nfs_share
# mkdir -p /mnt/nfs_share
```

### Creating a seperate volume as the NFS share (Note: This is optional)
##### Configure the physical volume suitable for Logical Volume creation
```
## Identify the correct physical volume
$ sudo fdisk -l
# fdisk -l

## Format the physical volume
$ sudo fdisk /dev/<device_name>
# fdisk /dev/<device_name>
### Example
$ sudo fdisk /dev/sdc
# fdisk /dev/sdc

## Create a new primary partition and change partiton type to Linux LVM
Command (m for help): n
Select (default p): p
Command (m for help): t
Hex Code: 8e
Command (m for help): p
Command (m for help): w

## Create a new 'Physical Volume (PV)' using the newly created partition
$ sudo pvcreate /dev/<partition_name>
# pvcreate /dev/<partition_name>
### Example
$ sudo pvcreate /dev/sdc1
# pvcreate /dev/sdc1


## Create a new 'Volume Group (VG)' using the new created 'Physical Volume (PV)'
$ sudo vgcreate <volume_group_name> /dev/<partition_name>
# vgcreate <volume_group_name> /dev/<partition_name>
### Example
$ sudo vgcreate vg-pool-1 /dev/sdc1
# vgcreate vg-pool-1 /dev/sdc1

## Create a new linear 'Logical Volume (LV)' from the newly created 'Volume Group (VG)'
$ sudo lvcreate -L 
```



#### Initialize the physical volume for use by LVM
```
$ sudo pvcreate /dev/<device_name>
# pvcreate /dev/<device_name>
```



### Append the following configuration details to '/etc/fstab' (Note: Change the mounted device accordingly)
```
/dev/<device_name>  /mnt/nfs_share  xfs   defaults  0 0
UUID=<device_UUID>  /mnt/nfs_share  xfs   defaults  0 0
```



### Provide R,W,E permissions to the directory for all users
```
$ sudo chmod -R 777 /mnt/nfs_share
# chmod -R 777 /mnt/nfs_share
```

## Allow services from Firewall
```
$ sudo firewall-cmd --permanent --add-service=nfs
$ sudo firewall-cmd --permanent --add-service=rpc-bind
$ sudo firewall-cmd --permanent --add-service=mountd
# firewall-cmd --permanent --add-service=nfs
# firewall-cmd --permanent --add-service=rpc-bind
# firewall-cmd --permanent --add-service=mountd
```

### Reload the firewall configuration for the changes to take effect
```
$ sudo firewall-cmd –-reload
# firewall-cmd –-reload
```


# Client-side Configuration
