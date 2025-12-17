{
  config,
  lib,
  ...
}: {
  options.safari.oh-my-posh.enable = lib.mkEnableOption "oh-my-posh" // {default = config.safari.enable;};

  config = lib.mkIf config.safari.oh-my-posh.enable {
    programs.oh-my-posh = {
      enable = true;
      enableBashIntegration = config.safari.bash.enable;
      enableFishIntegration = config.safari.fish.enable;
      enableZshIntegration = config.safari.zsh.enable;
      settings = builtins.fromJSON (builtins.readFile ./oh-my-posh.omp.json);
    };
  };
}
