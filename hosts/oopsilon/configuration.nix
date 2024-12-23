{ pkgs, ... }:
{
  # The platform the configuration will be used on.
  nixpkgs.hostPlatform = "x86_64-darwin";

  # Necessary for using flakes on this system.
  nix.settings.experimental-features = "nix-command flakes";

  environment.systemPackages = [
    pkgs.nixfmt-rfc-style
    pkgs.nil
  ];

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 5;

  security.pam.enableSudoTouchIdAuth = true;

  system.keyboard = {
    enableKeyMapping = true;
    remapCapsLockToEscape = true;
  };

  users.users.jackbashford.home = "/Users/jackbashford";

  home-manager.backupFileExtension = "bak";
  home-manager.users.jackbashford = {
    programs = {
      zsh = {
        enable = true;
        autocd = true;

        history = {
          append = true;
          ignoreDups = true;
          save = 1000000;
          size = 1000000;
        };

        initExtra = "setopt INC_APPEND_HISTORY";
      };

      fzf.enable = true;
      starship.enable = true;
      zoxide.enable = true;
      helix.enable = true;
    };

    home.stateVersion = "24.11";
  };
}
