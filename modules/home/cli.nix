{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.safari.cli;

  # Merge all recipe files into a single justfile
  mergedJustfileContent = ''
    _default:
        @printf '\033[1;36msafari cli\033[0m\n'
        @printf 'Just-based recipe runner for Safari.\n\n'
        @printf '\033[1;33mUsage:\033[0m safari <recipe> [args...]\n\n'
        @njust --list --list-heading $'Available recipes:\n\n'

    ${lib.concatStringsSep "\n" (lib.attrValues cfg.recipes)}
  '';

  # Validate the justfile syntax
  validatedJustfile =
    pkgs.runCommand "safari-justfile-validated" {
      nativeBuildInputs = [pkgs.just];
      preferLocalBuild = true;
    } ''
      # Write the justfile content to a temporary file
      echo ${lib.escapeShellArg mergedJustfileContent} > justfile

      # Validate the justfile syntax
      echo "Validating justfile syntax..."
      just --justfile justfile --summary >/dev/null || {
        echo "ERROR: safari justfile has syntax errors!"
        echo "Justfile content:"
        cat justfile
        exit 1
      }

      # Copy validated justfile to output
      cp justfile $out
      echo "safari justfile validation passed"
    '';

  mergedJustfile = validatedJustfile;

  safariScript = pkgs.writeShellApplication {
    name = "safari";
    runtimeInputs = [pkgs.jq pkgs.just];

    text = ''
      exec just --working-directory "$PWD" --justfile ${mergedJustfile} "$@"
    '';
  };
in {
  options.safari.cli.enable = {
    enable = lib.mkEnableOption "safari cli helper";

    recipes = lib.mkOption {
      type = lib.types.attrsOf lib.types.str;
      default = {};

      description = ''
        Attribute set of recipe names to justfile content.
        Each recipe will be merged into the final justfile.
      '';
    };

    defaultRecipes = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Whether to include default system management recipes";
    };
  };

  config = lib.mkIf cfg.enable {
    safari.cli.recipes = lib.mkIf cfg.defaultRecipes {
      system = ''
        # Show system info
        [group('system')]
        info:
            @echo "Hostname: $(hostname)"
            @echo "Kernel: $(uname -r)"
            @if command -v nixos-version >/dev/null 2>&1; then \
                echo "NixOS Version: $(nixos-version)"; \
                echo "Revision: $(nixos-version --json | jq -r '.configurationRevision // "unknown"')"; \
            elif command -v darwin-version >/dev/null 2>&1; then \
                echo "Darwin Version: $(darwin-version)"; \
            fi
      '';

      updates = ''
        # Update everything
        [group('system')]
        update: update-nix-profile update-flatpaks

        # Update Flatpak apps
        [group('flatpak')]
        update-flatpaks:
            @echo "Updating user Flatpak applications..."
            -flatpak update -y

        # Update Nix user profile
        [group('nix')]
        update-nix-profile:
            @echo "Updating Nix user profile..."
            nix profile upgrade --all
      '';
    };

    home.packages = [safariScript];
  };
}
