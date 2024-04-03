#!/bin/bash -x
if [ "$1" = "run" ]; then

  LOGFILE="/var/log/cloud-config-"$(date +%s)
  SCRIPT_LOG_DETAIL="$LOGFILE"_$(basename "$0").log

  # Reference: https://serverfault.com/questions/103501/how-can-i-fully-log-all-bash-scripts-actions
  exec 3>&1 4>&2
  trap 'exec 2>&4 1>&3' 0 1 2 3
  exec 1>$SCRIPT_LOG_DETAIL 2>&1

  hostnamectl set-hostname onion-manager

  # Debconf needs to be told to accept that user interaction is not desired
  export DEBIAN_FRONTEND=noninteractive
  export DEBCONF_NONINTERACTIVE_SEEN=true
  apt-get -o DPkg::Options::=--force-confdef update
  apt-get -y -o DPkg::Options::=--force-confdef upgrade
  apt-get -o DPkg::Options::=--force-confdef install -y git build-essential curl ethtool netfilter-persistent iptables-persistent

  curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
  sudo chmod a+r /usr/share/keyrings/docker-archive-keyring.gpg

  fallocate -l 24G /swapfile
  chmod 600 /swapfile
  mkswap /swapfile
  swapon /swapfile
  echo '/swapfile none swap sw 0 0' | sudo tee -a /etc/fstab

  FIRST_DRIVE=1
  for NEW_VOLUME in nvme1n1 nvme2n1 nvme3n1; do
    sudo sgdisk -Z /dev/${NEW_VOLUME}
    sudo pvcreate /dev/${NEW_VOLUME}
    if [ $FIRST_DRIVE -eq 1 ]; then
      sudo vgcreate vg0 /dev/${NEW_VOLUME}
      FIRST_DRIVE=0
    else
      sudo vgextend vg0 /dev/${NEW_VOLUME}
    fi
  done

  lvcreate -n lv0 -l +100%FREE vg0

  export FILESYSTEM=xfs
  mkfs.${FILESYSTEM} /dev/mapper/vg0-lv0

  UUID=$(blkid "$(findmnt -n -o SOURCE /)" -s UUID -o value) && blkid |grep "${UUID}"
  export UUID
  PARTUUID=$(blkid "$(findmnt -n -o SOURCE /)" -s PARTUUID -o value) && blkid |grep "${PARTUUID}"
  export PARTUUID
  VG0_LV0=$(blkid /dev/mapper/vg0-lv0 | awk -F '"' '{print $2}') && blkid |grep "${VG0_LV0}"
  export VG0_LV0

  update-initramfs -u -k all

  mkdir /mnt/new /mnt/old
  mount /dev/mapper/vg0-lv0 /mnt/new
  mount -o bind,ro / /mnt/old
  rsync -aHAX --numeric-ids --info=progress2 --exclude={"/proc/*","/sys/*","/boot/efi/*","/dev/*","/tmp/*","/mnt/*","/run/*","/media/*","/lost+found"} /mnt/old/ /mnt/new/
  sync && sudo umount /mnt/old

  sed -i '0,/^[^#]/s/^[^#]/#&/' /mnt/new/etc/fstab
  if [ "$FILESYSTEM" = "xfs" ]; then
      echo "UUID=${VG0_LV0} / xfs defaults,noatime 1 1" | sudo tee -a /mnt/new/etc/fstab
  fi
  if [ "$FILESYSTEM" = "ext4" ]; then
      echo "UUID=${VG0_LV0} / ext4 discard,errors=remount-ro 0 1" | sudo tee -a /mnt/new/etc/fstab
  fi
  sed -i "/^GRUB_FORCE_PARTUUID/s/^/#/" /mnt/new/etc/default/grub.d/40-force-partuuid.cfg
  sed -i "s/${UUID}/${VG0_LV0}/g" /mnt/new/boot/grub/x86_64-efi/load.cfg
  sed -i.bak "s/root=PARTUUID=${PARTUUID}/root=UUID=${VG0_LV0}/g" /boot/grub/grub.cfg

  sync && umount /mnt/new && shutdown now
fi
