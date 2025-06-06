{
  pkgs,
  lib,
  username,
  stateVersion,
  inputs,
  system,
  ...
}:

{
  home = {
    inherit username;
    homeDirectory = "/home/${username}";

    packages =
      with pkgs;
      [
        gh
        nil
        nix-tree
        btrfs-assistant
        nix-init
        go-musicfox
        alejandra
        nixfmt-rfc-style
        kdePackages.yakuake
        kdePackages.kdialog
        (hmcl.override {
          jre = pkgs.jdk17;
        })
        intel-gpu-tools
        umu-launcher
        vulkan-tools
        glxinfo
        ffmpeg

        winetricks
        wineWow64Packages.stagingFull
        (
          let
            qw = q4wine.override { wine = wineWow64Packages.stagingFull; };
          in
          qw
        )
      ]
      ++ [
        (
          let
            wps = inputs.fym998-nur.packages.${system}.wpsoffice-cn-custom.overrideAttrs {
              meta.license = lib.licenses.mit;
            };
          in
          wps
        )
      ];
  };

  fonts.fontconfig.enable = true;
  xdg.configFile = {
    "fontconfig/fonts.conf".source = ./files/config/fontconfig/fonts.conf;
  };

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

  programs.gh.enable = true;

  programs.git = {
    enable = true;
    userName = "fym998";
    userEmail = "fujun998@outlook.com";
  };

  programs.lutris = {
    enable = true;
    extraPackages = with pkgs; [
      mangohud
      winetricks
      gamescope
      gamemode
      umu-launcher
      wineWow64Packages.stagingFull
    ];
    protonPackages = [ pkgs.proton-ge-bin ];
    steamPackage = pkgs.steam;
  };

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
