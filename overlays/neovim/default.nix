{nixvim, ...}: final: prev: {
  neovim = nixvim.${prev.system}.lite;
}
