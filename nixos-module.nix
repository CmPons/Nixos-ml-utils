{ pkgs, lib, config, ... }:
let cfg = config.services.mlUtils;
in {
  options.services.mlUtils = {
    enable = lib.mkEnableOption "mlUtils system service";
  };

  config = lib.mkIf cfg.enable {
    services.ollama = {
      enable = true;
      package = pkgs.ollama;
      acceleration = "rocm";
      rocmOverrideGfx = "11.0.2";
      environmentVariables = { HCC_AMDGPU_TARGET = "gfx1102"; };
    };
  };
}
