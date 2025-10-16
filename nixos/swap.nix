{
  boot.kernel = {
    sysctl."vm.swappiness" = 1;
    sysfs.module.zswap.parameters.enabled = 1;
  };

  swapDevices = [
    {
      device = "/dev/disk/by-uuid/fff61ca9-9eb5-421d-86f2-78352645564b";
      options = [ "discard=once" ];
    }
  ];
}
