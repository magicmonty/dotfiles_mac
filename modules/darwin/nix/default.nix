{pkgs, ...}: {
  nix = {
    enable = true;
    package = pkgs.nixVersions.stable;
    settings = {
      cores = 0;
      max-jobs = 10;
      extra-substituters = [
        "https://cache.numtide.com" # Binary cache for llm-agents input
      ];
      extra-trusted-public-keys = [
        "niks3.numtide.com-1:DTx8wZduET09hRmMtKdQDxNNthLQETkc/yaX7M4qK0g=" #
      ];
    };
    optimise.automatic = true;
    gc = {
      automatic = true;
      options = "-d";
    };
    extraOptions = "experimental-features = nix-command flakes";
  };
}
