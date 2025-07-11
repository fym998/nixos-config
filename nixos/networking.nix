{ config, hostname, ... }:
{
  networking = {
    hostName = hostname;
    networkmanager.enable = true;
    proxy.default = "http://127.0.0.1:19870/";
    proxy.noProxy = "127.0.0.1,localhost,internal.domain";
  };
  services.mihomo = {
    enable = true;
    tunMode = true;
    configFile = config.age.secrets.mihomo-config.path;
  };
}
