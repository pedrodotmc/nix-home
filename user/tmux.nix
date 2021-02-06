{
  options.repoUpdater.nixHomeRepo = mkOption {
    type = types.str;
  };

  config = {
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
            OnUnitActiveSec = "1d";
          };
          Install.WantedBy = [ "timers.target" ];
        };
      };
    };
  };
}
