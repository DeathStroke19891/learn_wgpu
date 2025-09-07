{ pkgs ? import <nixpkgs> { } }:

pkgs.mkShell
{
  buildInputs = [
    pkgs.clippy
    pkgs.rustfmt
    pkgs.rustc
    pkgs.rust-analyzer
    pkgs.cargo
    pkgs.sccache
  ];
  shellHook = ''
    PATH=$PATH:/home/parzival/.cargo/bin
    export LIB_PATH="${pkgs.wayland}/lib:${pkgs.libxkbcommon}/lib:${pkgs.vulkan-loader}/lib";
    export RUSTFLAGS="-Clink-args=-Wl,-rpath=$LIB_PATH"
    export RUSTC_WRAPPER=sccache
  '';
}
