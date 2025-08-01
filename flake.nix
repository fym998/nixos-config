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
      url = "github:nix-darwin/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    agenix = {
      url = "github:ryantm/agenix";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
      inputs.darwin.follows = "nix-darwin";
    };
    impermanence.url = "github:nix-community/impermanence";

    nixos-hardware.url = "github:Biaogo/nixos-hardware/master";

    fym998-nur = {
      url = "github:fym998/nur-packages";
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
      system = "x86_64-linux";

      pkgs = import nixpkgs {
        inherit system;
        config = {
          allowUnfree = true;
          packageOverrides = pkgs: inputs.fym998-nur.overlays.default pkgs pkgs;
        };
      };

      treefmtEval.${system} = inputs.treefmt-nix.lib.evalModule pkgs {
        projectRootFile = "flake.nix";
        programs.nixfmt.enable = true;
      };
    in
    {
      inputs = inputs; # for debug
      nixosConfigurations =
        let
          username = "fym";
          hostname = "legion-nixos";
          stateVersion = "25.05";
          specialArgs = {
            inherit
              inputs
              username
              hostname
              stateVersion
              system
              ;
          };
        in
        {
          ${hostname} = nixpkgs.lib.nixosSystem {
            inherit specialArgs system;

            modules = [
              { nixpkgs.pkgs = pkgs; }
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
        formatting = treefmtEval.${pkgs.system}.config.build.check self;
      };

      devShells.${system}.default =
        let
          pre-commit = inputs.pre-commit-hooks.lib.${system}.run {
            src = ./.;
            hooks.treefmt = {
              enable = true;
              package = treefmtEval.${system}.config.build.wrapper;
            };
          };
        in
        pkgs.mkShellNoCC {
          inherit (pre-commit) shellHook;
          buildInputs = pre-commit.enabledPackages;
          packages = with pkgs; [
            nil
          ];
        };
    };
}
