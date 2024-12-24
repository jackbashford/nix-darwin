{ pkgs, ... }:
{
  # The platform the configuration will be used on.
  nixpkgs.hostPlatform = "x86_64-darwin";

  # Necessary for using flakes on this system.
  nix.settings.experimental-features = "nix-command flakes";

  environment.pathsToLink = [ "/share/zsh" ];

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 5;

  system.keyboard = {
    enableKeyMapping = true;
    remapCapsLockToEscape = true;
  };

  users.users.jackbashford = {
    home = "/Users/jackbashford";
    packages = [
      pkgs.nixfmt-rfc-style
      pkgs.nil
    ];
  };

  security.pam.enableSudoTouchIdAuth = true;

  services.yabai = {
    enable = true;
    enableScriptingAddition = false;
    config = {
      layout = "bsp";
      window_placement = "second_child";
      focus_follows_mouse = "autoraise";
      mouse_follows_focus = "off";
      top_padding = 8;
      bottom_padding = 8;
      left_padding = 4;
      right_padding = 4;
      window_gap = 2;
    };
  };

  services.skhd = {
    enable = true;
    skhdConfig = ''
      shift + alt - y: yabai --restart-service
      alt - y: yabai --stop-service

      alt - t: kitty --single-instance -d ~
      shift + alt - d: discord

      shift + alt - h: yabai -m window --warp west
      shift + alt - j: yabai -m window --warp south
      shift + alt - k: yabai -m window --warp north
      shift + alt - l: yabai -m window --warp east

      alt - 1: yabai -m space --focus 1
      alt - 2: yabai -m space --focus 2
      alt - 3: yabai -m space --focus 3
      alt - 4: yabai -m space --focus 4
      alt - 5: yabai -m space --focus 5
      alt - 6: yabai -m space --focus 6
      alt - 7: yabai -m space --focus 7

      shift + alt - 1: yabai -m window --space 1
      shift + alt - 2: yabai -m window --space 2
      shift + alt - 3: yabai -m window --space 3
      shift + alt - 4: yabai -m window --space 4
      shift + alt - 5: yabai -m window --space 5
      shift + alt - 6: yabai -m window --space 6
      shift + alt - 7: yabai -m window --space 7

      alt - f : yabai -m window --toggle zoom-fullscreen
    '';
  };

  home-manager.backupFileExtension = "bak";
  home-manager.users.jackbashford = {
    programs = {
      zsh = {
        enable = true;
        autocd = true;
        autosuggestion.enable = true;
        enableCompletion = true;
        syntaxHighlighting = {
          enable = true;
          highlighters = [
            "brackets"
            "cursor"
          ];
        };

        history = {
          append = true;
          ignoreDups = true;
          save = 1000000;
          size = 1000000;
        };

        initExtra = ''
          setopt INC_APPEND_HISTORY
          bindkey "^[[3~" delete-char
        '';

        shellAliases = {
          j = "zellij";
          l = "lsd";
          ls = "lsd -A";
        };
      };

      helix = {
        enable = true;
        languages = {

          language-server.nil = {
            command = "nil";
          };

          language = [
            {
              name = "nix";
              auto-format = true;
              file-types = [ "nix" ];
              indent = {
                tab-width = 2;
                unit = "  ";
              };
              formatter.command = "nixfmt";
              language-servers = [ "nil" ];
            }
          ];
        };
      };

      fzf.enable = true;
      starship.enable = true;
      zoxide.enable = true;
      zellij.enable = true;
      lsd.enable = true;
      man.enable = true;
      ripgrep.enable = true;
    };

    home.stateVersion = "24.11";
  };
}
