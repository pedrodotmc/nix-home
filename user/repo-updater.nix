{ lib, config, ... }:

with lib;

let
  nixRepoUpdaterSh = ".local/bin/nix-repo-updater.sh";
in
{
  # Path where nix-home repo is
  options.repoUpdater.nixHomeRepo = mkOption {
    type = types.str;
  };

  config = {
    ##############################################################
    # Create script file for updating nix-home repo automatically
    ##############################################################
    home.file = {
      nix-home-updater = {
        target = nixRepoUpdaterSh;
        text = ''
          #!/bin/sh
          cd ${config.repoUpdater.nixHomeRepo}
          git add .
          git commit -S -s -m "Update nix-home repository"
          git push
        '';
        executable = true;
      };
    };

    ##############################################
    # SystemD service for updating repo in GitHub
    ##############################################
    systemd.user = {
      services = {
        nix-home-updater = {
          Unit.Description = "Service to update nix-home repository";
          Service = {
            Type = "simple";
            ExecStart = "${config.home.homeDirectory}/${nixRepoUpdaterSh}";
          };
          Install.WantedBy = [ "default.target" ];
        };
      };
      timers = {
        nix-home-updater = {
          Unit.Description = "Timer to update nix-home repository";
          Timer = {
            OnBootSec = "5min";
            OnCalendar = "*-*-* 20:00:00";
            Persistent = true;
          };
          Install.WantedBy = [ "timers.target" ];
        };
      };
    };
  };
}
