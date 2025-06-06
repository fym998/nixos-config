{ ... }:
{
  services.fprintd = {
    enable = true;
    package = inputs.fym998-nur.packages.${system}.fprintd-fpcmoh;
  };
  services.udev.packages = [ inputs.fym998-nur.packages.${system}.libfprint-fpcmoh ];

  # to unlock kde wallet
  security.pam.services.login.fprintAuth = false;
}
