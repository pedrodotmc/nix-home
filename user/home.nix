{
  pkgs,
  config,
  ...
}:

let
  nixHomeRepo = "${config.home.homeDirectory}/Repositories/github.com/pedrodotmc/nix-home";
in
{

  #################################
  # Packages to install in my user
  #################################
  home.packages = with pkgs; [
    # Apps
    zsh oh-my-zsh
    starship tmux
    keybase keybase-gui
    brave
    spotify
    openfortivpn
    bitwarden-cli
    zoom-us
    element-desktop
    jq
    zip unzip
    # Development
    vscode
    rustup
    # Infrastructure tools
    kubectl
    kubernetes-helm
    fluxctl
    istioctl
    velero
    gitlab-runner
  ];

  imports = [
    ./git.nix
    ./gnome-settings.nix
    ./repo-updater.nix
    ./vscode.nix
    ./zsh.nix
  ];

  repoUpdater.nixHomeRepo = nixHomeRepo;

  ## Keybase services
  services.kbfs.enable = true;
  services.keybase.enable = true;
}
