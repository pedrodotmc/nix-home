{
  ####################
  # Git configuration
  ####################
  programs.git = {
    enable = true;
    userName = "Pedro Miranda";
    extraConfig = {
      core.editor = "nano -lm";
      pull.rebase = true;
    };
  };
}
