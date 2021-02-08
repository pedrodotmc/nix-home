{
  pkgs,
  ...
}:
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
      source "$CLOUD_SDK_HOME/google-cloud-sdk/completion.zsh.inc"
    '';
    shellAliases = {
      tf = "terraform";
      gcs = "git commit -S -s";
      cpbuff = "tmux show-buffer | xclip -sel clip -i";
    };
    plugins = [
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
      character = {
        error_symbol = "[➜](bold red)";
        success_symbol = "[➜](bold green)";
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
        ahead = "🠕$count";
        behind = "🠗$count";
        conflicted = "!";
        deleted = "×";
        diverged = "🠕$ahead_count 🠗$behind_count";
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
        format = "[🏎  $workspace]($style) ";
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
