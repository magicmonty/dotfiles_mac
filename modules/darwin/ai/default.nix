{pkgs, ...}: {
  environment.systemPackages = with pkgs.nix-ai-tools; [
    copilot-cli
    crush
  ];
}
