{ config, ... }:
let
  vscodeFile = "${config.home.homeDirectory}/.config/nixpkgs/files/vscode/extensions";
in
{
  #######################
  # VSCode configuration
  #######################
  programs.vscode = {
    enable = true;
    keybindings = [
      {
        key = "ctrl+alt+g";
        command = "workbench.action.files.saveFiles";
      }
    ];
  };

  #######################################################
  # SystemD service for updating VSCode's extension list
  #######################################################
  systemd.user = {
    services = {
      vscode-extension-list-updater = {
        Unit.Description = "Service to update the VSCode extension list";
        Service = {
          Type = "simple";
          ExecStart = "/bin/sh -c 'code --list-extensions > ${vscodeFile}'";
        };
        Install.WantedBy = [ "default.target" ];
      };
    };
    timers = {
      vscode-extension-list-updater = {
        Unit.Description = "Timer to update the VSCode extension list";
        Timer = {
          OnCalendar = "*-*-* 19:00:00";
          Persistent = true;
        };
        Install.WantedBy = [ "timers.target" ];
      };
    };
  };
}
