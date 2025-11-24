{ pkgs, lib, config, claude-desktop, ... }:
let
  cfg = config.mlUtils;
  claude-desktop-pkg = claude-desktop.packages.${pkgs.system}.claude-desktop;
in {
  options.mlUtils = { enable = lib.mkEnableOption "mlUtils"; };

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      claude-code
      claude-desktop-pkg
      ollama
      clblast
      rocmPackages.rpp
      koboldcpp
      opencode
    ];
  };
}
