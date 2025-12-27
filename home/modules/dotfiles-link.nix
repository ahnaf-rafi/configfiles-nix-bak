{ config, lib, pkgs, inputs, ... }:
let
  # Function for making out of store symbolic links.
  oossl = path: config.lib.file.mkOutOfStoreSymlink path;
  dotsDir = "${config.my.dotfiles}";

  configs = {
    git = "git";
    kitty = "kitty";
    foot = "foot";
  };
in {

  # Configurations in `configs` variable are symlinked to XDG_CONFIG_HOME.
  xdg.configFile = builtins.mapAttrs
    (name: subpath: {
      source = oossl "${dotsDir}/${subpath}";
      recursive = true;
    })
    configs;

  # Configurations that live outside of XDG_CONFIG_HOME need special handling.
  home.file = {
    ".profile".source = oossl "${dotsDir}/shell/profile";
    ".bashrc".source = oossl "${dotsDir}/shell/bashrc";

    ".vim/vimrc".source = oossl "${dotsDir}/vim/vimrc";
    ".vim/options.vim".source = oossl "${dotsDir}/vim/options.vim";
    ".vim/keybinds.vim".source = oossl "${dotsDir}/vim/keybinds.vim";
  };
}
