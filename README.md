# How to perform an upgrade of OpenSSH on a Linux server:

I encountered a specific requirement that necessitated upgrading the SSH version. Despite attempting the upgrade, I faced challenges achieving it. Occasionally, the upgrade process would seemingly complete, displaying the correct version in the shell console, but the SSH checker continued to report the old version. The script provided below addresses this issue, ensuring a successful installation of the upgraded SSH.

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
