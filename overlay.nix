################################################################################
# This is a Nixpkgs overlay.
self:   # Final package set.
super:  # Base package set.

let
  utils = import ./utils.nix { pkgs = super; };
  debug = import ./utils/debug.nix self super;

in rec {
  pjones = {

    ############################################################################
    # Export my utility functions so I can use them elsewhere:
    inherit utils debug;

    ############################################################################
    # Configuration files:
    bashrc   = utils.fetchGitJSON ./rc/bashrc.json;
    emacsrc  = utils.fetchGitJSON ./rc/emacsrc.json;
    tmuxrc   = utils.fetchGitJSON ./rc/tmuxrc.json;
    zshrc    = utils.fetchGitJSON ./rc/zshrc.json;
    xmonadrc = utils.fetchGitJSON ./rc/xmonadrc.json;

    ############################################################################
    # Miscellaneous scripts:
    backup-scripts   = utils.fetchGitJSON ./scripts/backup-scripts.json;
    dns-scripts      = utils.fetchGitJSON ./scripts/dns-scripts.json;
    encryption-utils = utils.fetchGitJSON ./scripts/encryption-utils.json;
    network-scripts  = utils.fetchGitJSON ./scripts/network-scripts.json;

  }
  # Bring in all of my Haskell packages:
  // (import ./haskell/overrides.nix self self super);


}

# Override system Haskell packages:
// (import ./haskell/default.nix self super)
