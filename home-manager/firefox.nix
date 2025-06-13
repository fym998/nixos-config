{
  pkgs,
  ...
}:
{
  # home.activation.firefox = #lib.hm.dag.entryAfter ["writeBoundary"] ''
  # ''
  #   run find $HOME/.mozilla/firefox -name "*.backup" -type f -delete
  # '';

  # home.file.".mozilla/firefox/a/search.json.mozlz4".force = lib.mkForce true;

  programs.firefox = {
    enable = true;
    package = pkgs.firefox-bin.override {
      nativeMessagingHosts = [ pkgs.kdePackages.plasma-browser-integration ];
    };
    languagePacks = [ "zh-CN" ];
    profiles.a = {
      search = {
        force = true;
        default = "bing";
        engines = {
          bing.metaData.hidden = false;
          baidu.metaData.hidden = true;

          nixos-packages = {
            name = "NixOS Packages np";
            urls = [
              {
                template = "https://search.nixos.org/packages";
                params = [
                  {
                    name = "type";
                    value = "packages";
                  }
                  {
                    name = "query";
                    value = "{searchTerms}";
                  }
                ];
              }
            ];
            icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
            definedAliases = [ "@np" ];
          };

          nixos-options = {
            name = "NixOS Options no";
            urls = [
              {
                template = "https://search.nixos.org/options";
                params = [
                  {
                    name = "type";
                    value = "packages";
                  }
                  {
                    name = "query";
                    value = "{searchTerms}";
                  }
                ];
              }
            ];
            icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
            definedAliases = [ "@no" ];
          };

          nixos-wiki = {
            name = "NixOS Wiki nw";
            urls = [ { template = "https://wiki.nixos.org/w/index.php?search={searchTerms}"; } ];
            # iconMapObj."16" = "https://wiki.nixos.org/favicon.ico";
            icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
            definedAliases = [ "@nw" ];
          };

          archlinuxcn-wiki = {
            name = "Arch Linux CN Wiki";
            urls = [ { template = "https://wiki.archlinuxcn.org/wzh/index.php?search={searchTerms}"; } ];
            icon = "https://wiki.archlinuxcn.org/wzh/images/logo.svg";
            definedAliases = [ "@aw" ];
          };
        };
      };

      settings = {
        "widget.use-xdg-desktop-portal.file-picker" = 1;
      };
    };
  };
}
