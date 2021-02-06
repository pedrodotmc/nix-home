{ lib, config, ... }:

with lib;

{
	options.vscode.nixHomeRepo = mkOption {
		type = types.str;
	};

  config = {
		programs.vscode = {
			enable = true;
			keybindings = [
				{
					key = "ctrl+alt+g";
					command = "workbench.action.files.saveFiles";
				}
			];
		};
		systemd.user = {
      services = {
        vscode-extension-list-updater = {
					Unit.Description = "Service to update the VSCode extension list";
					Service = {
						Type = "simple";
						ExecStart = "/bin/sh -c 'code --list-extensions > ${config.vscode.nixHomeRepo}/files/vscode_extensions'";
					};
					Install.WantedBy = [ "default.target" ];
				};
			};
			timers = {
				vscode-extension-list-updater = {
					Unit.Description = "Timer to update the VSCode extension list";
					Timer = {
						OnBootSec = "2min";
						OnUnitActiveSec = "1d";
					};
					Install.WantedBy = [ "timers.target" ];
				};
			};
		};
  };
}
