{ pkgs ? import <nixpkgs> { } }:

pkgs.mkShell
{
  buildInputs = with pkgs; [
    clippy
    rustfmt
    rustc

    rust-analyzer
    wgsl-analyzer

    cargo
    bacon

    trunk
    dart-sass

    wayland
    libxkbcommon
    vulkan-headers
    vulkan-loader
    vulkan-tools
    sccache
    lld
  ];

  nativeBuildInputs = [ pkgs.pkg-config ];

  env.RUST_SRC_PATH = "${pkgs.rust.packages.stable.rustPlatform.rustLibSrc}";
  env.WASM_SERVER_RUNNER_CUSTOM_INDEX_HTML="./index.html";

  shellHook = ''
    PATH=$PATH:/home/parzival/.cargo/bin
    export RUSTC_WRAPPER=sccache
  '';
}
