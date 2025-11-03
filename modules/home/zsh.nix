{
  config,
  lib,
  ...
}: {
  options.safari.zsh.enable = lib.mkEnableOption "zsh" // {default = config.safari.enable;};

  config = lib.mkIf config.safari.zsh.enable {
    programs.zsh = {
      enable = true;
      enableCompletion = true;
      enableVteIntegration = true;
      autocd = true;
      autosuggestion.enable = true;

      initContent = ''
        [[ -x /opt/homebrew/bin/brew ]] && eval $(/opt/homebrew/bin/brew shellenv)

        if [[ "$TERM_PROGRAM" == "ghostty" ]]; then
          export TERM=xterm-256color
        fi
      '';

      historySubstringSearch.enable = true;

      history = {
        expireDuplicatesFirst = true;
        extended = true;
        ignoreAllDups = true;
      };
    };
  };
}
