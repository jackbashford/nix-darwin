{ ... }:
{
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
