---
name: commit
description: 実装と検証が完了した後、またはユーザーが「コミットして」「commit」と依頼したときに使用する。今回のタスクに関係する変更だけをstageし、Conventional Commits形式でcommitする。pushは行わない。
---

# Commit

1. 適用されるリポジトリ指示を確認する。
2. staged、unstaged、untrackedの変更を確認する。
3. 今回の変更に必要な検証が完了していることを確認する。
4. 現在のタスクに関係するパスだけをstageする。
5. 無関係な変更が存在し得る場合は、`git add .`や`git add -A`を使用しない。
6. ユーザーによる既存変更や、今回のタスクと無関係な変更を含めない。
7. 同じファイル内の変更を安全に分離できない場合はcommitせず、理由を報告する。
8. `git diff --cached --check`とstaged diffを確認する。
9. レビューしやすくなる場合のみ、論理的な変更単位にcommitを分ける。
10. commit messageは英語の`type(scope): imperative subject`形式にする。
11. amend、push、branch作成、tag作成、PR作成は行わない。
12. commit hash、message、対象ファイル、実行した検証を報告する。
