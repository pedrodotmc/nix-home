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
    pkg-config
    zsh oh-my-zsh
    starship tmux
    keybase keybase-gui
    google-chrome
    brave
    spotify
    openfortivpn
    bitwarden-cli
    zoom-us
    element-desktop
    jq
    zip unzip
    safeeyes
    fprintd
    # Development
    vscode
    python3
    python38Packages.pip
    rustup
    go
    # Infrastructure tools
    kube3d
    kubectl
    kubernetes-helm
    fluxctl
    istioctl
    velero
    gitlab-runner
    awscli2
    aws-okta
    argocd
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
