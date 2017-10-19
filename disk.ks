# Minimal Disk Image
#
sshpw --username=root --plaintext randOmStrinGhERE
# Firewall configuration
firewall --enabled


# -----------------------------------------------
# NOTE: This need to be setup first.
url --url=REPO-URL
# -----------------------------------------------


# Root password
rootpw --plaintext removethispw
# Network information
network  --bootproto=dhcp --onboot=on --activate
# System authorization information
auth --useshadow --enablemd5
# System keyboard
keyboard --xlayouts=us --vckeymap=us
# System language
lang en_US.UTF-8
# SELinux configuration
selinux --enforcing
# Installation logging level
logging --level=info
# Shutdown after installation
shutdown
# System timezone
timezone  US/Eastern
# System bootloader configuration
bootloader --location=mbr
# Clear the Master Boot Record
zerombr
# Partition clearing information
clearpart --all
# Disk partitioning information
part biosboot --size=1
part / --fstype="ext4" --size=4000
part /boot --fstype="ext4" --size=500
part swap --size=1000

%post
# Remove root password
passwd -d root > /dev/null

# Remove random-seed
rm /var/lib/systemd/random-seed
%end

%packages
@core
kernel
memtest86+
efibootmgr
grub2-efi
grub2
shim
syslinux
-dracut-config-rescue

# Boot on 32bit UEFI
shim-ia32

# NOTE: To build a bootable UEFI disk image livemedia-creator needs to be
#       run on a UEFI system or virt.
%end
