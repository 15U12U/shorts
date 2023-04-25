# Install NFS Service
## CentOS / Fedora / Rocky Linux / Oracle Linux / Red hat Enterprise Linux
```bash
$ sudo dnf install -y nfs-utils
# dnf install -y nfs-utils
```

# Creating a NFS Share
## Create a new directory
```bash
$ sudo mkdir -p /mnt/nfs_share
# mkdir -p /mnt/nfs_share
```

## Create a LV for the NFS Storage
### Append the following configuration details to '/etc/fstab' (Note: CHange the drive accordingly)
```
/dev/mapper/<>  /mnt/nfs_share  xfs   defaults  0 0
```



## Provide R,W,E permissions to the directory for all users
```bash
$ sudo chmod -R 777 /mnt/nfs_share
# chmod -R 777 /mnt/nfs_share
```

# Allow services from Firewall
```bash
$ sudo firewall-cmd --permanent --add-service=nfs
$ sudo firewall-cmd --permanent --add-service=rpc-bind
$ sudo firewall-cmd --permanent --add-service=mountd
# firewall-cmd --permanent --add-service=nfs
# firewall-cmd --permanent --add-service=rpc-bind
# firewall-cmd --permanent --add-service=mountd
```

## Reload the firewall configuration for the changes to take effect
```bash
$ sudo firewall-cmd –-reload
# firewall-cmd –-reload
```


