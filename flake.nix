{
  description = "Ahnaf Rafi's NixOS configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nixpkgs-stable.url = "github:NixOS/nixpkgs/nixos-25.11";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    emacs-overlay = {
      url = "github:nix-community/emacs-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    neovim-nightly.url = "github:nix-community/neovim-nightly-overlay";
  };

  outputs = {
    self, nixpkgs, home-manager, emacs-overlay, neovim-nightly, ...
  }@inputs: {
    nixosConfigurations = {
      leonard = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit inputs; };  # Pass inputs to modules
        modules = [
          ./hosts/leonard
          home-manager.nixosModules.home-manager
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              extraSpecialArgs = { inherit inputs; hostName = "leonard"; };
              users.ahnafrafi = import ./home;
              backupFileExtension = "backup";
            };
          }
        ];
      };
    };
  };
}
