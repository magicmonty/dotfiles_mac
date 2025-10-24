{nix-ai-tools, ...}: _final: prev: {
  nix-ai-tools = nix-ai-tools.packages.${prev.system};
}
