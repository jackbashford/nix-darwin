{ pkgs, ... }:
{
  imports = [
    ./../../modules/home
    ./home.nix
  ];
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

      pkgs.digital
    ];
  };

  security.pam.enableSudoTouchIdAuth = true;

  # Prevents slow shell startup, we already compinit per-user,
  # don't need to do it at the system level too.
  programs.zsh.enableGlobalCompInit = false;
}
