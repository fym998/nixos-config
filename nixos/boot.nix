{ config, pkgs, ... }:
{
  boot.kernelPackages = pkgs.linuxPackages_latest;

  boot.binfmt.emulatedSystems = [ "aarch64-linux" ];

  # Use the systemd-boot EFI boot loader.
  boot.loader = {
    efi.canTouchEfiVariables = true;

    systemd-boot = {
      enable = true;
      configurationLimit = 15;

      edk2-uefi-shell.enable = true;

      extraEntries = {
        "grub-HD0b.conf" = ''
          title    GRUB
          efi      /efi/edk2-uefi-shell/shell.efi
          options  -nointerrupt -nomap -noversion -exit HD0b:\EFI\GRUB\grubx64.efi
          sort-key ${config.boot.loader.systemd-boot.edk2-uefi-shell.sortKey}
        '';
        "archlinux-HD0b.conf" = ''
          title    Arch Linux
          efi      /efi/edk2-uefi-shell/shell.efi
          options  -nointerrupt -nomap -noversion -exit HD0b:\vmlinuz-linux root=UUID=de0720b6-fffa-4dfc-8f16-d7df8fd7ec20 rw rootflags=subvol=@  loglevel=4 initrd=\intel-ucode.img initrd=\initramfs-linux.img
          sort-key a
        '';
      };
    };
  };
}
