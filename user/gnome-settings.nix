{ config, ... }:
let
  tmuxStarter = "${config.home.homeDirectory}/.config/nixpkgs/files/tmux-starter.sh";
in
{
  gtk.theme.name = "Adwaita-dark";
  dconf.settings = {
    "org/gnome/terminal/legacy/profiles:" = {
      default = "48721fd3-e405-4ec9-8008-84652c9736e3";
      list = [ "48721fd3-e405-4ec9-8008-84652c9736e3" ];
    };
    "org/gnome/terminal/legacy/profiles:/:48721fd3-e405-4ec9-8008-84652c9736e3" = {
      audible-bell = true;
      backspace-binding = "ascii-delete";
      cursor-blink-mode = "system";
      cursor-shape = "block";
      custom-command = "${tmuxStarter}";
      delete-binding = "delete-sequence";
      font = "Inconsolata 15";
      login-shell = false;
      scrollback-lines = "10000";
      scrollbar-policy = "never";
      use-custom-command = true;
      use-system-font = false;
      use-theme-colors = true;
      visible-name = "pedrodotmc";
    };
  };
}
