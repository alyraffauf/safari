{
  config,
  lib,
  pkgs,
  osConfig ? null,
  ...
}: {
  options.safari.topgrade.enable = lib.mkEnableOption "topgrade" // {default = config.safari.enable;};

  config = lib.mkIf config.safari.topgrade.enable {
    home.packages = [pkgs.gcc];

    programs.topgrade = {
      enable = true;

      settings = {
        misc = {
          assume_yes = true;

          disable = [
            "home_manager"
            "nix"
            "nix_helper"
            "system"
          ];
        };

        commands =
          lib.optionalAttrs (osConfig == null) {
            "Home-manager" = "nh home switch -b backup";
          }
          // lib.optionalAttrs ((osConfig != null) && pkgs.stdenv.isLinux) {
            "NixOS" = "nh os switch";
          }
          // lib.optionalAttrs ((osConfig != null) && pkgs.stdenv.isDarwin) {
            "nix-darwin" = "nh darwin switch";
          };
      };
    };
  };
}
