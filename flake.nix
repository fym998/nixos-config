{
  description = "NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    plasma-manager = {
      url = "github:nix-community/plasma-manager";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };
    nix-darwin = {
      url = "https://flakehub.com/f/nix-darwin/nix-darwin/*";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    agenix = {
      url = "github:ryantm/agenix";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
      inputs.darwin.follows = "nix-darwin";
    };
    impermanence.url = "https://flakehub.com/f/nix-community/impermanence/*";

    nixos-hardware.url = "github:Biaogo/nixos-hardware/master";

    fym998-nur = {
      url = "path:/home/fym/repos/nur-packages";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    pre-commit-hooks = {
      url = "github:cachix/git-hooks.nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    treefmt-nix = {
      url = "github:numtide/treefmt-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    inputs@{ self, nixpkgs, ... }:
    let
      username = "fym";
      hostname = "legion-nixos";
      stateVersion = "25.05";
      system = "x86_64-linux";
      specialArgs = {
        inherit
          inputs
          username
          hostname
          stateVersion
          system
          ;
      };

      pkgs = import nixpkgs {
        inherit system;
      };

      treefmtEval.${system} = inputs.treefmt-nix.lib.evalModule pkgs {
        projectRootFile = "flake.nix";
        programs.nixfmt.enable = true;
      };
    in
    {
      inputs = inputs; # for debug
      nixosConfigurations = {
        ${hostname} = nixpkgs.lib.nixosSystem {
          inherit specialArgs system;

          modules = [
            ./nixos
            inputs.agenix.nixosModules.default
            #inputs.impermanence.nixosModules.impermanence
            inputs.home-manager.nixosModules.home-manager
            {
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                users.${username} = ./home-manager;
                extraSpecialArgs = specialArgs;
                sharedModules = [
                  inputs.plasma-manager.homeManagerModules.plasma-manager
                  inputs.agenix.homeManagerModules.default
                ];
                backupFileExtension = "backup";
              };
            }
            inputs.nixos-hardware.nixosModules.lenovo-legion-16iah7h
          ];
        };
      };

      formatter.${system} = treefmtEval.${system}.config.build.wrapper;

      checks.${system} = {
        pre-commit = inputs.pre-commit-hooks.lib.${system}.run {
          src = ./.;
          hooks.treefmt = {
            enable = true;
            packageOverrides.treefmt = treefmtEval.${system}.config.build.wrapper;
          };
        };
        # formatting = treefmtEval.${pkgs.system}.config.build.check self;
      };

      devShells.${system} = {
        default = pkgs.mkShellNoCC {
          inherit (self.checks.${system}.pre-commit) shellHook;
          buildInputs = self.checks.${system}.pre-commit.enabledPackages;
          packages = with pkgs; [
            nil
            # nixd
          ];
        };
      };
    };

}
