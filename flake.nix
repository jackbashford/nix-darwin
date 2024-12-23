{
  description = "oopsilon nix go brr";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    nix-darwin.url = "github:LnL7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs@{ self, nix-darwin, nixpkgs }:
  {
    darwinConfigurations.oopsilon = nix-darwin.lib.darwinSystem {
      modules = [ ./hosts/oopsilon/configuration.nix
      { system.configurationRevision = self.rev or self.dirtyRev or null; }
      ];
    };
  };
}
