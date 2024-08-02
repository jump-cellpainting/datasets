# Flake to set up an environment to upload profile_index.csv to Zenodo.
{
  inputs = {
    dream2nix.url = "github:nix-community/dream2nix";
    nixpkgs.follows = "dream2nix/nixpkgs";
    flake-utils.url = "github:numtide/flake-utils";
    systems.url = "github:nix-systems/default";
    devenv.url = "github:cachix/devenv";
  };

  outputs = { self, nixpkgs, devenv, systems, dream2nix, ... } @ inputs:
    inputs.flake-utils.lib.eachDefaultSystem (system:
      let

        pkgs = import nixpkgs {
          system = system;
          config.allowUnfree = true;
        };

      in  {
        devShells = with pkgs;
            {
              default = pkgs.mkShell {
                packages = [
                  coreutils
                  jq
                  curl
                  gawk
                  moreutils
                ];
              };
            };
      }
    );
}
