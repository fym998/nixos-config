let
  fym_on_legion-nixos = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILYregZ1VAGwwCnFJzVmePI2CLsNaVTWzvCBghEEicgP fym@legion-nixos";
  root_on_legion-nixos = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINk0b1d4zHPhfV0je9t2mezyQttbWSKKC0i9T9ER0tRl root@legion-nixos";
  users = [
    fym_on_legion-nixos
    root_on_legion-nixos
  ];

  legion-nixos = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIM2buXuMxA+kXuEkspoNtoSTBCWyDTtGwMJtqlakB1hL root@nixos";
  systems = [ legion-nixos ];

  all = users ++ systems;
in
{
  "mihomo-config.age".publicKeys = all;
  "password-root.age".publicKeys = [ root_on_legion-nixos ] ++ systems;
  "password-fym.age".publicKeys = all;
  "matrix-element-recovery-key.age".publicKeys = all;
}
