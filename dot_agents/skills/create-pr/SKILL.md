---
name: create-pr
description: ユーザーが「PRを作って」「Pull Requestを作成して」「create PR」と明示的に依頼した場合だけ使用する。必要なbranch作成、commit、pushを行い、原則としてDraft PRを作成する。通常の実装やcommit依頼では使用しない。
---

# Pull Request作成

1. 明示的なPR作成依頼を、必要なbranch作成とpushの許可として扱う。
2. リポジトリ指示とPR templateを確認する。
3. default branch、現在のbranch、remoteを確認する。
4. status、commit、default branchとの差分を確認する。
5. 公開前に`preflight`の手順で検証する。
6. 未commitの関連変更があれば`commit`の手順でcommitする。
7. 無関係な変更やユーザーによる既存変更を含めない。
8. default branch上にいる場合は、内容を表す短いbranchを作成する。
9. 同じhead branchのopen PRがないことを確認する。
10. 必要ならupstreamを設定してpushする。
11. 差分を表すタイトルと本文を作成し、既存のPR templateを優先する。
12. ユーザーがready状態を指定しない限りDraft PRとして作成する。
13. 明示的なPR作成依頼の後に、同じ内容の再確認は求めない。
14. PRをmergeしない。
15. PR URL、base、head、実行した検証を報告する。
