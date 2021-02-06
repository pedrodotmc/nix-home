#!/run/current-system/sw/bin/bash

# Copy home.nix file
mkdir -p ~/.config/nixpkgs
cp -l -f user/*.nix ~/.config/nixpkgs

# Run home installation
home-manager switch

# Install VSCode extensions
xargs code --install-extension < files/vscode_extensions
