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
      gitui = {
        enable = true;
        theme = ''
            (
              selected_tab: Some("Reset"),
              command_fg: Some("#cad3f5"),
              selection_bg: Some("#5b6078"),
              selection_fg: Some("#cad3f5"),
              cmdbar_bg: Some("#1e2030"),
              cmdbar_extra_lines_bg: Some("#1e2030"),
              disabled_fg: Some("#8087a2"),
              diff_line_add: Some("#a6da95"),
              diff_line_delete: Some("#ed8796"),
              diff_file_added: Some("#a6da95"),
              diff_file_removed: Some("#ee99a0"),
              diff_file_moved: Some("#c6a0f6"),
              diff_file_modified: Some("#f5a97f"),
              commit_hash: Some("#b7bdf8"),
              commit_time: Some("#b8c0e0"),
              commit_author: Some("#7dc4e4"),
              danger_fg: Some("#ed8796"),
              push_gauge_bg: Some("#8aadf4"),
              push_gauge_fg: Some("#24273a"),
              tag_fg: Some("#f4dbd6"),
              branch_fg: Some("#8bd5ca")
          )
        '';
        keyConfig = ''
          move_left: Some(( code: Char('h'), modifiers: "")),
          move_right: Some(( code: Char('l'), modifiers: "")),
          move_up: Some(( code: Char('k'), modifiers: "")),
          move_down: Some(( code: Char('j'), modifiers: "")),
        '';
      };
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
