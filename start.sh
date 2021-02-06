#!/run/current-system/sw/bin/bash

# Copy home.nix file
mkdir -p ~/.config/nixpkgs
cp user/config.nix ~/.config/nixpkgs
cp user/home.nix ~/.config/nixpkgs

# Run home installation
home-manager switch

# Install VSCode extensions
xargs code --install-extension < scripts/vscode_extensions
