{ pkgs, ... }:
{
  # fonts.fontconfig.enable = false;
  fonts.enableDefaultPackages = false;
  #fonts.enableGhostscriptFonts=true;

  fonts.fontDir.enable = true;

  fonts.packages = with pkgs; [
    source-han-sans # -vf-otf
    source-han-serif # -vf-otf
    nerd-fonts.hack
    #vista-fonts-chs

    # nixos default fonts
    dejavu_fonts
    freefont_ttf
    gyre-fonts # TrueType substitutes for standard PostScript fonts
    liberation_ttf
    unifont
    noto-fonts-color-emoji

    #twemoji-color-font
  ];

  fonts.fontconfig = {
    enable = true;
    defaultFonts = {
      monospace = [
        "Hack"
        "Source Han Sans SC"
      ];
      sansSerif = [ "Source Han Sans SC" ];
      serif = [ "Source Han Serif SC" ];
      emoji = [ "Noto Color Emoji" ];
    };
    subpixel.rgba = "rgb";
    hinting.enable = false;
    hinting.style = "none";
  };
}
