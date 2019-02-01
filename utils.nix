{ pkgs }:

with pkgs.lib;

rec {

  ##############################################################################
  fetchGitJSON = file:
    let json  = importJSON file;
        attrs = removeAttrs json ["date"];
    in import "${pkgs.fetchgit attrs}/default.nix" { inherit pkgs; };

  ##############################################################################
  # Build a custom Nix environment.
  #
  # This function expects an environment name and a list of packages.
  # It will generate a simple derivation that depends on those
  # packages along with a tiny wrapper around nix-shell to load those
  # packages into a shell.
  #
  # Example:
  #
  #   custom-env { name     = "myname";
  #                packages = with pkgs; [ ffmpeg ];
  #              }
  #
  custom-env = {name, packages}:
    let pkgName = "env-${name}";
    in stdenv.mkDerivation {
      name = pkgName;
      buildInputs = packages;
      phases = [ "installPhase" ];
      installPhase = ''
        mkdir -p $out/bin

        cat > $out/bin/${pkgName} <<EOT
        #!/bin/sh -eu
        nix-shell -p ${concatStringsSep " " packages} "$@"
        EOT

        chmod 0555 $out/bin/${pkgName}
      '';
  };
}
