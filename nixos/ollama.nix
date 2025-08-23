{
  services = {
    ollama = {
      enable = true;
      acceleration = "cuda";
      environmentVariables = {
        OLLAMA_ORIGINS = "*";
      };
    };

    nextjs-ollama-llm-ui.enable = true;
  };
}
