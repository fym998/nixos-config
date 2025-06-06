{ pkgs, ... }:
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
        "General"."clipboardGroup" = "PostScreenshotCopyImage";
        "General"."printKeyRunningAction" = "StartNewInstance";
        "GuiConfig"."captureMode" = 4;
        "ImageSave"."imageCompressionQuality" = 100;
        "ImageSave"."imageFilenameTemplate" = "screenshot_<yyyy><MM><dd>_<HH><mm><ss>_<title>";
        "ImageSave"."imageSaveLocation" = "file:///home/fym/Pictures/Screenshots/";
        "ImageSave"."lastImageSaveLocation" = "file:///home/fym/图片/屏幕截图/屏幕截图_20250527_201733.png";
        "ImageSave"."translatedScreenshotsFolder" = "屏幕截图";
        "VideoSave"."translatedScreencastsFolder" = "屏幕录像";
      };
    };

    kwin = {
      nightLight = {
        enable = true;
        mode = "location";
        #temperature.night = 5800;
        location = {
          latitude = "39.5";
          longitude = "116.1";
        };
      };
    };

    fonts =
      let
        fontFamily = "Source Han Sans SC";
      in
      {
        general.family = fontFamily;
        general.pointSize = 10;
        menu.family = fontFamily;
        menu.pointSize = 10;
        small.family = fontFamily;
        small.pointSize = 8;
        toolbar.family = fontFamily;
        toolbar.pointSize = 10;
        windowTitle.family = fontFamily;
        windowTitle.pointSize = 10;
        # fixedWidth.family = "Hack";
        # fixedWidth.pointSize = 11;
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
      command = "${pkgs.fish}/bin/fish";
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
