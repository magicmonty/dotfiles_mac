{nixvim, ...}: final: prev: let
  config = {
    enable = true;
    tesseract_image = "tesseract";
    tesseract_docker_host_dir = "/tmp";
    container_runtime = "docker";
  };
in {
  neovim-lite = nixvim.packages.${prev.system}.lite-obsidian.extend {
    config.sys.lang.obsidian = config;
  };
  neovim-full = nixvim.packages.${prev.system}.full.extend {
    config.sys.lang.obsidian = config;
  };
  neovim = nixvim.packages.${prev.system}.default.extend {
    config.sys.lang.obsidian = config;
  };
}
