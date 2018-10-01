# boss-ansible-homelab
boss-ansible-homelab


```
mkdir /usr/share/ca-certificates/local
cd /usr/share/ca-certificates/local
wget https://entrust.com/root-certificates/entrust_l1k.cer
openssl x509 -inform PEM  -in entrust_l1k.cer -outform PEM -out entrust_l1k.crt
dpkg-reconfigure ca-certificates
```


# For vagrant testing

```
 |2.4.2|  using virtualenv: ansible2   unifi in ~/dev/bossjones/boss-ansible-homelab
± |master {1} ✓| → whatmask 192.168.254.0/24

------------------------------------------------
           TCP/IP NETWORK INFORMATION
------------------------------------------------
IP Entered = ..................: 192.168.254.0
CIDR = ........................: /24
Netmask = .....................: 255.255.255.0
Netmask (hex) = ...............: 0xffffff00
Wildcard Bits = ...............: 0.0.0.255
------------------------------------------------
Network Address = .............: 192.168.254.0
Broadcast Address = ...........: 192.168.254.255
Usable IP Addresses = .........: 254
First Usable IP Address = .....: 192.168.254.1
Last Usable IP Address = ......: 192.168.254.254
```
