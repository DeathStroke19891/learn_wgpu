{
  description = "Godot Tutorial";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
  };

  outputs = { self, nixpkgs }:
  let
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};
  in
  {
    packages.${system}.default = pkgs.rustPlatform.buildRustPackage {
      name = "learn-wgpu";
      src = ./.;
      buildInputs = with pkgs; [
        wayland
        libxkbcommon
        vulkan-headers
        vulkan-loader
        vulkan-tools
      ];
      nativeBuildInputs = [ pkgs.pkg-config ];
      cargoLock.lockFile = ./Cargo.lock;
    };

    devShells.${system}.default = (import ./shell.nix { inherit pkgs;});
  };
}
