{ config, ... }:
{
  age = {
    identityPaths = [ "${config.home.homeDirectory}/.ssh/id_ed25519" ];
    secrets = {
      bitsrun-rs-config = {
        file = ../secrets/bitsrun-rs-config.age;
        mode = "600";
      };
    };
  };
}
