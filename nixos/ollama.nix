{
  services = {
    ollama = {
      enable = true;
      acceleration = "cuda";
    };

    nextjs-ollama-llm-ui.enable = true;
  };
}
