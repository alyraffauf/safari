{
  config,
  lib,
  ...
}: {
  options.safari.nix-your-shell.enable = lib.mkEnableOption "nix-your-shell" // {default = config.safari.enable;};

  config = lib.mkIf config.safari.nix-your-shell.enable {
    programs.nix-your-shell = {
      enable = true;
      enableZshIntegration = config.safari.zsh.enable;
    };
  };
}
