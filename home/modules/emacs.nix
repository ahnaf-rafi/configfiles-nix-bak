{ config, lib, pkgs, inputs, ... }:
let
  # Function for making out of store symbolic links.
  oossl = path: config.lib.file.mkOutOfStoreSymlink path;
  emacsDots = "${config.my.dotfiles}/emacs";

  # Get correct package from emacs-overlay.
  emacs =
    if (config.my.isWaylandMachine or false)
    then pkgs.emacs-git-pgtk
    else pkgs.emacs-git;
in {
  programs.emacs = {
    enable = true;
    package = emacs;

    # Nix-managed Emacs packages: vterm, pdf-tools, and a helper for treesit.
    #
    # vterm/pdf-tools will be built against the right libs/toolchain via Nix.
    extraPackages = epkgs: [
      epkgs.evil
      epkgs.evil-collection

      epkgs.gcmh
      epkgs.exec-path-from-shell

      # Define treesitter language grammars to be ensured.
      epkgs.treesit-grammars.with-grammars (g: [
        g.tree-sitter-nix
        g.tree-sitter-markdown
        g.tree-sitter-latex
        g.tree-sitter-typst
        g.tree-sitter-python
        g.tree-sitter-r
        g.tree-sitter-julia
        g.tree-sitter-c
        g.tree-sitter-cpp
      ])

      epkgs.vterm
      epkgs.pdf-tools
      epkgs.auctex

    ];
  };

  services.emacs = {
    enable = true;
    package = emacs;
    client.enable = true;
    serverName = "emacs-base";
  };

  # Consistent experience across OSes.
  home.packages = (config.home.packages or []) ++ [
    # For Elpaca native-comp at runtime (jit compilation of Elisp to .eln).
    pkgs.libgccjit
    pkgs.gcc

    # pdf-tools runtime deps are usually handled, but these are often useful:
    pkgs.poppler

    # Additional utilities.
    pkgs.ripgrep
    pkgs.fd
  ];

  # Create symlinks.
  home.file = {
    ".emacs.d/init.el".source = oossl "${emacsDots}/init.el";
    ".emacs.d/early-init.el".source = oossl "${emacsDots}/early-init.el";
  };
}
