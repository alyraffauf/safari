{
  config,
  lib,
  ...
}: {
  options.safari.ripgrep.enable = lib.mkEnableOption "ripgrep and ripgrep-all" // {default = config.safari.enable;};

  config = lib.mkIf config.safari.ripgrep.enable {
    programs = {
      ripgrep = {
        enable = true;
        arguments = ["--pretty"];
      };

      ripgrep-all.enable = true;
    };
  };
}
