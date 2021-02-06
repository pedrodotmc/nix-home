# Step by step for NixOS GNOME

## Before NixOS installation

1. Install git and clone nix-home repo:

```bash
nix-env -iA git
git clone https://github.com/pedrodotmc/nix-home.git
```

2. Copy [this configuration.nix](system/configuration.nix) file over generated by nix.

3. Follow NixOS installation steps.

4. Set a password for `pedrodotmc` user:

```bash
passwd pedrodotmc
```

5. Reboot.

## After NixOS installation

1. Generate a new GPG Key for signing commits:

```bash
gpg --full-generate-key
```

2. Generate a new SSH key pair and configure it in GitHub:

```bash
ssh-keygen -t ecdsa -b 521 -C "pedrodotmc@gmail.com"
```

3. Clone repo in your folder with SSH:

```bash
git clone git@github.com:pedrodotmc/nix-home.git
```

4. Update `nixHomeRepo` variable in [home.nix](user/home.nix) file.

5. Run `start.sh` script:

```bash
./start.sh
```
