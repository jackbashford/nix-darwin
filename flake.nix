{
  description = "oopsilon nix go brr";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    nix-darwin.url = "github:LnL7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";

    home-manager.url = "github:nix-community/home-manager/master";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    catppuccin.url = "github:catppuccin/nix";
  };

  outputs =
    inputs@{
      self,
      nix-darwin,
      catppuccin,
      home-manager,
      ...
    }:
    {
      darwinConfigurations.oopsilon = nix-darwin.lib.darwinSystem {
        system = "x86_64-darwin";
        modules = [
          ./hosts/oopsilon/configuration.nix
          { system.configurationRevision = self.rev or self.dirtyRev or null; }
          inputs.home-manager.darwinModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.jackbashford = {
              imports = [
                catppuccin.homeManagerModules.catppuccin
              ];
            };
          }
        ];
      };
    };
}
