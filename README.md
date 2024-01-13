# How to upgrade openssh into linux server 

I had a requirements for which need to upgrade ssh version. To satisfy it, I have tried to upgrade ssh but could not make it sucessfully. Sometimes, it is upgrading properly and showing the correct version 
from shell console but from ssh checker it was still showing old ssh version. Below script will overcome the problem and install ssh successfully. 

# install into centos >=7

```
#!/bin/sh
yum -y update
yum install -y make gcc perl-core pcre-devel wget zlib-devel
sudo yum -y groupinstall "Development Tools"
wget https://www.openssl.org/source/openssl-1.1.1w.tar.gz
tar -xzvf openssl-1.1.1w.tar.gz
cd openssl-1.1*/
./config --prefix=/usr/local/openssl --openssldir=/usr/local/openssl
make
rm -rf /usr/bin/openssl
sudo make install
sudo ldconfig
sudo tee /etc/profile.d/openssl.sh<<EOF
export PATH=/usr/local/openssl/bin:\$PATH
export LD_LIBRARY_PATH=/usr/local/openssl/lib:\$LD_LIBRARY_PATH
EOF
source /etc/profile.d/openssl.sh
logout
which openssl
openssl version
```

## install into ubuntu >=22.0

```
#!/bin/sh
sudo apt-get update
sudo apt-get install -y make gcc perl libssl-dev libpcre3-dev zlib1g-dev
sudo apt-get install -y build-essential
wget https://www.openssl.org/source/openssl-1.1.1w.tar.gz
tar -xzvf openssl-1.1.1w.tar.gz
cd openssl-1.1.1*/
./config --prefix=/usr/local/openssl --openssldir=/usr/local/openssl
make
sudo make install
sudo ldconfig
sudo tee /etc/profile.d/openssl.sh <<EOF
export PATH=/usr/local/openssl/bin:\$PATH
export LD_LIBRARY_PATH=/usr/local/openssl/lib:\$LD_LIBRARY_PATH
EOF
source /etc/profile.d/openssl.sh
logout  # Note: This line might not work as intended in a script, consider removing it.
which openssl
openssl version
```
