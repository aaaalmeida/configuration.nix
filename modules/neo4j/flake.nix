{
  description = "Neo4j Module for NixOS (NoSQL Graph Database)";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs";
  };

  outputs = { self, nixpkgs }: {
    nixosModules.default = { config, lib, pkgs, ... }: {
      #options.services.neo4j.enable = lib.mkEnableOption "Enable Neo4j service";

      config = lib.mkIf config.services.neo4j.enable {
        services.neo4j = {
          #enable = true;
          package = pkgs.neo4j;
          dataDir = "/var/lib/neo4j/data";
          #logDir = "/var/log/neo4j";
        };
      };
    };
  };
}
