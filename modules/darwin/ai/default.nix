{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    llm-agents.copilot-cli
    llm-agents.crush
    ollama
  ];
}
