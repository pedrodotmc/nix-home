{ lib, config, ... }:

with lib;

let
  nixHomeUpdaterSh = ".local/bin/nix-home-updater.sh";
in
{
	options.homeUpdater.nixHomeRepo = mkOption {
		type = types.str;
	};

  config = {
    home.file = {
      nix-home-updater = {
        target = nixHomeUpdaterSh;
        text = ''
          #!/bin/sh
          cd ${config.homeUpdater.nixHomeRepo}
          git add .
          git commit -S -s -m "Update nix-home automatically"
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
            ExecStart = "${config.home.homeDirectory}/${nixHomeUpdaterSh}";
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
