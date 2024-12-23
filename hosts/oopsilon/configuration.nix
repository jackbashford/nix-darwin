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
}
