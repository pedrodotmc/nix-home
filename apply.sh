#!/run/current-system/sw/bin/bash

# Copy system configuration
sudo cp -l -f system/configuration.nix /etc/nixos

# Copy home configuration
mkdir -p ~/.config/nixpkgs/files
cp -l -f user/*.nix ~/.config/nixpkgs
cp -l -f -r files/* ~/.config/nixpkgs/files

# Run home installation
home-manager switch

# Install VSCode extensions
xargs code --install-extension < files/vscode/extensions
