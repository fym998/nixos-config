{ pkgs, ... }:
{
  services.fprintd = {
    enable = true;
    package = pkgs.fprintd-fpcmoh;
  };
  services.udev.packages = [ pkgs.libfprint-fpcmoh ];

  # to unlock kde wallet
  security.pam.services.login.fprintAuth = false;
}
