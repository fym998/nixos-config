{ pkgs, ... }:
{
  i18n.inputMethod = {
    enable = true;
    type = "fcitx5";
    fcitx5 = {
      waylandFrontend = true;
      inherit (pkgs.kdePackages) fcitx5-with-addons;
      addons = with pkgs; [
        kdePackages.fcitx5-chinese-addons
        fcitx5-mozc
        fcitx5-pinyin-moegirl
        fcitx5-pinyin-minecraft
        fcitx5-pinyin-zhwiki
      ];
    };
  };
  xdg.configFile = {
    "fcitx5".source = ./files/.config/fcitx5;
  };
}
