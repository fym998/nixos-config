# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).
#####

{
  config,
  pkgs,
  inputs,
  username,
  hostname,
  stateVersion,
  ...
}:

{
  services.sunshine = {
    enable = true;
    capSysAdmin = true;
    autoStart = false;
  };

  services.flatpak.enable = true;
  # xdg.portal.config.common.default = "kde";
  xdg.portal.xdgOpenUsePortal = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages =
    with pkgs;
    [
      nano
      git

      fastfetch

      yazi
      file
      bat
      which
      tree
      colordiff

      lesspass-cli

      pciutils
      usbutils
      htop
      btop

      gparted
      btrfs-assistant
      compsize

      lenovo-legion

      arch-install-scripts
    ]
    ++ (with inputs; [
      plasma-manager.packages.${system}.default
      fym998-nur.packages.${system}.bitsrun-rs
      agenix.packages.${system}.default
      # fh.packages.x86_64-linux.default
    ]);

  programs.gnupg = {
    agent = {
      enable = true;
      enableBrowserSocket = true;
      enableExtraSocket = true;
      enableSSHSupport = true;
    };
    dirmngr.enable = true;
  };

  programs.fish.enable = true;
  programs.git.enable = true;

  #programs.nix-ld.enable = true;

  programs.steam = {
    enable = true;
    extraCompatPackages = with pkgs; [
      proton-ge-bin
      mangohud
      gamescope
      gamemode
    ];
  };

  services.btrfs.autoScrub = {
    enable = true;
    interval = "weekly";
  };

  # services.snapper = {
  #   persistentTimer = true;
  #   configs.nixos-config = {
  #     SUBVOLUME = "/etc/nixos";
  #     ALLOW_USERS = [ username ];
  #     TIMELINE_CREATE = true;
  #     TIMELINE_CLEANUP = true;
  #   };
  # };

  services.openssh = {
    enable = true;
    settings.PasswordAuthentication = false;
  };

  services.tailscale.enable = true;

  i18n.extraLocales = [ "zh_CN.UTF-8/UTF-8" ];

  programs.nh = {
    enable = true;
    clean = {
      enable = true;
      extraArgs = "--keep-since 1w --keep 10";
      dates = "weekly";
    };
    flake = "/home/${username}/repos/nixos-config";
  };

  services.displayManager = {
    sddm.enable = true;
    sddm.wayland.enable = true;
    sddm.wayland.compositor = "kwin";
    defaultSession = "plasma";
  };
  services.desktopManager.plasma6.enable = true;
  environment.plasma6.excludePackages = [
    pkgs.kdePackages.elisa
    pkgs.kdePackages.okular
  ];
  programs.niri.enable = true;

  # Set your time zone.
  time.timeZone = "Asia/Shanghai";

  # Select internationalisation properties.
  # i18n.defaultLocale = "en_US.UTF-8";
  # console = {
  #   font = "Lat2-Terminus16";
  #   keyMap = "us";
  #   useXkbConfig = true; # use xkb.options in tty.
  # };

  # Enable sound.
  # hardware.pulseaudio.enable = true;
  # OR
  services.pipewire = {
    enable = true;
    pulse.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.libinput.enable = true;

  # programs.firefox.enable = true;

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;

  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  #
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  #
  # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
  # so changing it will NOT upgrade your system - see https://nixos.org/manual/nixos/stable/#sec-upgrading for how
  # to actually do that.
  #
  # This value being lower than the current NixOS release does NOT mean your system is
  # out of date, out of support, or vulnerable.
  #
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = stateVersion; # Did you read the comment?

}
