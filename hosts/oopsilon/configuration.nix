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

  system.defaults.NSGlobalDomain._HIHideMenuBar = false;

  users.users.jackbashford = {
    home = "/Users/jackbashford";
    packages = [
      pkgs.nil
      pkgs.nixfmt-rfc-style

      pkgs.git

      pkgs.gleam
      pkgs.erlang

      pkgs.typst
      pkgs.tinymist
      pkgs.typstyle
    ];
  };

  security.pam.enableSudoTouchIdAuth = true;

  # Yabai needed to have the /etc/sudoers.d/yabai file removed before
  # it would play ball with the enableScriptingAddition option.
  services.yabai = {
    enable = true;
    enableScriptingAddition = true;
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
    extraConfig = ''
      yabai -m signal --add event=dock_did_restart action="sudo yabai --load-sa"
      yabai --load-sa

      yabai -m rule --add app="^System Settings$" manage=off
      yabai -m rule --add app="^1Password$" manage=off
      yabai -m rule --add app="^Raycast$" manage=off

      yabai -m signal --add app='^Ghostty$' event=window_created action='yabai -m space --layout bsp'
      yabai -m signal --add app='^Ghostty$' event=window_destroyed action='yabai -m space --layout bsp'
    '';
    # yabai -m config external_bar all:26:0
  };

  services.skhd = {
    enable = true;
    skhdConfig = ''
      alt - t: open -a /Applications/Ghostty.app

      alt - y: yabai -m window --toggle float

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

  services.spacebar = {
    enable = false;
    package = pkgs.spacebar;
    config = {
      position = "top";
      display = "main";
      height = 26;
      title = "on";
      spaces = "on";
      clock = "on";
      power = "on";
      padding_left = 20;
      padding_right = 20;
      spacing_left = 25;
      spacing_right = 15;
      # text_font = ''"Menlo:Regular:12.0"'';
      # icon_font = ''"Font Awesome 5 Free:Solid:12.0"'';
      background_color = "0xff202020";
      foreground_color = "0xffa8a8a8";
      power_icon_color = "0xffcd950c";
      battery_icon_color = "0xffd75f5f";
      dnd_icon_color = "0xffa8a8a8";
      clock_icon_color = "0xffa8a8a8";
      power_icon_strip = " ";
      space_icon = "•";
      space_icon_strip = "1 2 3 4 5 6 7 8 9 10";
      spaces_for_all_displays = "on";
      display_separator = "on";
      display_separator_icon = "";
      space_icon_color = "0xff458588";
      space_icon_color_secondary = "0xff78c4d4";
      space_icon_color_tertiary = "0xfffff9b0";
      clock_icon = "";
      dnd_icon = "";
      clock_format = ''"%d/%m/%y %R"'';
      right_shell = "on";
      right_shell_icon = "";
      right_shell_command = "whoami";
    };
  };

  # Prevents slow shell startup, we already compinit per-user,
  # don't need to do it at the system level too.
  programs.zsh.enableGlobalCompInit = false;

  home-manager.backupFileExtension = "bak";
  home-manager.users.jackbashford = {
    # disabled for now to resolve the fact that it looks bad in places
    catppuccin.enable = false;
    catppuccin.flavor = "mocha";
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
          ls = "lsd -A";
          cat = "bat";
        };
      };

      helix = {
        enable = true;

        settings = {
          theme = "catppuccin_mocha";
          editor = {
            line-number = "relative";
            color-modes = true;
            smart-tab.enable = false;
            soft-wrap.enable = true;
            cursor-shape = {
              insert = "bar";
              normal = "block";
              select = "underline";
            };
            lsp.display-messages = true;
          };

          keys.normal = {
            X = [
              "extend_line_up"
              "extend_to_line_bounds"
            ];
          };
          keys.insert = {
            C-h = "signature_help";
          };
        };
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

      bat.enable = true;
      fd = {
        enable = true;
        hidden = true;
      };
      fzf.enable = true;
      lsd.enable = true;
      man.enable = true;
      ripgrep.enable = true;
      starship.enable = true;
      tealdeer.enable = true;
      zellij.enable = true;
      zoxide.enable = true;
    };

    home.stateVersion = "24.11";
    home.sessionVariables = {
      EDITOR = "hx";
    };
  };
}
