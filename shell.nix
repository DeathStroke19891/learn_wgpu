{ pkgs ? import <nixpkgs> { } }:

pkgs.mkShell
{
  buildInputs = with pkgs; [
    clippy
    rustfmt
    rustc
    rust-analyzer
    cargo
    bacon

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
    # if [ "$CARGO_BUILD_TARGET" != "wasm32-unknown-unknown" ]; then
    #   export LIB_PATH="${pkgs.wayland}/lib:${pkgs.libxkbcommon}/lib:${pkgs.vulkan-loader}/lib"
    #   export RUSTFLAGS="-Clink-args=-Wl,-rpath=$LIB_PATH"
    # fi
    export RUSTC_WRAPPER=sccache
  '';
}
