{ config, ... }:
{
  services.mihomo = {
    enable = true;
    tunMode = true;
    configFile = config.age.secrets.mihomo-config.path;
  };
}
