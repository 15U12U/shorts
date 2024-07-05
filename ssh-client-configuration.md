# SSH Client Configuration Guide
## Generating SSH Key Pair
### Using default options
```bash
ssh-keygen
ssh-keygen -C "John Doe"
```

### Change Key Type
#### Available Key Types
- dsa
- ecdsa
- ecdsa-sk
- ed25519
- ed25519-sk
- rsa

```bash
ssh-keygen -t rsa
ssh-keygen -t dsa 
ssh-keygen -t ecdsa
ssh-keygen -t ed25519
```

### Change Key Size
#### Available Key sizes
| Key Type | Key Sizes              |
| :------- | :--------------------- |
| dsa      | 1024                   |
| ecdsa    | 256, 384, 521          |
| rsa      | 1024, 2048, 3072, 4096 |

```bash
ssh-keygen -t rsa -b 2048
ssh-keygen -t ecdsa -b 521
```

## Copying the Public Key to a Server
```bash
ssh-copy-id -i ~/.ssh/<public-key> <user>@<ip-address>
ssh-copy-id -i ~/.ssh/<public-key> <user>@<hostname>
```

## Setting Permissions
```bash
chmod 0600 ~/.ssh/config
chmod 0600 ~/.ssh/<private-key>
```

## Configuring the Client Config
Edit or create the config file (~/.ssh/config)
```bash
Host <name>
  Hostname <hostname>/<fqdn>/<ip-address>
  IdentityFile ~/.ssh/<private-key>
  User <username>
  Port <port>   
```

### Example config file
```bash
Host zeus
  Hostname 1.1.1.1
  IdentityFile ~/.ssh/hera
  User admin

Host bond
  Hostname james.bond.com
  IdentityFile ~/.ssh/007
  User root
  Port 7777  
```
