{
  config,
  lib,
  ...
}: {
  options.safari.nix-your-shell.enable = lib.mkEnableOption "nix-your-shell" // {default = config.safari.enable;};

  config = lib.mkIf config.safari.nix-your-shell.enable {
    programs.nix-your-shell = {
      enable = true;
      enableBashIntegration = config.safari.bash.enable;
      enableFishIntegration = config.safari.fish.enable;
      enableZshIntegration = config.safari.zsh.enable;
    };
  };
}
