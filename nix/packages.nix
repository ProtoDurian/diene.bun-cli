{
  atomi,
  atomiLib,
  pkgs-2605,
  pkgs-unstable,
}:
let
  all = rec {
    atomipkgs = (
      with atomi;
      {
        inherit
          atomiutils
          cyanprint
          dlint
          # Axis-pure slices: the infralint/infrautils aggregates ship helm, helm-docs and helmlint.
          infralint-core
          infralint-docker
          infrautils-core
          infrautils-docker
          releaser
          skills-sync
          ;
      }
    );
    nix-unstable = (with pkgs-unstable; { });
    nix-2605 = (
      with pkgs-2605;
      {
        inherit
          actionlint
          # ### bun-base-packages
          # #### source: bun-base
          bun
          nodejs
          dpkg
          gh
          git
          go
          go-task
          goreleaser
          infisical
          nix
          pre-commit
          ripgrep
          rpm
          shellcheck
          treefmt
          ;
      }
    );

    # ### bun-cli-package
    # #### source: bun-cli
    cli =
      let
        manifest = builtins.fromJSON (builtins.readFile ../package.json);
        cliNames = builtins.attrNames manifest.bin;
        cliName =
          if builtins.length cliNames == 1 then
            builtins.head cliNames
          else
            builtins.throw "bun-cli package requires exactly one package.json bin entry";
        entry = manifest.bin.${cliName};
        src = pkgs-2605.lib.cleanSourceWith {
          src = ../.;
          filter =
            path: _type:
            let
              base = baseNameOf path;
            in
            !(builtins.elem base [
              "node_modules"
              "dist"
              "prebuilt"
              "coverage"
              ".direnv"
              "result"
            ]);
        };
      in
      {
        # Owner !A78: the compiled CLI comes from the registry builder, never an in-template derivation.
        # !A84: keep the pinned bun (the compiled runtime and the deps hash depend on it).
        bun-cli = atomiLib.buildBunCli {
          name = cliName;
          version = manifest.version;
          inherit src;
          entrypoint = entry;
          depsHash = "sha256-mIb7xR1Cq1bjxDU0qK7T3jC5K0R1GfDiJy5LODpDfDg=";
          bun = pkgs-2605.bun;
        };
      };
  };
in
with all;
nix-2605 // nix-unstable // atomipkgs // cli
