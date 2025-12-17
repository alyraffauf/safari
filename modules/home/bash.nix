{
  config,
  lib,
  ...
}: {
  options.safari.bash.enable = lib.mkEnableOption "bash" // {default = config.safari.enable;};

  config = lib.mkIf config.safari.bash.enable {
    programs.bash = {
      enable = true;
      enableCompletion = true;
      enableVteIntegration = true;

      initExtra = ''
        # Set up Homebrew environment if available
        [[ -x /opt/homebrew/bin/brew ]] && eval $(/opt/homebrew/bin/brew shellenv)
        [[ -x /home/linuxbrew/.linuxbrew/bin/brew ]] && eval $(/home/linuxbrew/.linuxbrew/bin/brew shellenv)

        # Set TERM for Ghostty terminal
        if [[ "$TERM_PROGRAM" == "ghostty" ]]; then
          export TERM=xterm-256color
        fi
      '';

      historyControl = ["erasedups" "ignoredups" "ignorespace"];
      historyIgnore = ["ls" "cd" "exit"];
    };
  };
}
