{
  config,
  lib,
  ...
}: {
  options.safari.fish.enable = lib.mkEnableOption "fish" // {default = config.safari.enable;};

  config = lib.mkIf config.safari.fish.enable {
    programs.fish = {
      enable = true;
      functions.fish_greeting = lib.mkDefault "";

      interactiveShellInit = ''
        # Set up Homebrew environment if available
        if test -x /opt/homebrew/bin/brew
          eval (/opt/homebrew/bin/brew shellenv)
        end

        # Set TERM for Ghostty terminal
        if test "$TERM_PROGRAM" = "ghostty"
          set -gx TERM xterm-256color
        end
      '';
    };
  };
}
