{
  description = "REPLICANT SHELL";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, utils }:
    utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };
      in
      {
        devShell = with pkgs; mkShell {
          buildInputs = [
            go_1_24
            gopls  # Go LSP for editor support
            golangci-lint # Linter
            gotools # Additional Go tools
            pre-commit # Pre-commit hooks
            protobuf   # Protocol Buffers compiler
            buf        # Protocol Buffers toolchain
            google-cloud-sdk # Google Cloud CLI
          ];

          shellHook = ''
            echo "[REPLICANT]: Welcome back, Nick"
            go version
          '';
        };
      }
    );
}

