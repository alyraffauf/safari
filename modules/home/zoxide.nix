{
  config,
  lib,
  ...
}: {
  options.safari.zoxide = {
    enable = lib.mkEnableOption "zoxide" // {default = config.safari.enable;};

    replaceCd = lib.mkOption {
      description = "Replace 'cd' command with zoxide.";
      type = lib.types.bool;
      default = true;
    };
  };

  config = lib.mkIf config.safari.zoxide.enable {
    programs.zoxide = {
      enable = true;
      enableBashIntegration = config.safari.bash.enable;
      enableFishIntegration = config.safari.fish.enable;
      enableZshIntegration = config.safari.zsh.enable;

      options =
        lib.optionals config.safari.zoxide.replaceCd
        ["--cmd cd"];
    };
  };
}
