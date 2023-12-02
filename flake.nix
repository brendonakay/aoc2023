{
  description = "OCaml with Opam package management";

  inputs = {
      nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
      flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system: 
      let
        pkgs = nixpkgs.legacyPackages.${system};
      in
      {
        devShells.default = pkgs.mkShell {
            buildInputs = with pkgs; [
              opam
              gmp
              pkg-config
              openssl
            ];
        };
        #packages.default = pkgs.stdenv.stdenv.mkDerivation (finalAttrs: {
        #  pname = "aoc-ocaml-with-tmpl";
        #  version = "";

        #  src = ./.;

        #  # TODO
        #  nativeBuildInputs = [];
        #  buildInputs = [];

        #  meta = {
        #    description = "";
        #    homepage = "";
        #    # license = lib.licenses.;
        #    # maintainers = with lib.maintainers; [  ];
        #  };
        #});
      }
    );
}
