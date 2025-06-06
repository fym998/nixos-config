{ config, username, ... }:
{
  users.mutableUsers = false;
  users.users.root.hashedPasswordFile = config.age.secrets.password-root.path;
  users.users.${username} = {
    isNormalUser = true;
    description = "FU Yiming";
    extraGroups = [ "wheel" ];
    hashedPasswordFile = config.age.secrets.password-fym.path;
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINvaO32WYshCazWrbxkkr1vqlWmgUsANmVq9nyX1ovHP u0_a377@localhost"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIN+XwudZm9jiNkALdZSSKzUP9nNa8s8voq24/Eo6Q7lG u0_a200@localhost"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILYregZ1VAGwwCnFJzVmePI2CLsNaVTWzvCBghEEicgP fym@legion-nixos"
    ];
  };
}
