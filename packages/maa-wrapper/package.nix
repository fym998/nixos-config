{
  android-tools,
  kdePackages,
  umu-launcher-wrapper,
  writeShellApplication,
}:
writeShellApplication {
  name = "maa";
  runtimeInputs = [
    android-tools
    kdePackages.kdialog
    umu-launcher-wrapper
  ];
  excludeShellChecks = [ "SC2181" ];
  bashOptions = [
    "nounset"
    "pipefail"
  ];
  text = builtins.readFile ./maa.sh;
}
