{ pkgs, packages }:
with packages;
{
  dev = [
    git
    go-task
    infisical
    releaser
    # ### bun-cli-dev-release-tools
    # #### source: bun-cli
    dpkg
    gh
    go
    goreleaser
    rpm
  ];

  lint = [
    actionlint
    dlint
    infralint-core
    infralint-docker
    pre-commit
    shellcheck
    skills-sync
    treefmt
  ];

  main = [
    # ### bun-base-main
    # #### source: bun-base
    bun
    nodejs
    # setup.sh runs `releaser conventions`; the probes run setup in .#ci
    releaser
    cyanprint
    git
    go-task
    infisical
    shellcheck
  ];

  releaser = [
    # ### bun-cli-release-tools
    # #### source: bun-cli
    dpkg
    gh
    git
    go
    goreleaser
    rpm
    releaser
  ];

  system = [
    atomiutils
    infrautils-core
    infrautils-docker
    nix
  ];
}
