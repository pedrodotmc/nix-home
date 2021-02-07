with import <nixpkgs> {};

stdenv.mkDerivation {
    # Impure shell's name
    name = "scala-env";
    # Packages to install
    buildInputs = [adoptopenjdk-openj9-bin-13 scala sbt sbt-extras scalafmt];
    # Shell commands before starting shell
    shellHook = ''
    export SBT_OPTS="-Xmx1024M -Duser.timezone=GMT"
    '';
}
