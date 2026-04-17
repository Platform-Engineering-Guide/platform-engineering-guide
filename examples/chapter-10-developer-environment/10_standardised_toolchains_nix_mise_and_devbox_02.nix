# flake.nix — Nix flake for reproducible development environment
{
  description = "Payments Service Development Environment";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
      in
      {
        devShells.default = pkgs.mkShell {
          buildInputs = [
            pkgs.jdk21
            pkgs.maven
            pkgs.nodejs_22
            pkgs.kubectl
            pkgs.kubernetes-helm
            pkgs.awscli2
            pkgs.docker-compose
          ];

          shellHook = ''
            export JAVA_HOME=${pkgs.jdk21}
            export MAVEN_OPTS="-Xmx2g -XX:+UseG1GC"
            echo "Payments service development environment ready"
          '';
        };
      }
    );
}
