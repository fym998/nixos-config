{
  description = "NixOS configuration";

  inputs = {
    nixpkgs.url = "https://flakehub.com/f/NixOS/nixpkgs/0.2505.*";

    home-manager = {
      url = "https://flakehub.com/f/nix-community/home-manager/0.2505.*";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    plasma-manager = {
      url = "github:nix-community/plasma-manager";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };
    nix-darwin = {
      url = "https://flakehub.com/f/nix-darwin/nix-darwin/0.2505.*";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    agenix = {
      url = "https://flakehub.com/f/ryantm/agenix/*";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
      inputs.darwin.follows = "nix-darwin";
    };
    impermanence.url = "https://flakehub.com/f/nix-community/impermanence/*";

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

      pkgs = import nixpkgs { inherit system; };

      treefmtEval.${system} = inputs.treefmt-nix.lib.evalModule pkgs {
        projectRootFile = "flake.nix";
        programs.nixfmt.enable = true;
        programs.deadnix.enable = true;
      };
    in
    {
      # inputs = inputs; # for debug
      nixosConfigurations = {
        ${hostname} = nixpkgs.lib.nixosSystem {
          inherit specialArgs system;

          modules = with inputs; [
            ./nixos
            agenix.nixosModules.default
            #impermanence.nixosModules.impermanence
            home-manager.nixosModules.home-manager
            {
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                users.${username} = ./home-manager;
                extraSpecialArgs = specialArgs;
                sharedModules = [ inputs.plasma-manager.homeManagerModules.plasma-manager ];
                backupFileExtension = "backup";
              };
            }
          ];
        };
      };

      formatter.${system} = treefmtEval.${system}.config.build.wrapper;

      checks.${system} = {
        pre-commit-check = inputs.pre-commit-hooks.lib.${system}.run {
          src = ./.;
          hooks = {
            nixfmt-rfc-style.enable = true;
            deadnix.enable = true;
          };
        };
        # formatting = treefmtEval.${pkgs.system}.config.build.check self;
      };

      devShells.${system} = {
        default = pkgs.mkShellNoCC {
          inherit (self.checks.${system}.pre-commit-check) shellHook;
          buildInputs = self.checks.${system}.pre-commit-check.enabledPackages;
          packages = with pkgs; [
            nil
            # nixd
          ];
        };
      };
    };

}
