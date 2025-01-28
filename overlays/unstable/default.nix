{channels, ...}: _final: _prev: {
  vimPlugins.vim-sensible = channels.unstable.vimPlugins.vim-sensible;
  inherit (channels.unstable) electron feishin;
}
