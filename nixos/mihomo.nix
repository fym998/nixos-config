{ config, ... }:
{
  services.mihomo = {
    enable = true;
    configFile = config.age.secrets.mihomo-config.path;
  };
}
