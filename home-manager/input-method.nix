{ pkgs, ... }:
{
  i18n.inputMethod = {
    enable = true;
    type = "fcitx5";
    fcitx5 = {
      waylandFrontend = true;
      fcitx5-with-addons = pkgs.kdePackages.fcitx5-with-addons;
      # plasma6Support = true;
      addons = with pkgs; [ kdePackages.fcitx5-chinese-addons ];
      settings = {
        inputMethod = {
          GroupOrder."0" = "Default";
          "Groups/0" = {
            Name = "Default";
            "Default Layout" = "us";
            DefaultIM = "pinyin";
          };
          "Groups/0/Items/0".Name = "keyboard-us";
          "Groups/0/Items/1".Name = "pinyin";
        };
        addons.pinyin = {
          globalSection = {
            # 启用云拼音
            CloudPinyinEnabled = "False";
            # FirstRun
            FirstRun = "False";
          };
          sections = {
            PrevPage."0" = "bracketleft";
            NextPage."0" = "bracketright";
          };
        };
      };
    };
  };
}
