# Dotfiles

Configuration is managed by [Home Manager](https://github.com/nix-community/home-manager), with one file per program under [`home-manager/dot-config/home-manager/home/`](./home-manager/dot-config/home-manager/home/). [`mchone.nix`](./home-manager/dot-config/home-manager/home/mchone.nix) is the entry point; Linux-only config lives in `linux.nix`.

A few things are still symlinked with [GNU Stow](https://www.gnu.org/software/stow/manual/stow.html): the Home Manager flake itself, [neovim](./nvim/dot-config/nvim/) (a submodule), and xfce4-terminal on Linux.

## Setup

Clone to `~/.dotfiles` and run `./install.sh`.

## Applying changes

```sh
nh home switch
```

`nh` shows which packages and files change before applying them. Plain `home-manager switch --flake ~/.dotfiles/home-manager/dot-config/home-manager` also works.

## Adding configuration

- Prefer a Home Manager `programs.<name>` module over a raw config file; search options at [home-manager-options.extranix.com](https://home-manager-options.extranix.com/).
- Packages without a module go in `home.packages` in `mchone.nix`.
- Paths go in `home.sessionPath` and environment variables in `home.sessionVariables`, so every shell gets them. Don't use `fish_add_path` or `set -U` for anything meant to be shared: `fish_variables` is per-machine and not tracked.
- For OS-specific config, use `lib.mkIf pkgs.stdenv.isDarwin` / `isLinux` (or `lib.optionals` for lists) rather than checking `uname` at runtime.
- New `.nix` files must be `git add`ed before the flake can see them.

## TODO

- ruby?
- deno?
- node?
