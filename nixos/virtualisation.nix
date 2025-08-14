{ username, ... }:
{
  virtualisation = {
    podman = {
      enable = true;
      dockerCompat = true;
      dockerSocket.enable = true;
    };
  };

  users.users.${username}.extraGroups = [
    "podman"
    "kvm"
  ];

  hardware.nvidia-container-toolkit.enable = true;
}
