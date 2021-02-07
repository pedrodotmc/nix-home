#!/run/current-system/sw/bin/bash

mkdir -p ~/.config/nixpkgs/files
cp -l -f user/*.nix ~/.config/nixpkgs
cp -l -f files/* ~/.config/nixpkgs/files

# Run home installation
home-manager switch

# Install VSCode extensions
xargs code --install-extension < files/vscode_extensions