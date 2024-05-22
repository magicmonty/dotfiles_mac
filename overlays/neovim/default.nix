{nixvim, ...}: final: prev: {
  neovim = nixvim.packages.${prev.system}.lite;
  neovim-lite = nixvim.packages.${prev.system}.default;
}
