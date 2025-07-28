{
  config,
  lib,
  pkgs,
  username,
  stateVersion,
  ...
}:

{
  home = {
    inherit username;
    homeDirectory = "/home/${username}";

    sessionVariables = {
      # NIXOS_OZONE_WL = 1;
    };

    packages = with pkgs; [
      gh
      nil
      nix-tree
      nixfmt-rfc-style

      go-musicfox
      ffmpeg
      kazumi

      kdePackages.yakuake
      kdePackages.kdialog

      intel-gpu-tools
      vulkan-tools
      glxinfo

      alacritty
      fuzzel
      waybar

      obsidian
      zotero

      nix-init
      nix-prefetch-git

      (hmcl.override { glfw = glfw3-minecraft; })
      umu-launcher
      winetricks
      # wineWow64Packages.stagingFull

      wpsoffice-cn-fcitx

      (writeShellApplication {
        name = "bsl";

        runtimeInputs = [ pkgs.bitsrun-rs ];

        text = ''
          bitsrun login --config "${config.age.secrets.bitsrun-rs-config.path}"
          sleep 1
          bitsrun status
        '';
      })
    ];
  };

  services.podman.enable = true;
  xdg.configFile."containers/registries.conf".source =
    lib.mkForce ./files/.config/containers/registries.conf;

  fonts.fontconfig.enable = true;
  xdg.configFile."fontconfig/fonts.conf".source = ./files/.config/fontconfig/fonts.conf;

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

  programs.gh.enable = true;

  programs.git = {
    enable = true;
    userName = "fym998";
    userEmail = "61316972+fym998@users.noreply.github.com";
    extraConfig = {
      # https://forums.whonix.org/t/git-users-enable-fsck-by-default-for-better-security/2066
      transfer.fsckobjects = true;
      fetch.fsckobjects = true;
      receive.fsckobjects = true;
    };
    signing = {
      key = "0xD7BC265823B30CC1";
      signByDefault = true;
    };
  };

  programs.gpg.enable = true;

  # programs.lutris = {
  #   enable = true;
  #   extraPackages = with pkgs; [
  #     mangohud
  #     winetricks
  #     gamescope
  #     gamemode
  #     umu-launcher
  #     wineWow64Packages.stagingFull
  #   ];
  #   protonPackages = [ pkgs.proton-ge-bin ];
  #   steamPackage = pkgs.steam;
  # };

  xdg.enable = true;
  xdg.userDirs.enable = true;
  xdg.autostart.enable = true;
  xdg.autostart.entries = [
    "${pkgs.sunshine}/share/applications/sunshine.desktop"
    "${pkgs.kdePackages.yakuake}/share/applications/org.kde.yakuake.desktop"
  ];

  programs.vscode = {
    enable = true;
    # profiles.default = {
    #   extensions = with pkgs.vscode-extensions; [
    #     kamadorueda.alejandra
    #     jnoortheen.nix-ide
    #   ];
    # };
  };

  programs.bash = {
    enable = true;
    enableCompletion = true;
    # initExtra = ''
    #   fish
    # '';
  };

  programs.fish = {
    enable = true;
  };

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = stateVersion;

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
