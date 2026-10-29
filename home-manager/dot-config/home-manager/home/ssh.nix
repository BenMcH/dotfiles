{ ... }:

{
  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;

    extraConfig = ''
      IgnoreUnknown UseKeychain
      AddKeysToAgent yes
      UseKeychain yes
      ForwardAgent yes

      Include /Users/bmchone/.colima/ssh_config
      Include configs/*
    '';

    matchBlocks = {
      "pi" = {
        hostname = "192.168.86.43";
        user = "ubuntu";
      };
      "hermes" = {
        hostname = "192.168.86.49";
        user = "mchone";
      };
      "appvm" = {
        hostname = "192.168.86.8";
        user = "mchone";
      };

      "*" = {
        setEnv = {
          TERM = "xterm-256color";
        };
      };
    };
  };
}
