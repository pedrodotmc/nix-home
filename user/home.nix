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
    oh-my-zsh zsh-syntax-highlighting zsh-you-should-use
    starship tmux
    keybase keybase-gui
    brave
    vscode
    spotify
    openfortivpn
    bitwarden-cli
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

  repoUpdater.nixHomeRepo = nixHomeRepo;

  ## Keybase services
  services.kbfs.enable = true;
  services.keybase.enable = true;
}
