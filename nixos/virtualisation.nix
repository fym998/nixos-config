{ username, ... }:
{
  virtualisation = {
    waydroid.enable = true;

    podman = {
      enable = true;
      dockerCompat = true;
      dockerSocket.enable = true;
    };
  };

  users.users.${username}.extraGroups = [
    "podman"
  ];
}
