{
  config,
  lib,
  ...
}: {
  options.safari.joshuto.enable = lib.mkEnableOption "joshuto" // {default = config.safari.enable;};

  config = lib.mkIf config.safari.joshuto.enable {
    programs.joshuto = {
      enable = true;

      settings = {
        display.sort.directories_first = true;
        preview.xdg_thumb_size = "xxlarge";
        xdg_open = true;
        xdg_open_fork = true;
        zoxide_update = config.safari.joshuto.enable;
      };
    };
  };
}
