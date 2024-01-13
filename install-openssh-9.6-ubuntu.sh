#!/bin/sh
sudo apt-get update
sudo apt-get install build-essential
sudo apt-get install zlib1g-dev libssl-dev
cp /etc/ssh/sshd_config  /etc/ssh/sshd_config.copy
wget -c https://cdn.openbsd.org/pub/OpenBSD/OpenSSH/portable/openssh-9.6p1.tar.gz
tar -xzvf openssh-9.6p1.tar.gz
cd openssh-9.6p1 || exit
sudo apt-get install libpam0g-dev libselinux1-dev
./configure  --disable-pam --prefix=/usr --with-pam --with-selinux --with-privsep-path=/var/lib/sshd/ --sysconfdir=/etc/ssh --with-ssl-dir=/usr/local/openssl/
make
sudo make install
sudo chmod 600 /etc/ssh/ssh_host_rsa_key
sudo chmod 600 /etc/ssh/ssh_host_ecdsa_key
sudo chmod 600 /etc/ssh/ssh_host_ed25519_key
sudo chmod 600 /etc/ssh/ssh_host_ed25519_key
sudo make install
sudo systemctl restart ssh
