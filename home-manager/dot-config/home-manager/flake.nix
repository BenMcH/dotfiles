{
  description = "Home Manager configuration for multiple systems";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, home-manager, ... }:
    let
      # Define system configurations
      systems = {
        "x86_64-linux" = {
          users = {
            mchone = {
              homeDirectory = "/home/mchone";
              modules = [ ./home/mchone.nix ];
            };
          };
        };
        "aarch64-darwin" = {
          users = {
            bmchone = {
              homeDirectory = "/Users/bmchone";
              modules = [ ./home/mchone.nix ];
            };
          };
        };
      };

      # Function to create a home configuration for a specific system and user
      mkHomeConfiguration = system: username: userConfig:
        let
          pkgs = import nixpkgs {
            inherit system;
            config.allowUnfree = true;
          };
        in
        home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          modules = userConfig.modules;
          extraSpecialArgs = {
            inherit username system;
            homeDirectory = userConfig.homeDirectory;
          };
        };

      # Generate all home configurations
      homeConfigurations = builtins.listToAttrs (
        builtins.concatLists (
          builtins.attrValues (
            builtins.mapAttrs (system: systemConfig:
              builtins.attrValues (
                builtins.mapAttrs (username: userConfig:
                  {
                    name = "${username}@${system}";
                    value = mkHomeConfiguration system username userConfig;
                  }
                ) systemConfig.users
              )
            ) systems
          )
        )
      );
    in {
      inherit homeConfigurations;
    };
}
