{
  services = {
    ollama = {
      enable = false;
      acceleration = "cuda";
      environmentVariables = {
        OLLAMA_ORIGINS = "*";
      };
    };

    nextjs-ollama-llm-ui.enable = false;
  };
}
