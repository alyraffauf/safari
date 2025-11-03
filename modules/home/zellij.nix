{
  config,
  lib,
  ...
}: {
  options.safari.zellij.enable = lib.mkEnableOption "zellij";

  config = lib.mkIf config.safari.zellij.enable {
    programs.zellij = {
      enable = true;
      enableZshIntegration = config.safari.zsh.enable;
    };
  };
}
