{
  atomi,
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
        bunPkg = pkgs-2605.bun;
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
        deps = pkgs-2605.stdenv.mkDerivation {
          pname = "${cliName}-deps";
          version = manifest.version;
          inherit src;
          nativeBuildInputs = [ bunPkg ];
          dontConfigure = true;
          # Production deps only: the compiled binary bundles runtime imports (all pure JS),
          # and excluding devDependencies (notably the platform-specific @biomejs/biome binary)
          # keeps node_modules identical across linux/darwin so one fixed-output hash suffices.
          buildPhase = ''
            export HOME="$TMPDIR"
            bun install --frozen-lockfile --no-progress --production
          '';
          installPhase = ''
            mkdir -p "$out"
            cp -r node_modules "$out/node_modules"
          '';
          dontFixup = true;
          outputHashMode = "recursive";
          outputHashAlgo = "sha256";
          outputHash = "sha256-//nzVPVDGPwgvscaKBcyZhmXXlA6hU3Bt3l6jT5AWH8=";
        };
      in
      {
        bun-cli = pkgs-2605.stdenv.mkDerivation {
          pname = cliName;
          version = manifest.version;
          inherit src;
          nativeBuildInputs = [ bunPkg ];
          dontConfigure = true;
          buildPhase = ''
            export HOME="$TMPDIR"
            cp -r ${deps}/node_modules ./node_modules
            chmod -R u+w node_modules
            bun build "./${entry}" --compile --outfile "${cliName}"
          '';
          installPhase = ''
            mkdir -p "$out/bin"
            cp "${cliName}" "$out/bin/${cliName}"
          '';
          dontFixup = true;
          meta.mainProgram = cliName;
        };
      };
  };
in
with all;
nix-2605 // nix-unstable // atomipkgs // cli
