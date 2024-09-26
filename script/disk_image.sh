#!/bin/bash
if dpkg -l | grep -q qemu-utils; then
    echo "qemu-utils already installed."
else
    echo "Installing qemu-utils..."
    sudo apt install -y qemu-utils
fi

qemu-img create -f raw disk.img 200M
mkfs.fat -n 'MIKAN OS' -s 2 -f 2 -R 32 -F 32 disk.img
mkdir -p mnt
sudo mount -o loop disk.img mnt
sudo mkdir -p mnt/EFI/BOOT
sudo cp ../bootx64/target/x86_64-unknown-uefi/debug/bootx64.efi mnt/EFI/BOOT/BOOTX64.efi
sudo umount mnt
