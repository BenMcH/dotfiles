{ ... }:

{
  programs.starship = {
    enable = true;
    # Configuration written to ~/.config/starship.toml
    settings = {
      add_newline = false;

      aws = {
        disabled = true;
      };

      shell = {
        unknown_indicator = "mystery shell";
        style = "cyan";
        disabled = false;
      };

      package = {
        disabled = true;
      };
    };
  };
}
