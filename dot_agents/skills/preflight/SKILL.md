---
name: preflight
description: commitやPRの前、またはユーザーが「検証して」「準備できているか確認して」「preflight」と依頼した場合に使用する。差分を確認して適切な検証を実行するが、commitやpushは行わない。
---

# Preflight

1. 適用されるリポジトリ指示を確認する。
2. staged、unstaged、untrackedの変更を確認する。
3. 既存のformat、lint、typecheck、build、testコマンドを調査する。
4. 変更に対して意味のある最小限の非破壊的な検証を実行する。
5. 許可なく依存関係をインストールしない。
6. 秘密情報、debug出力、無関係な変更、不要な生成物がないか確認する。
7. 成功、失敗、未実行の検証と、残るリスクを報告する。
8. commit、push、PR作成は行わない。
