{nixvim, ...}: final: prev: {
  neovim-lite = nixvim.packages.${prev.system}.lite;
  neovim = nixvim.packages.${prev.system}.default;
}
