{
  description = "NixOS Configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs";
    flake-utils.url = "github:numtide/flake-utils";

    neo4j.url = "path:/etc/nixos/modules/neo4j";
  };

  outputs = { self, nixpkgs, flake-utils, neo4j, ... }: {
    nixosConfigurations.aaalmeida = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        ./configuration.nix
        #neo4j.nixosModules.default
      ];
    };
  };
}
