{ pkgs, osConfig, ... }:
{
  programs.plasma = {
    enable = true;
    overrideConfig = false;
    immutableByDefault = true;

    session.sessionRestore.restoreOpenApplicationsOnLogin = "startWithEmptySession";

    # powerdevil.AC.autoSuspend.idleTimeout = 10800;
    # powerdevil.AC.turnOffDisplay.idleTimeout = 1200;

    workspace.wallpaperPictureOfTheDay.provider = "bing";

    kwin.titlebarButtons.left = [
      "more-window-actions"
      "keep-above-windows"
    ];

    panels = [
      # Windows-like panel at the bottom
      {
        floating = true;
        location = "bottom";
        widgets = [
          { kicker = { }; }
          {
            iconTasks = {
              launchers = [
                "applications:org.kde.dolphin.desktop"
                "applications:org.kde.konsole.desktop"
                "applications:firefox.desktop"
              ];
            };
          }
          "org.kde.plasma.marginsseparator"
          { systemTray = { }; }
          { digitalClock = { }; }
          "org.kde.plasma.showdesktop"
        ];
      }
      # System monitor panel on right
      {
        height = 80;
        hiding = "dodgewindows";
        lengthMode = "fit";
        location = "right";
        widgets = [
          "org.kde.plasma.systemmonitor.cpu"
          "org.kde.plasma.systemmonitor.cpucore"
          "org.kde.plasma.systemmonitor.diskactivity"
          "org.kde.plasma.systemmonitor.diskusage"
          "org.kde.plasma.systemmonitor.memory"
          "org.kde.plasma.systemmonitor.net"
        ];
      }
    ];

    shortcuts."yakuake"."toggle-window-state" = "F8";

    configFile = {
      "plasma-localerc" = {
        Formats.LANG = "zh_CN.UTF-8";
        Translations.LANGUAGE = "zh_CN:en_US";
      };

      "kwinrc" = {
        Wayland.InputMethod = {
          value = "/etc/profiles/per-user/fym/share/applications/fcitx5-wayland-launcher.desktop";
          shellExpand = true;
        };
        #"Xwayland"."Scale"=1.5;
        "Windows"."ElectricBorderCornerRatio" = 0.1;
      };

      "kdeglobals" = {
        Shortcuts.Redo = "Ctrl+Shift+Z; Ctrl+Y";
        "General"."accentColorFromWallpaper" = true;
      };

      "kcminputrc" =
        let
          touchpad = {
            "NaturalScroll" = true;
          };
          mouse = {
            "PointerAccelerationProfile" = 1;
            "ScrollMethod" = 4;
          };
        in
        {
          "Libinput/1133/50504/Logitech USB Receiver Mouse" = mouse;
          "Libinput/9390/40374/BJX Philips USB Receiver" = mouse;
          "Libinput/1739/52804/CUST001:00 06CB:CE44 Touchpad" = touchpad;
        };

      "baloofilerc"."Basic Settings"."Indexing-Enabled" = false;

      "spectaclerc" = {
        "Annotations"."annotationToolType" = 2;
        "Annotations"."freehandShadow" = false;
        "Annotations"."freehandStrokeColor" = "255,255,255";
        "General"."clipboardGroup" = "PostScreenshotCopyImage";
        "General"."printKeyRunningAction" = "StartNewInstance";
        "GuiConfig"."captureMode" = 4;
        "GuiConfig"."includePointer" = true;
        "ImageSave"."imageCompressionQuality" = 100;
        "ImageSave"."imageFilenameTemplate" = "screenshot_<yyyy><MM><dd>_<HH><mm><ss>_<title>";
        "ImageSave"."translatedScreenshotsFolder" = "Screenshots";
        "VideoSave"."imageFilenameTemplate" = "screenrecording_<yyyy><MM><dd>_<HH><mm><ss>_<title>";
        "VideoSave"."translatedScreencastsFolder" = "ScreenRecordings";
      };
    };

    # kwin = {
    #   nightLight = {
    #     enable = true;
    #     mode = "location";
    #     location = {
    #       latitude = "39.5";
    #       longitude = "116.1";
    #     };
    #   };
    # };

    fonts = rec {
      general.family = builtins.head osConfig.fonts.fontconfig.defaultFonts.sansSerif;
      general.pointSize = 10;
      small.family = builtins.head osConfig.fonts.fontconfig.defaultFonts.sansSerif;
      small.pointSize = 8;
      fixedWidth.family = builtins.head osConfig.fonts.fontconfig.defaultFonts.monospace;
      fixedWidth.pointSize = 11;
      menu = general;
      toolbar = general;
      windowTitle = general;
    };
  };

  programs.plasma.kscreenlocker = {
    appearance.wallpaperPictureOfTheDay.provider = "bing";
    # timeout=15;
  };

  programs.konsole = {
    enable = true;
    defaultProfile = "fish";
    profiles.fish = {
      command = "fish";
      extraConfig."Interaction Options" = {
        OpenLinksByDirectClickEnabled = false;
        TextEditorCmd = 0;
        UnderlineFilesEnabled = true;
      };
      font = {
        name = "Hack";
        size = 11;
      };
    };
  };

  programs.kate = {
    enable = true;
    editor = {
      indent.width = 2;
      # font = {
      #   family = "Hack";
      #   pointSize = 11;
      # };
    };
  };

  home.file.".config/kate/lspclient/settings.json".text = ''
    {
      "servers": {
        "nix": {
          "command": ["nil"],
          "url": "https://github.com/oxalica/nil",
          "highlightingModeRegex": "^Nix$",
          "formatting": { "command": ["nixfmt"] }
        }
      }
    }
  '';

  # home.file.".config/yakuakerc".text=''
  #   [Dialogs]
  #   FirstRun=false
  #
  #   [Window]
  #   Height=43
  #   Width=60
  #   KeepOpen=false
  # '';
}
