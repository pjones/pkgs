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

  haskell = super.haskell // {
    packages = super.haskell.packages // {
      ghc784  = haskellOverride super.haskell.packages.ghc784;
      ghc7103 = haskellOverride super.haskell.packages.ghc7103;
      ghc802  = haskellOverride super.haskell.packages.ghc802;
      ghc822  = haskellOverride super.haskell.packages.ghc822;
      ghc844  = haskellOverride super.haskell.packages.ghc844;
    };
  };
}
