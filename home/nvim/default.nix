{ pkgs, inputs, ... }:
{
  home.file = {
    nvim_conf = {
      source = ./lua;
      target = ".config/nvim/lua";
      recursive = true;
    };

    clang_tidy = {
      source = ./.clang-tidy;
      target = ".clang-tidy";
    };

    clangd = {
      source = ./.clangd;
      target = ".clangd";
    };
  };

  programs.neovim = {
    enable = true;

    extraConfig = (builtins.readFile ./.vimrc);
    plugins = [ pkgs.vimPlugins.lazy-nvim ];

    extraPackages = with pkgs; let
      ecsls-pkg = inputs.ecsls.packages.${pkgs.system}.default;
    in
    [
      nil
      lua-language-server
      pyright
      clang-tools
      llvmPackages_latest.clang
      nodejs
      xclip
      ecsls-pkg
    ];
  };
}
