# Do not modify this file!  It was generated by ‘nixos-generate-config’
# and may be overwritten by future invocations.  Please make changes
# to /etc/nixos/configuration.nix instead.
{
  config,
  lib,
  pkgs,
  modulesPath,
  system,
  ...
}:

{
  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;

  hardware.intelgpu = {
    driver = "xe";
    vaapiDriver = "intel-media-driver";
  };

  hardware.graphics.extraPackages = with pkgs; [
    intel-media-driver
    vpl-gpu-rt
  ];

  services.xserver.videoDrivers = [
    "modesetting"
    "nvidia"
    "fbdev"
  ];

  hardware.nvidia = {
    # enabled=true;
    open = true;
    nvidiaSettings = false;
    prime = {
      offload.enable = true;
      offload.enableOffloadCmd = true;
      # intelBusId = "PCI:0:2:0";
      # nvidiaBusId = "PCI:1:0:0";
      #amdgpuBusId = "PCI:54:0:0"; # If you have an AMD iGPU
    };
    powerManagement.enable = true;
    powerManagement.finegrained = true;
  };

  imports = [ (modulesPath + "/installer/scan/not-detected.nix") ];

  boot.initrd.availableKernelModules = [
    "xhci_pci"
    "thunderbolt"
    "nvme"
    "usbhid"
    "usb_storage"
    "sd_mod"
    "sdhci_pci"
  ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [
    "kvm-intel"
    "legion-laptop"
  ];
  boot.extraModulePackages = [ config.boot.kernelPackages.lenovo-legion-module ];

  fileSystems = {
    "/" = {
      device = "/dev/disk/by-uuid/b380834f-9707-4ad0-a703-778a115bb0a0";
      fsType = "btrfs";
      # neededForBoot = true;
      options = [
        "subvol=@"
        "lazytime"
        "noatime"
        "compress=zstd"
      ];
    };

    "/tmp" = {
      # device = "none";
      fsType = "tmpfs";
      options = [ "size=25%" ];
    };

    "/nix" = {
      device = "/dev/disk/by-uuid/b380834f-9707-4ad0-a703-778a115bb0a0";
      fsType = "btrfs";
      options = [
        "lazytime"
        "noatime"
        "compress=zstd"
        "subvol=@nix"
      ];
    };

    "/top" = {
      device = "/dev/disk/by-uuid/b380834f-9707-4ad0-a703-778a115bb0a0";
      fsType = "btrfs";
      options = [
        "lazytime"
        "noatime"
        "compress=zstd"
      ];
    };

    # "/etc/nixos" = {
    #   device = "/dev/disk/by-uuid/b380834f-9707-4ad0-a703-778a115bb0a0";
    #   fsType = "btrfs";
    #   options = [
    #     "lazytime"
    #     "noatime"
    #     "compress=zstd"
    #     "subvol=@nixos-config"
    #   ];
    # };

    "/boot" = {
      device = "/dev/disk/by-uuid/EAF5-A902";
      fsType = "vfat";
      options = [ "umask=077" ];
    };

    ### Arch Linux

    "/archlinux" = {
      device = "/dev/disk/by-uuid/de0720b6-fffa-4dfc-8f16-d7df8fd7ec20";
      fsType = "btrfs";
      options = [
        "lazytime"
        "noatime"
        "compress=zstd"
        "subvol=@"
      ];
    };

    "/archlinux/boot" = {
      device = "/dev/disk/by-uuid/4F38-C9A3";
      fsType = "vfat";
      options = [ "umask=077" ];
    };

    "/archlinux/home" = {
      device = "/dev/disk/by-uuid/de0720b6-fffa-4dfc-8f16-d7df8fd7ec20";
      fsType = "btrfs";
      options = [
        "lazytime"
        "noatime"
        "compress=zstd"
        "subvol=@home"
      ];
    };

    "/archlinux/nix" = {
      device = "/dev/disk/by-uuid/b380834f-9707-4ad0-a703-778a115bb0a0";
      fsType = "btrfs";
      options = [
        "lazytime"
        "noatime"
        "compress=zstd"
        "subvol=@nix"
      ];
    };

    "/archlinux/var/cache" = {
      device = "/dev/disk/by-uuid/de0720b6-fffa-4dfc-8f16-d7df8fd7ec20";
      fsType = "btrfs";
      options = [
        "lazytime"
        "noatime"
        "compress=zstd"
        "subvol=@var_cache"
      ];
    };

    "/archlinux/var/log" = {
      device = "/dev/disk/by-uuid/de0720b6-fffa-4dfc-8f16-d7df8fd7ec20";
      fsType = "btrfs";
      options = [
        "lazytime"
        "noatime"
        "compress=zstd"
        "subvol=@var_log"
      ];
    };

    "/archlinux/var/tmp" = {
      device = "/dev/disk/by-uuid/de0720b6-fffa-4dfc-8f16-d7df8fd7ec20";
      fsType = "btrfs";
      options = [
        "lazytime"
        "noatime"
        "compress=zstd"
        "subvol=@var_tmp"
      ];
    };

    ### Stateless $HOME/.config on tmpfs

    # "/home/${username}/.config" = {
    #   # device = "none";
    #   fsType = "tmpfs";
    #   options = [ "size=5%" ];
    # };
  };

  swapDevices = [ ];

  # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
  # (the default) this is the recommended approach. When using systemd-networkd it's
  # still possible to use this option, but it's recommended to use it in conjunction
  # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
  networking.useDHCP = lib.mkDefault true;
  # networking.interfaces.enp0s13f0u1u4c2.useDHCP = lib.mkDefault true;
  # networking.interfaces.wlp0s20f3.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault system;
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
