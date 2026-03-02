---
name: create-pr
description: 現在のブランチから GitHub CLI (gh) で Pull Request を作成する。デフォルトは Draft PR。ユーザーが「PR 作成して」「create-pr」などと言ったら起動する。現在のブランチがベースブランチ（e.g., main/master）なら、PR作成用のブランチを選択/作成してから進める。
allowed-tools: Bash(git:*) Bash(gh:*)
---

# Create PR（汎用版 / Draft デフォルト）

## 概要

現在のブランチの変更内容をもとに、**Draft PR をデフォルト**として `gh pr create` で Pull Request を作成する。  
PR タイトルは差分・コミットから推定し、PR 本文は ** PR Template が存在する場合はそれを優先**して生成する。

- Draft PR: `gh pr create --draft`
- ラベル付与: `gh pr create --label ...`（作成と同時に付与）

## ワークフロー

### 0) 前提確認（gh / git）

1. `gh` と `git` が利用できる前提で進める。
2. `gh` 認証が必要な場合は `gh auth login` を案内して中断する。

### 1) ベースブランチ（既定ブランチ）と現在ブランチの確認

1. 現在ブランチを取得:
   - `git rev-parse --abbrev-ref HEAD`
2. ベースブランチ（既定ブランチ）を推定（優先順）:
   - `gh repo view --json defaultBranchRef -q .defaultBranchRef.name`
   - 失敗したら `origin/HEAD`:
     - `git symbolic-ref refs/remotes/origin/HEAD`（末尾ブランチ名を使用）
   - それも無理なら `main` を仮定（仮定した旨を明示）
3. 現在ブランチがベースブランチと同一なら、PR 作成用ブランチをユーザーに確認（ここだけ質問可）:
   - 既存ブランチへ移動、または
   - ベースブランチから新規ブランチを作成（コミットが存在してから続行）

### 2) 変更内容の収集（タイトル/本文の根拠）

1. コミット・差分を確認（例）:
   - `git log --oneline --decorate -n 30`
   - 追加文脈が必要なら: `git log --format=fuller -n 30`
   - 変更ファイル一覧:
     - `git diff --name-only origin/<base>...HEAD`（失敗時は `<base>...HEAD`）
2. 主要な変更（dominant change）を抽出し、簡潔な PR タイトルを推定する。

### 3) 未コミット変更の確認

1. `git status --short` を確認。
2. 未コミット変更がある場合:
   - ユーザーに「この未コミット変更をコミットして PR に含めるか」を確認する。
   - コミットする場合: `git add` → `git commit -m "<message>"` を行って続行。
   - コミットしない場合: コミット済み差分のみで PR を作る。
   - 最終確認で「未コミット変更は含まれない」ことを明示。
3. 無ければ続行。

### 4) PR 本文テンプレート生成

1. テンプレート探索（優先順）:
   - `.github/pull_request_template.md`
   - `.github/PULL_REQUEST_TEMPLATE.md`
   - `PULL_REQUEST_TEMPLATE.md`
2. 見つかったテンプレートは、その構造を保ったまま、差分・コミットから具体的に埋める。
3. 見つからない場合は、以下のシンプルな汎用テンプレートを使用する。

#### 汎用テンプレート

```
## Description
### What
<!-- どのような変更を行ったかを記載する -->

### Why
<!-- なぜこの変更が必要かを記載する -->

### How
<!-- [Optional] どのように実装したかを記載する -->

## Reference
<!-- [Optional] 関連資料（設計書・仕様・リンクなど）があれば記載する -->
```

> 方針:
>
> - 不明な箇所は空欄のまま残し、ユーザー修正で埋められる状態にする
> - 任意セクションは削らず残す（空でもOK）

### 5) ラベル指定（任意）を組み込む

1. PR に付与したいラベルが **明示されている場合のみ**採用する。
2. 明示が無い場合は **ラベル無し**（= `--label` を付けない）で進める。

### 6) 最終ドラフト提示（実行前）

1. 次をユーザーに提示:
   - ベースブランチ: `<base>`
   - head ブランチ: `<branch>`
   - Draft で作成する（固定）
   - 付与ラベル（あれば）
   - PR タイトル（推定）
   - PR 本文（全文）
   - 未コミット変更の扱い（あれば）
2. 番号選択のみで確認:
   - `1. この内容で実行する（Draft PR を作成）`
   - `2. タイトル/本文/ラベルを修正する`
3. `2` の場合は修正指示を受けて更新し、再度 1/2 で確認。
4. `1` まで `gh pr create` は実行しない。

### 7) Draft PR の作成（gh）

1. 同一 head ブランチの open PR が既にあるか確認:
   - `gh pr list --head <branch> --state open`
2. 既に存在する場合:
   - 新規作成せず、既存 PR URL を提示して終了。
3. 存在しない場合:
   - 本文を一時ファイルへ書き出し（崩れ防止）。
   - 実行（Draft 固定）:
     - `gh pr create --draft -B <base> -H <branch> -t "<title>" -F <body_file> [--label "<labels>"]`
4. 作成された PR URL を提示する。
5. `gh pr create` が「No commits between base and head」等で失敗した場合:
   - `git push -u origin <branch>` を案内または実行し、再度 `gh pr create` を試行する。
   - pre-push hook で失敗した場合は「差分確認 -> add/commit -> push 再試行」をガイドする。

## 注意事項

- ベースとの差分が無い（コミットが無い）場合は PR 作成不可なので中断してコミットを促す。
- `--label` で指定したラベルがリポジトリに存在しない場合、エラーになり得る（その場合は既存ラベルの一覧確認や作成が必要）。
- `--fill` を使う運用にしたい場合、コミットメッセージにカンマがあるとタイトル/本文が意図せず分割される報告があるため注意。
