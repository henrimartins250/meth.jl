{
  description = "julia devShell";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = {
    self,
    nixpkgs,
    flake-utils,
  }:
    flake-utils.lib.eachDefaultSystem (system: let
      pkgs = import nixpkgs {inherit system;};
    in {
      devShells.default = pkgs.mkShell {
        buildInputs = with pkgs; [
          julia
          # Makie needs system deps for CairoMakie:
          cairo
          pango
          harfbuzz
          freetype
          fontconfig
          libGL
          mesa

          zsh
        ];

        shellHook = ''
          echo "🚀 Entered chaos shapes shell💥"
          export SHELL=$(which zsh)   # or zsh
        '';
      };
    });
}
