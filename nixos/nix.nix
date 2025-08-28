{
  nix = {
    channel.enable = false;
    # gc = {
    #   automatic = true;
    #   dates = "weekly";
    # };
    settings = rec {
      cores = 13;
      allow-import-from-derivation = false;
      allowed-users = [ "@wheel" ];
      trusted-users = allowed-users;
      substituters = [
        "https://mirror.sjtu.edu.cn/nix-channels/store"
        "https://mirrors.tuna.tsinghua.edu.cn/nix-channels/store"
        "https://nix-community.cachix.org"
        "https://fym998-nur.cachix.org"
        "https://pre-commit-hooks.cachix.org"
      ];
      trusted-public-keys = [
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
        "fym998-nur.cachix.org-1:lWwztkEXGJsiJHh/5FbA2u95AxJu8/k4udgGqdFLhOU="
        "pre-commit-hooks.cachix.org-1:Pkk3Panw5AW24TOv6kz3PvLhlH8puAsJTBbOPmBo7Rc="
      ];
      experimental-features = [
        "nix-command"
        "flakes"
      ];
      auto-optimise-store = true;
      flake-registry = "";
    };
  };
}
