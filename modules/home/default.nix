{
  config,
  lib,
  pkgs,
  ...
}: {
  imports = [
    ./cli.nix
    ./direnv.nix
    ./eza.nix
    ./fastfetch.nix
    ./fish.nix
    ./helix.nix
    ./joshuto.nix
    ./motd.nix
    ./nix-your-shell.nix
    ./oh-my-posh.nix
    ./ripgrep.nix
    ./uutils.nix
    ./zellij.nix
    ./zoxide.nix
    ./zsh.nix
  ];

  options.safari.enable = lib.mkEnableOption "safari shell environment";

  config = lib.mkIf config.safari.enable {
    home = {
      packages = with pkgs;
        [
          curl
          just
          wget
        ]
        ++ lib.optionals pkgs.stdenv.isLinux [
          (pkgs.inxi.override {withRecommends = true;})
        ];
    };

    programs = {
      bat.enable = true;
      fzf.enable = true;
      htop.enable = true;
    };
  };
}
