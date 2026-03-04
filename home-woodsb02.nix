{ config, pkgs, ... }:

let
    dotfiles = "${config.home.homeDirectory}/Code/nixos-dotfiles/config";
    create_symlink = path: config.lib.file.mkOutOfStoreSymlink path;
    # Standard .config/directory
    configs = {
        nvim = "nvim";
    };
in

{
  home.username = "woodsb02";
  home.homeDirectory = "/home/woodsb02";
  programs.git.enable = true;
  home.stateVersion = "25.11";
  programs.bash = {
    enable = true;
    shellAliases = {
      btw = "echo i use nixos, btw";
    };
  };

  # Iterate over xdg configs and map them accordingly
  xdg.configFile = builtins.mapAttrs (name: subpath: {
      source = create_symlink "${dotfiles}/${subpath}";
      recursive = true;
  }) configs;
}
