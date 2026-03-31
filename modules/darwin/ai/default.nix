{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    llm-agents.copilot-cli
    llm-agents.opencode
    llm-agents.beads-rust
    llm-agents.beads-viewer
    ollama
  ];
}
