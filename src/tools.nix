{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    vscode.fhs
    neovim
    git
    tree-sitter
    gcc
    nixfmt
    stylua
    shfmt
    kdlfmt
    taplo
    xclip
    clang-tools
    devenv
  ];
}
