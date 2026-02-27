{llm-agents, ...}: _final: prev: {
  llm-agents = llm-agents.packages.${prev.stdenv.hostPlatform.system};
}
