# boss-ansible-homelab
boss-ansible-homelab


```
mkdir /usr/share/ca-certificates/local
cd /usr/share/ca-certificates/local
wget https://entrust.com/root-certificates/entrust_l1k.cer
openssl x509 -inform PEM  -in entrust_l1k.cer -outform PEM -out entrust_l1k.crt
dpkg-reconfigure ca-certificates
```
