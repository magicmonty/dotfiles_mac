{nixvim, ...}: final: prev: {
  neovim-lite = nixvim.packages.${prev.system}.lite-obsidian;
  neovim = nixvim.packages.${prev.system}.default;
}
