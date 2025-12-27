{ config, lib, pkgs, inputs, ... }:

{

  imports = [
    ../nixpkgs
    ./host-flags.nix
  ]

  environment.systemPackages = with pkgs; [
    vim
    htop
    fontconfig
    git
    wget
    curl
    coreutils
    tree
  ]

  # Fonts
  fonts.packages = with pkgs; [
    julia-mono
    nerd-fonts.symbols-only
    nerd-fonts.jetbrains-mono
  ];

  # Programs:
  # Bash
  programs.bash = {
    enable = true;
    completion.enable = true;
  };

  # Allow flakes.
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Automate garbage collection
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-generations +3  --delete-older-than 30d";
  };

  # Also optimize the store automatically
  nix.settings.auto-optimise-store = true;
  nix.optimise = {
    automatic = true;
    dates = [ "weekly" ];
  };

  # List of services.
  # Enable the OpenSSH daemon.
  services.openssh.enable = true;
}
