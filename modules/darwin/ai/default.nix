{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    nix-ai-tools.copilot-cli
    nix-ai-tools.crush
    ollama
  ];
}
