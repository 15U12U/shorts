# Server-side Configuration
## Configuring the NFS Service
### Installing NFS Service
#### RHEL-based Systems (CentOS / Fedora / Rocky Linux / Oracle Linux / Alma Linux)
```
$ sudo dnf install -y nfs-utils
# dnf install -y nfs-utils
```
#### Debian-based Systems (Ubuntu / Kubuntu / Linux Mint)
```
$ sudo apt install -y nfs-kernel-server
# apt install -y nfs-kernel-server
```
---
## Enable and Start NFS Service
```
$ sudo systemctl enable --now nfs-server.service
# systemctl enable --now nfs-server.service
```
---

## Disable NFSv3 if required
### Edit the '/etc/nfs.conf' file as follows
```
[nfsd]
vers3=no
```
---

## Creating a seperate LVM for the NFS share (Note: Please refer to the [LVM Configuration Guide](lvm-configuration.md))
---

## Creating a NFS Share
### Create a new directory for the mount point
```
$ sudo mkdir -p /mnt/nfs_server_mount
# mkdir -p /mnt/nfs_server_mount
```
### Provide R,W,E permissions to the directory for all users
```
$ sudo chmod -R 777 /mnt/nfs_server_mount
# chmod -R 777 /mnt/nfs_server_mount
```
### Configure the NFS Exports for Clients
```
$ sudo vim /etc/exports
# vim /etc/exports
```
#### Edit the configuration based on the use case
> **Note**  
> Default Options:
> no_subtree_check, secure, ro, sync, wdelay, auth_nlm, root_squash, no_all_squash
```
/mnt/nfs_server_mount *(rw)
/mnt/nfs_server_mount <client_ip>(rw)
/mnt/nfs_server_mount <client_hostname>(rw)
/mnt/nfs_server_mount *.domain(ro,all_squash)
```
### Export the directories in /etc/exports
```
$ sudo exportfs -arv
# exportfs -arv
```
### Allow NFS Exports on SELinux (If SELinux is enforced)
```
$ sudo setsebool -P nfs_export_all_rw 1
# setsebool -P nfs_export_all_rw 1
```
### Restart the service to apply changes
```
$ sudo systemctl restart nfs-server.service
# systemctl restart nfs-server.service
```
---

## Allow services from Firewall
### NFSv3
```
$ sudo firewall-cmd --permanent --add-service=nfs3
$ sudo firewall-cmd --permanent --add-service=rpc-bind
$ sudo firewall-cmd --permanent --add-service=mountd
# firewall-cmd --permanent --add-service=nfs3
# firewall-cmd --permanent --add-service=rpc-bind
# firewall-cmd --permanent --add-service=mountd
```
### NFSv4
```
$ sudo firewall-cmd --permanent --add-service=nfs
# firewall-cmd --permanent --add-service=nfs
```
### Reload the firewall configuration for the changes to take effect
```
$ sudo firewall-cmd –-reload
# firewall-cmd –-reload
```
---


# Client-side Configuration
## Installing NFS Service
### RHEL-based Systems (CentOS / Fedora / Rocky Linux / Oracle Linux / Alma Linux)
```
$ sudo dnf install -y nfs-utils
# dnf install -y nfs-utils
```
### Debian-based Systems (Ubuntu / Kubuntu / Linux Mint)
```
$ sudo apt install -y nfs-common
# apt install -y nfs-common
```
---

## Creating a mount point
```
$ sudo mkdir -p /mnt/nfs_client_mount
# mkdir -p /mnt/nfs_client_mount
```
---

## Show the exported mounts
```
$ sudo showmount -e <nfs_server>
# showmount -e <nfs_server>
```
### Example
```
$ sudo showmount -e 192.168.1.10
# showmount -e nfs-srv.local
```
---

## Add the NFS Directory to /etc/fstab
### Append one of the following lines to '/etc/fstab'
#### NFSv3
```
<nfs_server_ip>:/mnt/nfs_server_mount /mnt/nfs_client_mount nfs defaults,noatime,nodev,nolock 0 0
<nfs_server_hostname>:/mnt/nfs_server_mount /mnt/nfs_client_mount nfs defaults,noatime,nodev,nolock 0 0

<nfs_server_ip>:/mnt/nfs_server_mount /mnt/nfs_client_mount nfs defaults,nfsvers=3,noatime,nodev,nolock 0 0
<nfs_server_hostname>:/mnt/nfs_server_mount /mnt/nfs_client_mount nfs defaults,nfsvers=3,noatime,nodev,nolock 0 0
```
#### NFSv4 / NFSv4.1 / NFSv4.2
```
<nfs_server_ip>:/mnt/nfs_server_mount /mnt/nfs_client_mount nfs4 defaults,noatime,nodev,nolock 0 0
<nfs_server_hostname>:/mnt/nfs_server_mount /mnt/nfs_client_mount nfs4 defaults,noatime,nodev,nolock 0 0

<nfs_server_ip>:/mnt/nfs_server_mount /mnt/nfs_client_mount nfs4 defaults,nfsvers=4.1,noatime,nodev,nolock 0 0
<nfs_server_hostname>:/mnt/nfs_server_mount /mnt/nfs_client_mount nfs4 defaults,nfsvers=4.1,noatime,nodev,nolock 0 0

<nfs_server_ip>:/mnt/nfs_server_mount /mnt/nfs_client_mount nfs4 defaults,nfsvers=4.2,noatime,nodev,nolock 0 0
<nfs_server_hostname>:/mnt/nfs_server_mount /mnt/nfs_client_mount nfs4 defaults,nfsvers=4.2,noatime,nodev,nolock 0 0
```
