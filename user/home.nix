{
  pkgs,
  config,
  ...
}:

let
  nixHomeRepo = "${config.home.homeDirectory}/Repositories/github.com/pedrodotmc/nix-home";
in
{

  home.packages = with pkgs; [
    # Apps
    starship tmux
    guake
    keybase keybase-gui
    vscode
    spotify
    openfortivpn
    # Infrastructure tools
    kubectl
    kubernetes-helm
    fluxctl
    istioctl
    gitlab-runner
  ];

  imports = [
    ./git.nix
    ./gnome-settings.nix
    ./repo-updater.nix
    ./vscode.nix
    ./zsh.nix
  ];

  vscode.nixHomeRepo = nixHomeRepo;
  repoUpdater.nixHomeRepo = nixHomeRepo;

  ## Keybase services
  services.kbfs.enable = true;
  services.keybase.enable = true;
}
