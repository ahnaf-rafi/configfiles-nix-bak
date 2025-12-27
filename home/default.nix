{ config, lib, pkgs, inputs, ... }:

{
  options.my.dotfiles = lib.mkOption {
    type = lib.types.str;
    description = "Root directory for dotfiles";
  };

  # Dotfiles directory.
  my.dotfiles = "${config.home.homeDirectory}/configfiles/configs";

  imports = [
    ./modules/dotfiles-link.nix
  ] ++ lib.optionals (hostName == "leonard") [
    ./hosts/leonard.nix
  ];

  home.username = "ahnafrafi";
  home.homeDirectory = "/home/ahnafrafi";
  home.stateVersion = "25.11";

  home.packages = [
    pkgs.gcc
    pkgs.gnumake
    pkgs.cmake
    pkgs.automake
    pkgs.autoconf
    pkgs.libpng
    pkgs.zlib
    pkgs.libgccjit

    pkgs.ripgrep
    pkgs.fd
    pkgs.fzf
    pkgs.bat
    pkgs.neovim
    pkgs.tmux
    pkgs.lazygit
    pkgs.delta

    (pkgs.aspellWithDicts
      (dicts: with dicts; [ en en-computers en-science ]))

    # pkgs.texlive.combined.scheme-full

    (pkgs.texliveMinimal.withPackages (
      ps: with ps; [
        latexmk latex-bin
        biber biblatex biblatex-chicago
        geometry setspace hyperref enumitem
        float booktabs multirow
        amsmath amsfonts amscls tools jknapltx cleveref
        etaremune calc crossreftools
        wrapfig ulem capt-of
        dvisvgm dvipng # for preview and export as html
      ]))
    pkgs.texlab
    pkgs.nixd
    pkgs.typst
    pkgs.tinymist
    pkgs.pandoc

    (pkgs.zathura.override {
      plugins = [ pkgs.zathuraPkgs.zathura_pdf_mupdf ];
    })
    pkgs.sioyek

    pkgs.brave
    pkgs.lynx
  ];
}
