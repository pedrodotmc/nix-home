{
  config,
  pkgs,
  ...
}:
let
  tmuxGitHub = "${config.home.homeDirectory}/.config/nixpkgs/files/tmux/github.sh";
  tmuxWork = "${config.home.homeDirectory}/.config/nixpkgs/files/tmux/work.sh";
  tmuxWorkTA = "${config.home.homeDirectory}/.config/nixpkgs/files/tmux/work_ta.sh";
in
{
  ##############################
  # Configuration for XSH shell
  ##############################
  programs.zsh = {
    enable = true;
    enableAutosuggestions = true;
    history.extended = true;
    initExtra = ''
      eval "$(starship init zsh)"
      export TERM=xterm-256color
      export CLOUD_SDK_HOME="${pkgs.google-cloud-sdk}"
      source "$CLOUD_SDK_HOME/google-cloud-sdk/completion.zsh.inc"
    '';
    shellAliases = {
      tf = "terraform";
      gcs = "git commit -S -s";
      cpbuff = "tmux show-buffer | xclip -sel clip -i";
      tmux_github = tmuxGitHub;
      tmux_work = tmuxWork;
      tmux_work_ta = tmuxWorkTA;
    };
    plugins = [
      {
        name = "zsh-syntax-highlighting";
        src = pkgs.fetchFromGitHub {
          owner = "zsh-users";
          repo = "zsh-syntax-highlighting";
          rev = "0.7.1";
          sha256 = "03r6hpb5fy4yaakqm3lbf4xcvd408r44jgpv4lnzl9asp4sb9qc0";
        };
      }
      {
        name = "zsh-you-should-use";
        file = "you-should-use.plugin.zsh";
        src = pkgs.fetchFromGitHub {
          owner = "MichaelAquilina";
          repo = "zsh-you-should-use";
          rev = "1.7.3";
          sha256 = "1dz48rd66priqhxx7byndqhbmlwxi1nfw8ik25k0z5k7k754brgy";
        };
      }
      {
        name = "zsh-nix-shell";
        file = "nix-shell.plugin.zsh";
        src = pkgs.fetchFromGitHub {
          owner = "chisui";
          repo = "zsh-nix-shell";
          rev = "v0.1.0";
          sha256 = "0snhch9hfy83d4amkyxx33izvkhbwmindy0zjjk28hih1a9l2jmx";
        };
      }
    ];
    oh-my-zsh = {
      enable = true;
      theme = "bira";
      plugins = [
        "ansible"
        "bazel"
        "cargo"
        "debian"
        "docker"
        "docker-compose"
        "dotenv"
        "gcloud"
        "git"
        "git-hubflow"
        "gitignore"
        "golang"
        "gradle"
        "helm"
        "history"
        "kubectl"
        "laravel"
        "man"
        "nmap"
        "npm"
        "pip"
        "pipenv"
        "postgres"
        "pyenv"
        "python"
        "redis-cli"
        "rsync"
        "rust"
        "rustup"
        "sbt"
        "scala"
        "sudo"
        "systemd"
        "terraform"
        "virtualenv"
        "vscode"
      ];
    };
  };

  ####################################
  # Configuration for starship prompt
  ####################################
  programs.starship = {
    enable = true;
    enableZshIntegration = true;
    settings = {
      format = pkgs.lib.concatStrings [
        "$nix_shell"
        "$username"
        "$hostname"
        "$shlvl"
        "$directory"
        "$git_branch"
        "$git_commit"
        "$git_state"
        "$git_status"
        "$hg_branch"
        "$docker_context"
        "$package"
        "$cmake"
        "$dart"
        "$dotnet"
        "$elixir"
        "$elm"
        "$erlang"
        "$golang"
        "$helm"
        "$java"
        "$julia"
        "$kotlin"
        "$nim"
        "$nodejs"
        "$ocaml"
        "$perl"
        "$php"
        "$purescript"
        "$python"
        "$ruby"
        "$rust"
        "$swift"
        "$zig"
        "$conda"
        "$memory_usage"
        "$aws"
        "$gcloud"
        "$kubernetes"
        "$terraform"
        "$openstack"
        "$env_var"
        "$crystal"
        "$custom"
        "$cmd_duration"
        "$line_break"
        "$lua"
        "$jobs"
        "$battery"
        "$time"
        "$status"
        "$character"
      ];
      add_newline = false;
      aws = {
        format = "[$symbol $profile(\($region\))]($style) ";
        style = "#e07700";
        symbol = "🅰 ";
      };
      directory = {
        style = "cyan";
        truncation_length = 8;
      };
      docker_context = {
        format = "[🐋 $context](blue)";
      };
      gcloud = {
        format = "[$symbol $project]($style) ";
        symbol = "🇬️ ";
        style = "#e6b800";
      };
      git_branch = {
        style = "#ff3399";
        symbol = "🌱 ";
        truncation_symbol = "";
      };
      git_commit = {
        commit_hash_length = 4;
        tag_symbol = "🔖 ";
      };
      git_state = {
        cherry_pick = "[🍒 PICKING](red)";
        format = "[\\($state( $progress_current of $progress_total)\\)]($style) ";
      };
      git_status = {
        ahead = "↑$count";
        behind = "↓$count";
        conflicted = "!";
        deleted = "×";
        diverged = "↑$ahead_count ↓$behind_count";
        format = "([\\[$all_status\\]\\[$ahead_behind\\]]($style) )";
        modified = "~";
        style = "#ff3399";
      };
      helm = {
        format = "[⎈  $version](white) ";
      };
      hostname = {
        disabled = true;
        format = "[@$hostname](red) ";
        ssh_only = false;
        trim_at = ".";
      };
      java = {
        format = "[$symbol($version )]($style)";
        style = "red";
      };
      kubernetes = {
        disabled = false;
        format = "[⛵ $context](#0099ff) ";
      };
      nix_shell = {
        disabled = false;
        impure_msg = "[⚠️  $name ⚠️](bold red)";
        pure_msg = "[🏡](bold green)";
        format = "[$state ](bold red) ";
      };
      package = {
        format = "[📦 $version](208) ";
      };
      rust = {
        format = "[⚙️ $version](#f03c00) ";
      };
      terraform = {
        format = "[🇹🇫  $workspace]($style) ";
        style = "#7c65ef";
      };
      username = {
        disabled = true;
        format = "[$user]($style)";
        show_always = true;
        style_root = "black";
        style_user = "white";
      };
    };
  };
}
