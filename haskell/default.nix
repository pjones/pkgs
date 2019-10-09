################################################################################
# This is a Nixpkgs overlay.
self:   # Final package set.
super:  # Base package set.

let
  pkgs = super;

  # Helper function to override Haskell packages:
  haskellOverride = set:
    set.override (orig: {
      overrides = super.lib.composeExtensions
                    (orig.overrides or (_: _: {}))
                    (import ./overrides.nix pkgs);
    });

in
{
  haskellPackages = haskellOverride super.haskellPackages;
}
