{
  config,
  lib,
  ...
}: {
  options.safari.oh-my-posh.enable = lib.mkEnableOption "oh-my-posh" // {default = config.safari.enable;};

  config = lib.mkIf config.safari.oh-my-posh.enable {
    programs.oh-my-posh = {
      enable = true;
      useTheme = "onehalf.minimal";
    };
  };
}
