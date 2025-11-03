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
      enableZshIntegration = config.safari.zsh.enable;
      extraOptions = ["--group-directories-first" "--header"];
      git = true;
      icons = "auto";
    };
  };
}
