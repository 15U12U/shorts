# Logrotate Configuration Guide
## Installing Logrotate
### RHEL-based Systems (CentOS / Fedora / Rocky Linux / Oracle Linux / Alma Linux etc.)
```
$ sudo dnf install -y logrotate
# dnf install -y logrotate
```
### Debian-based Systems (Ubuntu / Kubuntu / Linux Mint etc.)
```
$ sudo apt install -y logrotate
# apt install -y logrotate
```
### Alpine Linux
```
$ sudo apk add -y logrotate
# apk add -y logrotate
```
---
## Rotating Logs based on Duration
Create a config file (/etc/logrotate.d/nginx.conf) and add the following content
```
/var/log/nginx/access.log {
    daily # Available Options (daily, weekly, monthly, yearly)
}
```
---
## Rotating Logs based on File Size
Create a config file (/etc/logrotate.d/nginx.conf) and add the following content
```
/var/log/nginx/access.log {
    size 100M # Available Options (K, M, G)
}
```
---





