{ pkgs, ... }: {
  services.xserver.enable = true;
  services.xserver.windowManager.dwm = {
    enable = true;
    package = pkgs.dwm.overrideAttrs (oldAttrs: {
      src = ./dwm;
    });
  };
  services.displayManager.ly.enable = true;

  environment.systemPackages = with pkgs; [
    dmenu
    alacritty
    rofi
    firefox
    nerd-fonts.jetbrains-mono
  ];
}
