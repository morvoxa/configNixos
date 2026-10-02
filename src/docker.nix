{ ... }: {
  virtualisation.docker = {
    enable = true;
  };
  users.users.mor.extraGroups = [ "docker" ];
}
