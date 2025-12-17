{
  config,
  lib,
  ...
}: {
  options.safari.eza.enable = lib.mkEnableOption "eza" // {default = config.safari.enable;};

  config = lib.mkIf config.safari.eza.enable {
    home.shellAliases = {
      l = "eza -lah";
      tree = "eza --tree";
    };

    programs.eza = {
      enable = true;
      enableBashIntegration = config.safari.bash.enable;
      enableFishIntegration = config.safari.fish.enable;
      enableZshIntegration = config.safari.zsh.enable;
      extraOptions = ["--group-directories-first" "--header"];
      git = true;
      icons = "auto";
    };
  };
}
