{
  age.secrets = {
    mihomo-config.file = ../secrets/mihomo-config.age;
    password-root.file = ../secrets/password-root.age;
    password-fym.file = ../secrets/password-fym.age;
    bitsrun-rs-config = {
      file = ../secrets/bitsrun-rs-config.age;
      mode = "600";
    };
  };
}
