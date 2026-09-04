---
name: dotfiles-doctor
description: このchezmoi dotfilesリポジトリ、bootstrap、Fish、Codex設定、Brewfile、aquaを診断または検証するときに使用する。「dotfilesを診断して」「doctor」などの依頼に対応する。
---

# Dotfiles Doctor

1. `chezmoi doctor`を実行し、`chezmoi status`を確認する。
2. `chezmoi apply --dry-run --verbose`で適用内容を確認する。
3. shell templateをrenderし、利用可能ならShellCheckで検証する。
4. Fishファイルを`fish --no-execute`で検証する。
5. render後のTOML、JSON、YAMLを利用可能なツールで検証する。
6. Brewfileとaqua packagesの重複や古い項目を確認する。
7. Codexの設定キー、skill配置、名前、指示の重複を確認する。
8. 実際の`chezmoi apply`、`brew bundle`、`aqua install`は実行しない。
9. severity、ファイル参照、修正案を含めて報告する。
