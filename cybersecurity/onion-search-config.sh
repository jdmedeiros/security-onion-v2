#!/bin/bash -x
if [ "$1" = "run" ]; then

  LOGFILE="/var/log/cloud-config-"$(date +%s)
  SCRIPT_LOG_DETAIL="$LOGFILE"_$(basename "$0").log

  # Reference: https://serverfault.com/questions/103501/how-can-i-fully-log-all-bash-scripts-actions
  exec 3>&1 4>&2
  trap 'exec 2>&4 1>&3' 0 1 2 3
  exec 1>$SCRIPT_LOG_DETAIL 2>&1

  hostnamectl set-hostname onion-search

  patch /etc/netplan/50-cloud-init.yaml < /var/lib/cloud/instance/scripts/50-cloud-init.yaml.patch
  netplan apply

  # Debconf needs to be told to accept that user interaction is not desired
  export DEBIAN_FRONTEND=noninteractive
  export DEBCONF_NONINTERACTIVE_SEEN=true
  apt-get -o DPkg::Options::=--force-confdef update
  apt-get -y -o DPkg::Options::=--force-confdef upgrade
  curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

  apt-get -o DPkg::Options::=--force-confdef install -y git build-essential curl ethtool

  fallocate -l 24G /swapfile
  chmod 600 /swapfile
  mkswap /swapfile
  swapon /swapfile
  echo '/swapfile none swap sw 0 0' | sudo tee -a /etc/fstab

  for NEW_VOLUME in nvme1n1 nvme2n1 nvme3n1; do sudo sgdisk -Z /dev/${NEW_VOLUME}; sudo pvcreate /dev/${NEW_VOLUME}; sudo vgcreate vg0 /dev/${NEW_VOLUME}; done
  lvcreate -n lv0 -l +100%FREE vg0
  mkfs.xfs /dev/mapper/vg0-lv0

  mount /dev/mapper/vg0-lv0 /mnt

  update-initramfs -u

  rsync -aHAX --numeric-ids --exclude={"/proc/*","/sys/*","/dev/*","/tmp/*","/mnt/*","/run/*","/media/*","/lost+found"} / /mnt/

  reboot
fi
