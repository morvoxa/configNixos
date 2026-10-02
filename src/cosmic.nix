{ pkgs, ... }: {
  services.displayManager.cosmic-greeter.enable = true;
  services.desktopManager.cosmic.enable = true;
  environment.systemPackages = with pkgs; [
    alacritty
    firefox
    nerd-fonts.jetbrains-mono
    wl-clipboard-rs
  ];
}
