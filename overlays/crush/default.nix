{nix-ai-tools, ...}: final: prev: {
  inherit (nix-ai-tools.packages.${prev.system}) crush;
}
