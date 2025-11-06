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
      NIXOS_OZONE_WL = 1;
    };

    packages = with pkgs; [
      gh
      nil
      nix-tree
      nixfmt-rfc-style

      python3

      go-musicfox
      ffmpeg
      vlc
      obs-studio

      kdePackages.yakuake
      kdePackages.kdialog

      intel-gpu-tools
      vulkan-tools

      alacritty
      fuzzel
      waybar

      # obsidian
      # zotero
      matlab

      nix-init
      nix-prefetch-git

      hmcl

      # wineWow64Packages.stagingFull

      umu-launcher-wrapper

      wpsoffice-cn-fcitx
      wechat

      maa-wrapper

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

  fonts.fontconfig.enable = true;
  xdg.configFile."fontconfig/fonts.conf".source = ./files/.config/fontconfig/fonts.conf;

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

  programs.gh.enable = true;

  programs.git = {
    enable = true;
    settings = {
      user = {
        Name = "fym998";
        email = "61316972+fym998@users.noreply.github.com";
      };
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
    functions = {
      whichreal = {
        body = "command realpath (which $argv)";
      };
      mvln = {
        body = ''
          if test (count $argv) -lt 2
              echo "用法:" (status current-function) "源文件... 目标目录" >&2
              return
          end

          set target $argv[-1]

          # 检查目标是否为目录（如果不是，报错）
          if not test -d $target
              echo "ERROR: 目标 '$target' 不是一个目录" >&2
              return 1
          end

          # 遍历除最后一个参数外的所有源文件
          for src in $argv[1..-2]
              if test -e $src
                  set basename (path basename $src)
                  set dest_path $target/$basename

                  # 移动文件
                  mv $src $dest_path

                  # 在原位置创建指向新位置的符号链接
                  ln -s $dest_path $src
              else
                  echo "WARNING: '$src' 不存在，跳过" >&2
              end
          end
        '';
      };
    };
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
