#!/bin/sh
yum -y update
yum groupinstall "Development Tools"
yum install zlib-devel openssl-devel
cp /etc/ssh/sshd_config  /etc/ssh/sshd_config.copy
wget -c  https://cdn.openbsd.org/pub/OpenBSD/OpenSSH/portable/openssh-9.6p1.tar.gz
tar -xzvf openssh-9.6p1.tar.gz
cd openssh-9.6p1 || exit
yum install pam-devel libselinux-devel
./configure  --disable-pam --prefix=/usr --with-pam --with-selinux --with-privsep-path=/var/lib/sshd/ --sysconfdir=/etc/ssh --with-ssl-dir=/usr/local/openssl/
make
make install
sudo chmod 600 /etc/ssh/ssh_host_rsa_key
sudo chmod 600 /etc/ssh/ssh_host_ecdsa_key
sudo chmod 600 /etc/ssh/ssh_host_ed25519_key
sudo chmod 600 /etc/ssh/ssh_host_ed25519_key
make install
sudo systemctl restart sshd