{
  config,
  lib,
  pkgs,
  ...
}: {
  options.safari.uutils.enable = lib.mkEnableOption "uutils coreutils" // {default = config.safari.enable;};

  config = lib.mkIf config.safari.uutils.enable {
    home.packages = with pkgs; [(lib.hiPrio uutils-coreutils-noprefix)];
  };
}
