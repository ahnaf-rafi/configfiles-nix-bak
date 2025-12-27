{ config, lib, pkgs, ... }:

{
  home.packages = [
    pkgs.google-chrome
  ];
}
