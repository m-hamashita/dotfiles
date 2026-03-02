---
name: commit
description: >
  git commit を実行する。"/commit" または「commit」等で起動。
  ステージ済み差分から Semantic Commit Message（type(scope): subject）を生成して commit する。
  ステージが無い場合は、対話操作不要な方法（ファイル単位 / ディレクトリ単位 / intent-to-add）で git add を提案する（自動 add はしない）。
allowed-tools: Bash(git:*)
---

# Commit

ステージされた変更に対して commit message を生成し、commit を実行する。

本 skill は **Semantic Commit Messages**（`type(scope): subject`）を採用し、commit message の一貫性と可読性を高める。

## フロー

1. 状態確認
   - `git status --porcelain=v1 -b`
   - マージ/リベース等の途中なら中断して案内
2. ステージ確認（ステージ有無判定はこれを正とする）
   - `git diff --cached --name-status`
   - ステージが無い場合は「git add 提案」へ
3. 差分把握
   - `git diff --cached --stat`
   - 変更が小規模な場合のみ `git diff --cached`（大規模なら省略または主要ファイルに限定）
4. commit message 生成（Semantic）
5. commit 実行
   - 件名のみ: `git commit -m "<subject line>"`
   - 本文あり: `printf '%s\n' "<subject line>" "" "<body>" | git commit -F -`
6. 結果報告
   - 成功時: `git rev-parse --short HEAD` を含める
   - 失敗時: エラー要約と次のアクションを提示

## git add 提案（ステージが無い場合）

未ステージ差分と未追跡ファイルを把握:

- `git diff --name-status`
- `git ls-files --others --exclude-standard`

提案方針（選択不要）:

- 基本: 変更ファイルを列挙してファイル単位で add
  - `git add <files...>`
- まとまりが明確なら以下の単位で分割を提案（例: docs / tests / ci / app）
  - `git add docs/ README.md`
  - `git add tests/`
  - `git add .github/`
- 未追跡ファイルを差分として見える化したい場合:
  - `git add -N <files...>`（intent-to-add）
- 同一ファイル内で意図が混在していそうな場合:
  - 自動分割はせず「ファイル単位でまとめる」方針を示す

## commit message 生成（英語 / Semantic）

commit message の形式:

- `type(scope): subject`（scope は任意、不要なら `type: subject`）
- scope はパス/主要コンポーネントから推定し、確信がない場合は省略

type の種類:

- `feat`: new feature for the user, not a new feature for build script
- `fix`: bug fix for the user, not a fix to a build script
- `docs`: changes to the documentation
- `style`: formatting, missing semi colons, etc; no production code change
- `refactor`: refactoring production code, eg. renaming a variable
- `test`: adding missing tests, refactoring tests; no production code change
- `chore`: updating grunt tasks etc; no production code change

subject のルール:

- 英語、命令形（Add/Update/Fix/Remove/Refactor/Rename/Improve/Simplify/Move）
- 50文字目安、末尾ピリオドなし

本文（任意）のルール:

- 複数ファイル / 挙動変更 / 意図が自明でない場合に付ける
