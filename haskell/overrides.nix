pkgs: self: super:

let
  utils = import ../utils.nix { inherit pkgs; };

in {
  byline            = utils.fetchGitJSON ./byline.json;
  cassava-streams   = utils.fetchGitJSON ./cassava-streams.json;
  clockdown         = utils.fetchGitJSON ./clockdown.json;
  devalot-backend   = utils.fetchGitJSON ./devalot-backend.json;
  personal-webhooks = utils.fetchGitJSON ./personal-webhooks.json;
  playlists         = utils.fetchGitJSON ./playlists.json;
  playlists-http    = utils.fetchGitJSON ./playlists-http.json;
  themoviedb        = utils.fetchGitJSON ./themoviedb.json;
  vimeta            = utils.fetchGitJSON ./vimeta.json;
  wschat            = utils.fetchGitJSON ./wschat.json;
}
