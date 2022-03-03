{ pkgs ? import <nixpkgs> {} }:
(pkgs.buildFHSUserEnv {
  name = "pipzone";
  targetPkgs = pkgs: (with pkgs; [
    python39
    python39Packages.pip
    python39Packages.virtualenv
    python39Packages.wheel
    python39Packages.bcrypt
    python39Packages.cffi
    python39Packages.flask-bcrypt
    python39Packages.flask_wtf
    python39Packages.flask
    python39Packages.stripe
  ]);
  runScript = "bash";
}).env
