{
  config,
  lib,
  pkgs,
  ...
}: {
  options.safari.pay-respects.enable = lib.mkEnableOption "pay-respectsl" // {default = config.safari.enable;};

  config = lib.mkIf config.safari.pay-respects.enable {
    home.packages = [pkgs.nix-search-cli];
    programs.pay-respects.enable = true;
  };
}
