# WezTerm 設定リポジトリ

このリポジトリは WezTerm の個人設定（`.wezterm.lua`）を管理します。外観・挙動・キーバインド・起動メニューを中心に、Windows 環境（Git Bash / PowerShell / WSL）で快適に使える構成です。

## 概要

- カラースキーム: Catppuccin Mocha
- フォント: `0xProto Nerd Font Propo` / `UDEV Gothic NF` / `Yu Gothic UI`
- 既定シェル: Git Bash（`C:\\Program Files\\Git\\bin\\bash.exe`）
- スクロールバック: 5000 行
- 透過度: 0.95、ウィンドウパディング調整、タブバー常時表示
- 便利なキーバインドと起動メニュー（WSL / Git Bash / PowerShell）

## セットアップ

### 前提

- WezTerm 本体のインストール
- 推奨フォントのインストール
  - 0xProto Nerd Font Propo（Nerd Font 対応）
  - UDEV Gothic NF
  - Yu Gothic UI（Windows 標準）
## 🎨 フォントの準備

この設定ファイルでは **0xProto Nerd Font** を使用しています。
アイコンや文字を正しく表示するために、以下の手順でフォントをインストールしてください。

### インストール手順

1. [Nerd Fonts のダウンロードページ](https://www.nerdfonts.com/font-downloads) にアクセスします。
2. **0xProto** を検索し、`Download` ボタンをクリックして zip ファイルをダウンロードします。
3. ダウンロードしたファイルを展開（解凍）します。
4. フォントをシステムに登録します：
   - **Windows**: フォルダ内のすべての `.ttf` ファイルを選択し、右クリックして「**インストール**」（または「すべてのユーザーに対してインストール」）を選択します。
   - **macOS**: `Font Book.app` を開き、`.ttf` ファイルをドラッグ＆ドロップします。
5. WezTerm を再起動します。

> **注意**: 設定ファイル内では具体的に `0xProto Nerd Font Propo` を指定しています。インストール漏れがないようにご注意ください。

### 設定ファイルの配置

通常はホームディレクトリ直下に配置します。

- Windows: `%USERPROFILE%\\.wezterm.lua`

本リポジトリで管理する場合は、次のどちらかで運用してください。

- 手動でコピーする: リポジトリの `.wezterm.lua` を `%USERPROFILE%` にコピー
- シンボリックリンクを張る（管理しやすい方法）

例（PowerShell 管理者権限）:

```
New-Item -ItemType SymbolicLink -Path $env:USERPROFILE\.wezterm.lua -Target (Resolve-Path .\.wezterm.lua)
```

## 使い方

### 起動メニュー（Launch Menu）

- Ubuntu (WSL): `wsl.exe -d Ubuntu -e bash -c 'cd ~ && exec bash'`
- Git Bash: `C:\\Program Files\\Git\\bin\\bash.exe`
- PowerShell: `powershell.exe -NoLogo`

WezTerm 起動後、`Ctrl+Shift+P` でコマンドパレットから「Launch Menu」を検索して選択できます。

### キーバインド（抜粋）

- タブを開く: `Ctrl + t`
- ペインを閉じる: `Ctrl + w`（確認なし）
- コピー: `Ctrl + Shift + c`
- ペースト: `Ctrl + Shift + v`
- 縦分割: `Alt + Shift + =`
- 横分割: `Alt + Shift + -`
- ペイン移動: `Alt + ← / → / ↑ / ↓`
- タブ切替: `Ctrl + Tab` / `Ctrl + Shift + Tab`

## 主な設定

### 外観（Appearance）

- `config.color_scheme = 'Catppuccin Mocha'`
- フォントファミリはフォールバック指定: `0xProto Nerd Font Propo` → `UDEV Gothic NF` → `Yu Gothic UI`
- `font_size = 12.0`
- `window_background_opacity = 0.95`
- `window_padding = { left = 10, right = 10, top = 10, bottom = 5 }`
- `hide_tab_bar_if_only_one_tab = false`
- `window_decorations = "RESIZE"`

### 挙動（Behavior）

- `scrollback_lines = 5000`
- `automatically_reload_config = true`（保存時に自動リロード）
- `default_prog = {'C:\\Program Files\\Git\\bin\\bash.exe'}`（新規タブも Git Bash）

### 環境変数（Windows サイドに適用）

- `LANG=ja_JP.UTF-8`, `LC_ALL=ja_JP.UTF-8`
- `PATH` 先頭に `~/.cargo/bin` を追加（Rust 開発向け）
- 備考: WSL 側の環境変数は WSL 内（`~/.bashrc`, `~/.profile` 等）で設定してください。

## カスタマイズのヒント

- 既定シェルを変えたい場合は、`default_prog` を `powershell.exe` や `wsl.exe` に変更
- キーバインドは `config.keys` に追記／変更
- 起動メニューのエントリは `config.launch_menu` に追加

## トラブルシュート

- フォント関連の記号が正しく表示されない:
  - Nerd Font のインストール／フォント名の一致を確認
  - `font_with_fallback` の順序を調整
- カラースキームが反映されない:
  - WezTerm にスキームが含まれているか、綴りの確認
- WSL 起動でエラー:
  - ディストリ名（`Ubuntu`）や WSL の状態を確認

## リポジトリ構成

- `.wezterm.lua`: WezTerm のメイン設定
- `README.md`: このファイル

Pull Request / Issue 歓迎です。設定追加や改善案があれば気軽にどうぞ。

