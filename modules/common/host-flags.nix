{ config, lib, ... }:
let
  waylandHosts = [
    "leonard"
  ];

  hostName =
    config.networking.hostName or config.networking.computerName or null;
in {
  options.my.isWaylandMachine = lib.mkOption {
    type = lib.types.bool;
    readOnly = true;
    description = ''
      True if this host is known to be a Wayland-based machine.
      Derived from the host name.
    '';
  };

  config.my.isWaylandMachine =
    lib.mkIf (hostName != null)
      (builtins.elem hostName waylandHosts);
}
