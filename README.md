# dotfiles

## Setup

```sh
sh -c "$(curl -fsLS https://chezmoi.io/get)" -- init --apply m-hamashita
```

## Local overrides

Machine-specific settings can be kept outside chezmoi's source state:

- `~/.bash_local` is sourced at the end of `~/.bashrc` when it exists.
- `~/.config/git/ignore_local` is appended to the global Git ignore file when
  `chezmoi apply` runs.
