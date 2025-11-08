{self, ...}: {
  flake = {
    homeModules.default = ../home;

    homeConfigurations = {
      "test@aarch64-darwin" = self.inputs.home-manager.lib.homeManagerConfiguration {
        extraSpecialArgs = {inherit self;};

        modules = [
          self.homeModules.default

          {
            home = {
              homeDirectory = "/Users/test";
              stateVersion = "25.11";
              username = "test";
            };

            safari = {
              enable = true;
              zsh.enable = true;
              fish.enable = true;
              motd.enable = true;
            };
          }
        ];

        pkgs = import self.inputs.nixpkgs {
          system = "aarch64-darwin";
          config.allowUnfree = true;
        };
      };

      "test@aarch64-linux" = self.inputs.home-manager.lib.homeManagerConfiguration {
        extraSpecialArgs = {inherit self;};

        modules = [
          self.homeModules.default

          {
            home = {
              homeDirectory = "/home/test";
              stateVersion = "25.11";
              username = "test";
            };

            safari = {
              enable = true;
              zsh.enable = true;
              fish.enable = true;
              motd.enable = true;
            };
          }
        ];

        pkgs = import self.inputs.nixpkgs {
          system = "aarch64-linux";
          config.allowUnfree = true;
        };
      };

      "test@x86_64-linux" = self.inputs.home-manager.lib.homeManagerConfiguration {
        extraSpecialArgs = {inherit self;};

        modules = [
          self.homeModules.default

          {
            home = {
              homeDirectory = "/home/test";
              stateVersion = "25.11";
              username = "test";
            };

            safari = {
              enable = true;
              zsh.enable = true;
              fish.enable = true;
              motd.enable = true;
            };
          }
        ];

        pkgs = import self.inputs.nixpkgs {
          system = "x86_64-linux";
          config.allowUnfree = true;
        };
      };
    };
  };
}
