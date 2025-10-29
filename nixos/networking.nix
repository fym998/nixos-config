{
  config,
  hostname,
  lib,
  ...
}:
{
  networking = {
    hostName = hostname;
    networkmanager.enable = true;
    proxy.httpsProxy = "http://127.0.0.1:19870";
    proxy.noProxy = "127.0.0.1,localhost,internal.domain";
  };
  services.mihomo = {
    enable = true;
    tunMode = true;
    configFile = config.age.secrets.mihomo-config.path;
  };
  services.resolved.enable = true;

  services.tailscale.enable = true;

  # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
  # (the default) this is the recommended approach. When using systemd-networkd it's
  # still possible to use this option, but it's recommended to use it in conjunction
  # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
  networking.useDHCP = lib.mkDefault true;
  # networking.interfaces.enp0s13f0u1u4c2.useDHCP = lib.mkDefault true;
  # networking.interfaces.wlp0s20f3.useDHCP = lib.mkDefault true;
}
