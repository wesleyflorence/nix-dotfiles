{
  description = "Home Manager configuration of wesley";

  inputs = {
    # Specify the source of Home Manager and Nixpkgs.
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-search-cli = {
      url = "github:peterldowns/nix-search-cli";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, flake-utils, home-manager, nix-search-cli, ... }:
    flake-utils.lib.eachSystem [ "x86_64-linux" "aarch64-darwin" ] (system:
      let
        # Define an overlay that adds nix-search-cli to the package set
        overlay = final: prev: {
          nix-search-cli = nix-search-cli.packages.${system}.nix-search;
        };

        # Apply the overlay to get a modified pkgs
        pkgs = import nixpkgs {
          inherit system;
          overlays = [ overlay ];
        };

        # Determine the username and home directory based on the system
        user = if system == "x86_64-linux" then "wesley" else "wesleyflorence";
        homeDir = if system == "x86_64-linux" then "/home/wesley" else "/Users/wesleyflorence";
      in {
        packages.homeConfigurations = {
          # thinkpad user
          "${user}" = home-manager.lib.homeManagerConfiguration {
            inherit pkgs;

            # Specify your home configuration modules here, for example,
            # the path to your home.nix.
            modules = [ ./home.nix ];

            # Optionally use extraSpecialArgs
            # to pass through arguments to home.nix
            extraSpecialArgs = { inherit user homeDir; };
          };
        };
      });
}
