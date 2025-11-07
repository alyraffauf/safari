{
  config,
  lib,
  ...
}: {
  options.safari.motd.enable = lib.mkEnableOption "motd";

  config = lib.mkIf config.safari.motd.enable {
    programs.zsh.initContent = lib.mkIf config.safari.zsh.enable ''
          if [[ -o interactive && ''${SHLVL:-1} -eq 1 ]]; then
            _safari_banner() {
              local title info hv gen genlink dv
              title="safari"

              cat <<'EOF'
                  ,  ,, ,
            , ,; ; ;;  ; ;  ;
          , ; ';  ;  ;; .-'''\ ; ;
      , ;  ;`  ; ,; . / /8b \ ; ;
      `; ; .;'         ;,\8 |  ;  ;
        ` ;/   / `_      ; ;;    ;  ; ;
          |/.'  /9)    ;  ; `    ;  ; ;
          ,/'          ; ; ;  ;   ; ; ; ;
        /_            ;    ;  `    ;  ;
        `?8P"  .      ;  ; ; ; ;     ;  ;;
        | ;  .:: `     ;; ; ;   `  ;  ;
        `' `--._      ;;  ;;  ; ;   ;   ;
        `-..__..--'''   ; ;    ;;   ; ;   ;
                    ;    ; ; ;   ;     ;
      EOF

              print -P ""
              print -P "%F{magenta}welcome to the safari zone%f"
              print -P ""
              print -P "%F{white}Command%f                  │ %F{white}Description%f"
              print -P "─────────────────────────┼─────────────────────────────────────"
              print -P "%F{green}safari --choose%f          │ List all available commands"
              print -P "%F{green}safari info%f              │ View system information"
              print -P ""
              print -P "info: %U%F{blue}https://github.com/alyraffauf/safari%f%u"
              print -P "tip: disable this message with %F{cyan}safari.motd.enable = false%f."
              print -P ""
            }
            _safari_banner
            unset -f _safari_banner
          fi
    '';
  };
}
