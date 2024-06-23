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
Create a config file (/etc/logrotate.d/example.conf) and add the following content
```
/var/log/example/example.log {
    daily                # Log files are rotated every day (Default value: weekly). [Available Options: daily / weekly / monthly / yearly]
}
```
---
## Rotating Logs based on File Size
Create a config file (/etc/logrotate.d/example.conf) and add the following content
```
/var/log/example/example.log {
    size 100M            # Log files are rotated only if they grow bigger than size bytes. [Available Options: K / M / G]
    minsize 50M          # Log files are rotated when they grow bigger than size bytes, but not before the additionally specified time interval (daily, weekly, monthly, or yearly). [Available Options: K / M / G]
    maxsize 200M         # Log files are rotated when they grow bigger than size bytes even before the additionally specified time interval ( daily, weekly, monthly, or yearly). [Available Options: K / M / G]
}
```
---
## Rotating Logs based on Log Rotation Strategy
Create a config file (/etc/logrotate.d/example.conf) and add the following content
```
/var/log/example/example.log {
    create               # Immediately after rotation (before the postrotate script is run) the log file is created (with the same name as the log file just rotated).
    copytruncate         # Truncate the original log file to zero size in place after creating a copy, instead of moving the old log file and optionally creating a new one. (Default value: create)
}
```
---
## Other options
Create a config file (/etc/logrotate.d/example.conf) and add the following content
```
/var/log/example/example.log {
    compress             # Old versions of log files are compressed with gzip(1) by default.
    delaycompress        # Postpone compression of the previous log file to the next rotation cycle. This only has an effect when used in combination with compress.
    missingok            # Don’t write an error message if the log file is missing.
    notifempty           # Do not rotate the log if it is empty (Default: ifempty).
    rotate 8             # Log files are rotated 8 times before being removed (Default value: 4).
    dateext              # Archive old versions of log files by adding a daily extension (Default format: YYYYMMDD).
    dateformat -%d-%m-%Y # Specify the extension for dateext using the notation similar to strftime(3) function.
    olddir <directory>   # Old logs are moved into the specified directory.
}
```
---

## Example
Create a config file (/etc/logrotate.d/nginx.conf) and add the following content
```
/var/log/nginx/access.log {
    daily
    rotate 4
    create 0640 nginx nginx # Creates a new empty log file after rotation, with the specified permissions (0640), owner (nginx), and group (nginx)
    missingok
    notifempty
    compress
    delaycompress
    sharedscripts
    dateext
    dateformat -%d%m%Y
    olddir /var/log/nginx/old
}

/var/log/nginx/error-*.log {
    weekly
    rotate 2
    missingok
    notifempty
    copytruncate
    compress
    delaycompress
    sharedscripts
    olddir old/error
    dateext
    dateformat -%d-%m-%Y
}
```
