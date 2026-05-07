{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    llm-agents.opencode
    llm-agents.beads-rust
    llm-agents.beads-viewer
    defuddle-cli
    ollama
  ];
}
