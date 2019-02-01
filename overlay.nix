################################################################################
# This is a Nixpkgs overlay.
self:   # Final package set.
super:  # Base package set.

let
  utils = import ./utils.nix { pkgs = super; };

in rec {
  pjones = {

    ############################################################################
    # Export my utility functions so I can use them elsewhere:
    inherit utils;

    ############################################################################
    # Configuration files:
    bashrc  = utils.fetchGitJSON ./rc/bashrc.json;
    emacsrc = utils.fetchGitJSON ./rc/emacsrc.json;
    tmuxrc  = utils.fetchGitJSON ./rc/tmuxrc.json;
    zshrc   = utils.fetchGitJSON ./rc/zshrc.json;

    ##############################################################################
    # Miscellaneous scripts:
    backup-scripts   = utils.fetchGitJSON ./scripts/backup-scripts.json;
    dns-scripts      = utils.fetchGitJSON ./scripts/dns-scripts.json;
    encryption-utils = utils.fetchGitJSON ./scripts/encryption-utils.json;

  };
} // (import ./haskell/default.nix self super)
