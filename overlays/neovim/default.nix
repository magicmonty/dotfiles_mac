{nixvim, ...}: final: prev: {
  neovim-lite = nixvim.packages.${prev.system}.lite-obsidian;
  neovim-full = nixvim.packages.${prev.system}.full;
  neovim = nixvim.packages.${prev.system}.default;
}
