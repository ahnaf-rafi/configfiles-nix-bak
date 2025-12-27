{ config, lib, pkgs, inputs, ... }:

{
  # Configure nixpkgs.
  nixpkgs = {
    overlays = [
      inputs.neovim-nightly.overlays.default
      inputs.emacs-overlay.overlays.default
    ];
    # Allow unfree packages.
    config = {
      allowUnfree = true;
      allowUnfreePredicate = _: true;
    };
  };
}
