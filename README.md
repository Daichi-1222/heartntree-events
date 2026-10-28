# ハートンツリー イベント一覧ページ

公式LINEのリッチメニューから開く、イベント・季節プランの一覧ページ。

- 公開URL：（初期設定後に記入）
- 作成：2026-10-28

## しくみ

```
チラシ画像をClaudeに添付「一覧に追加」
  → Claudeが画像から日付・料金・定員などを読み取り、足りない所だけ質問
  → 内容をユーザーが確認
  → events.json に1件追加 ＋ images/ に縮小画像を保存
  → git push → GitHub Pages に数分で反映
公式LINEのリッチメニューは一覧ページのURLを指したまま。毎回の設定は不要
```

- `events.json` … 掲載内容の台帳（唯一の元データ）
- `images/` … チラシ画像（長辺1200px）
- `index.html` … 台帳を読んで表示する。開催日を過ぎたものは自動で「終了したイベント」へ
- `tools/add_image.sh` … 画像の縮小
- 手順の詳細：`LINE公式/.claude/skills/event-page-add/SKILL.md`

注意：GitHub Pages は公開リポジトリ。`events.json` に書いたものは誰でも見られるので、未確定の情報は入れない。

## GitHub Pages 初期設定（最初の1回だけ）

### 1. GitHubアカウントを作る（ご本人）
https://github.com/signup で作成。メールは info@heartntree.com など店のアドレスがおすすめ。
ユーザー名は公開URLに入る（例 `heartntree` → `https://heartntree.github.io/events/`）。

### 2. Macにログイン用ツールを入れる
ターミナルで：

```bash
brew install gh
```

### 3. GitHubにログインする（ご本人）

```bash
gh auth login
```

質問には「GitHub.com」→「HTTPS」→「Yes」→「Login with a web browser」を選び、
表示されたコードをブラウザに入力して許可する。

### 4. リポジトリ作成と公開（Claudeが実行）
ログインが済んだらClaudeに「公開して」と伝える。Claudeが次を行う。

1. このフォルダを git リポジトリにして最初のコミット
2. GitHubに公開リポジトリ `events` を作って送る
3. GitHub Pages を有効化（main ブランチ / ルート）
4. 公開URLをこのREADMEに記入

### 5. 公式LINEのリッチメニューに登録（ご本人）
LINE公式アカウントマネージャー → リッチメニュー → ボタンのアクションを「リンク」にして公開URLを入れる。
リッチメニュー画像の作成は `line-rich-writer` で対応できる。

### 6.（任意・後日）独自ドメインにする
`events.heartntree.com` のような住所にしたい場合は、ムームードメインのDNSにCNAMEを1行足す。
heartntree.com 自体の表示エラー（2026-10-28時点で409）を整理するときに一緒に行うとよい。
