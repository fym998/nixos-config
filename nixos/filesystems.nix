{
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

    # "/archlinux" = {
    #   device = "/dev/disk/by-uuid/de0720b6-fffa-4dfc-8f16-d7df8fd7ec20";
    #   fsType = "btrfs";
    #   options = [
    #     "lazytime"
    #     "noatime"
    #     "compress=zstd"
    #     "subvol=@"
    #   ];
    # };

    # "/archlinux/boot" = {
    #   device = "/dev/disk/by-uuid/4F38-C9A3";
    #   fsType = "vfat";
    #   options = [ "umask=077" ];
    # };

    # "/archlinux/home" = {
    #   device = "/dev/disk/by-uuid/de0720b6-fffa-4dfc-8f16-d7df8fd7ec20";
    #   fsType = "btrfs";
    #   options = [
    #     "lazytime"
    #     "noatime"
    #     "compress=zstd"
    #     "subvol=@home"
    #   ];
    # };

    # "/archlinux/nix" = {
    #   device = "/dev/disk/by-uuid/b380834f-9707-4ad0-a703-778a115bb0a0";
    #   fsType = "btrfs";
    #   options = [
    #     "lazytime"
    #     "noatime"
    #     "compress=zstd"
    #     "subvol=@nix"
    #   ];
    # };

    # "/archlinux/var/cache" = {
    #   device = "/dev/disk/by-uuid/de0720b6-fffa-4dfc-8f16-d7df8fd7ec20";
    #   fsType = "btrfs";
    #   options = [
    #     "lazytime"
    #     "noatime"
    #     "compress=zstd"
    #     "subvol=@var_cache"
    #   ];
    # };

    # "/archlinux/var/log" = {
    #   device = "/dev/disk/by-uuid/de0720b6-fffa-4dfc-8f16-d7df8fd7ec20";
    #   fsType = "btrfs";
    #   options = [
    #     "lazytime"
    #     "noatime"
    #     "compress=zstd"
    #     "subvol=@var_log"
    #   ];
    # };

    # "/archlinux/var/tmp" = {
    #   device = "/dev/disk/by-uuid/de0720b6-fffa-4dfc-8f16-d7df8fd7ec20";
    #   fsType = "btrfs";
    #   options = [
    #     "lazytime"
    #     "noatime"
    #     "compress=zstd"
    #     "subvol=@var_tmp"
    #   ];
    # };

    ### Stateless $HOME/.config on tmpfs

    # "/home/${username}/.config" = {
    #   # device = "none";
    #   fsType = "tmpfs";
    #   options = [ "size=5%" ];
    # };
  };
}
