{ pkgs, ... }:
{
  services.fprintd = {
    enable = true;
    package = pkgs.fym998.fprintd-fpcmoh;
  };
  services.udev.packages = [ pkgs.fym998.libfprint-fpcmoh ];

  # to unlock kde wallet
  security.pam.services.login.fprintAuth = false;
}
