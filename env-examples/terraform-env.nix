with import <nixpkgs> {};

stdenv.mkDerivation {
    # Impure shell's name
    name = "tf-env";
    # Packages to install
    buildInputs = [terraform_0_14];
    # Shell commands before starting shell
    shellHook = ''
    export TF_DATA_DIR=.terraform.my-env
    '';
}
