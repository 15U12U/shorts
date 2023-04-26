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

### Creating a seperate LVM for the NFS share (Note: Please refer to the [LVM Configuration Guide](lvm-configuration.md))
---

## Creating a NFS Share
### Create a new directory for the mount point
```
$ sudo mkdir -p /mnt/nfs_share
# mkdir -p /mnt/nfs_share
```

### Provide R,W,E permissions to the directory for all users
```
$ sudo chmod -R 777 /mnt/nfs_share
# chmod -R 777 /mnt/nfs_share
```
---
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
