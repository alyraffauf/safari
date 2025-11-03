{
  lib,
  self,
  ...
}: {
  flake.actions-nix = {
    pre-commit.enable = true; # Set to true if you want pre-commit workflow generation

    workflows = {
      # build-nix.yml
      ".github/workflows/build-nix.yml" = {
        name = "build-nix";
        concurrency = {
          group = "\${{ github.workflow }}-\${{ github.ref }}";
          cancel-in-progress = true;
        };
        on = {
          push = {
            paths = [
              "flake.lock"
              "flake.nix"
              "flake/"
            ];
          };
          workflow_dispatch = {};
        };
        jobs = let
          devShells = lib.attrNames (self.devShells.x86_64-linux or {});
          packages = lib.attrNames (self.packages.x86_64-linux or {});
          devShellJobs = lib.listToAttrs (map
            (name: {
              name = "build-devShell-${name}";
              value = {
                runs-on = "ubuntu-latest";
                steps = [
                  {
                    uses = "actions/checkout@main";
                    "with" = {fetch-depth = 1;};
                  }
                  {uses = "DeterminateSystems/nix-installer-action@main";}
                  {
                    name = "Build devShell ${name}";
                    run = "nix build --accept-flake-config --print-out-paths .#devShells.x86_64-linux.${name}";
                  }
                ];
              };
            })
            devShells);
          packageJobs = lib.listToAttrs (map
            (name: {
              name = "build-package-${name}";
              value = {
                runs-on = "ubuntu-latest";
                steps = [
                  {
                    uses = "actions/checkout@main";
                    "with" = {fetch-depth = 1;};
                  }
                  {uses = "DeterminateSystems/nix-installer-action@main";}
                  {
                    name = "Build package ${name}";
                    run = "nix build --accept-flake-config --print-out-paths .#packages.x86_64-linux.${name}";
                  }
                ];
              };
            })
            packages);
        in
          devShellJobs // packageJobs;
      };

      # check-nix.yml
      ".github/workflows/check-nix.yml" = {
        name = "check-nix";
        concurrency = {
          cancel-in-progress = true;
          group = "\${{ github.workflow }}-\${{ github.ref }}";
        };
        on = {
          push = {
            paths-ignore = [
              "**/*.md"
              ".github/**"
              "_img/**"
            ];
          };
          workflow_dispatch = {};
        };
        jobs = {
          check-flake = {
            runs-on = "ubuntu-latest";
            steps = [
              {
                uses = "actions/checkout@main";
                "with" = {fetch-depth = 1;};
              }
              {uses = "DeterminateSystems/nix-installer-action@main";}
              {
                name = "Check flake evaluation";
                run = "nix -Lv flake check --all-systems";
              }
            ];
          };
        };
      };
    };
  };
}
