# dotfiles

作業環境の設定ファイル（Nix Home Manager + Flakes管理）

このリポジトリは、Nix FlakesとHome Managerを使用して宣言的に環境を管理しています。

## セットアップ手順

### 🚀 最も簡単な方法：GitHub Codespacesを使う

**推奨**：Nixのインストールが不要で、ブラウザだけで環境をテストできます！

1. このリポジトリのGitHubページを開く
2. 緑色の **"Code"** ボタンをクリック
3. **"Codespaces"** タブを選択
4. **"Create codespace on main"** をクリック

数分待つと、Nix環境が自動セットアップされたVSCodeがブラウザで開きます。  
設定ファイルとCLIツール（kitty、tmux、nvimなど）が自動的に適用されます。

> **注**: GUIツール（Hyprland、Waybarなど）はCodespacesでは動作しませんが、  
> 設定ファイルのリンクやCLIツールのインストールは完全にテスト可能です。

---

### 🖥️ ローカルマシンでの環境構築

#### 前提条件
- Nixパッケージマネージャーがインストールされていること
- Flakes機能が有効化されていること

#### ローカルマシンでの環境構築

1. **Nixのインストール（未インストールの場合）**
```bash
# Nixのインストール（公式推奨方法）
sh <(curl -L https://nixos.org/nix/install) --daemon

# Flakes機能を有効化
mkdir -p ~/.config/nix
echo "experimental-features = nix-command flakes" >> ~/.config/nix/nix.conf
```

2. **dotfilesリポジトリをクローン**
```bash
git clone https://github.com/u1e2k/dotfiles.git ~/dotfiles
cd ~/dotfiles
```

3. **Home Managerで環境を構築**
```bash
# 初回適用（既存の設定ファイルがある場合は自動的に上書きされます）
nix run home-manager/release-24.05 -- switch --flake .#me

# 2回目以降の適用
home-manager switch --flake .#me
```

これだけで、すべての設定ファイルとツールが自動的にセットアップされます。

---

## 設定の管理

### 設定ファイルの更新

設定を変更した後は、以下のコマンドで反映します：

```bash
cd ~/dotfiles
home-manager switch --flake .#me
```

**Codespacesの場合**: ターミナルで上記コマンドを実行するだけで即座に反映されます。

### 管理される設定ファイル

- **ルートディレクトリ**: `.bashrc`, `.zshrc`, `.vimrc`, `.gitconfig`, `.wezterm.lua`, `.bin/`
- **`.config/`ディレクトリ**: 
  - `alacritty/`, `btop/`, `eww-which-key/`, `fcitx5/`, `fish/`
  - `gtk-3.0/`, `gtk-4.0/`, `hypr/`, `kitty/`, `micro/`
  - `nvim/`, `qt5ct/`, `qt6ct/`, `satty/`, `tmux/`
  - `uwsm/`, `waybar/`, `xsettingsd/`
- **`.config/`直下ファイル**: `cachyos-hello.json`, `dolphinrc`, `electron-flags.conf`, `kdeglobals`, `mimeapps.list`, `user-dirs.dirs`, `user-dirs.locale`
- **`.local/share/`**: `color-schemes/`, `fonts/` (HackGen Nerd Fonts)

### インストールされるパッケージ

以下のパッケージが自動的にインストールされます：
- **Hyprland**（Waylandコンポジタ）※Codespacesでは動作不可
- **Waybar**（ステータスバー）※Codespacesでは動作不可
- **Wofi**（アプリケーションランチャー）※Codespacesでは動作不可
- **Kitty**（ターミナル）
- **Neovim / Vim**（エディタ）
- **Tmux**（ターミナルマルチプレクサ）
- **Git、curl、wget、tree、ripgrep、fd、fzf**などの基本ツール
- その他多数（詳細は[home.nix](home.nix)を参照）

---

## 💻 GitHub Codespaces について

このリポジトリには `.devcontainer/` 設定が含まれており、GitHub Codespacesで簡単にテストできます。

### Codespacesの特徴

✅ **メリット**:
- Nixのインストール不要（自動セットアップ）
- ブラウザだけで動作
- CLIツール（tmux、nvim、gitなど）の動作確認が可能
- 設定ファイルのリンクとパッケージインストールをテスト可能

❌ **制限事項**:
- GUIツール（Hyprland、Waybar、Wofi）は動作しません
- X11/Waylandディスプレイサーバーが必要なアプリは使用不可

### Codespacesの使い方

1. **起動**: リポジトリページで "Code" → "Codespaces" → "Create codespace"
2. **待機**: 初回は5-10分ほどかかります（Nixパッケージのダウンロード）
3. **確認**: 自動的に `home-manager switch` が実行されます
4. **テスト**: ターミナルで `tmux`、`nvim`、`fzf` などを試してみてください

### Codespacesでの再適用

設定を変更した場合：

```bash
home-manager switch --flake .#me
```

### トラブルシューティング

- **初回ビルドが遅い場合**: Codespacesのマシンタイプを 4-core 以上にアップグレード
- **パッケージが見つからない**: ターミナルを再起動してみてください

---

## 🛠 手動セットアップ（Nixを使わない場合）

Nix/Home Managerを使わない環境、または一部の設定だけ適用したい場合に使えるスクリプトを用意しています。

### 1. インタラクティブセットアップ（推奨）

項目を選択して個別にインストールできます。

```bash
git clone https://github.com/u1e2k/dotfiles.git ~/dotfiles
cd ~/dotfiles
./setup-interactive.sh
```

**操作方法:**
| キー | アクション |
|------|-----------|
| `0-38` | 項目をトグル選択/解除 |
| `a` | 全選択（存在するもののみ） |
| `n` | 全解除 |
| `c` | カテゴリ単位で全選択/全解除 |
| `Enter` | 選択した項目をインストール実行 |
| `q` | 終了 |

**カテゴリ:**
- **HOME直下**: `.vimrc`, `.bashrc`, `.zshrc`, `.gitconfig`, `.wezterm.lua`, `.bin`
- **.config 直下ファイル**: `cachyos-hello.json`, `dolphinrc`, `electron-flags.conf`, `kdeglobals`, `mimeapps.list`, `user-dirs.dirs`, `user-dirs.locale`
- **.config ディレクトリ**: `alacritty`, `btop`, `eww-which-key`, `fcitx5`, `fish`, `gtk-3.0`, `gtk-4.0`, `hypr`, `kitty`, `micro`, `nvim`, `qt5ct`, `qt6ct`, `satty`, `tmux`, `uwsm`, `waybar`, `xsettingsd`
- **.local/share**: `color-schemes`, `fonts`

全自動でやりたい場合:
```bash
./setup-interactive.sh --all
```

### 2. 従来のスクリプト（非インタラクティブ）

```bash
# 全項目インストール
./install.sh

# またはシンプル版
./setup.sh

# 現在のリンク状態を確認
./check.sh
```

- `install.sh` / `setup.sh`: 定義済みの全項目を `ln -sfbv` でリンク（既存は `.bak` バックアップ）
- `check.sh`: シンボリックリンクが正しく張られているか検証

---

## 従来の手動セットアップ（参考）

以下は、Nix導入前の手動セットアップ手順です（現在は不要）。

- OS インストール
- ディレクトリ名を英語へ変更
- 日本語入力環境

2025/6 openSUSEでの流れ

```bash
LANG=C xdg-user-dirs-gtk-update
sudo zypper in hyprland
sudo zypper in kitty
sudo zypper in git
vim .config/hypr/hyprland.conf 
sudo zypper in wofi
sudo zypper in waybar
sudo zypper in fcitx5
sudo zypper in rofi
mkdir ~.config/waybar
mkdir ~/.config/waybar
cp config.jsonc ~/.config/waybar/
cd ~/.config/waybar/
vi config.jsonc 
sudo zypper in hyprland-qtutils
vi config.jsonc 
vi .config/waybar/config.jsonc 
cd /etc/xdg/waybar/
mv config.jsonc  config.jsonc.old
sudo mv config.jsonc  config.jsonc.old
vi .config/waybar/config.jsonc 
sudo zypper in zen-browser
zypper addrepo https://download.opensuse.org/repositories/home:Stan8/openSUSE_Tumbleweed/home:Stan8.repo
sudo zypper addrepo https://download.opensuse.org/repositories/home:Stan8/openSUSE_Tumbleweed/home:Stan8.repo
sudo zypper in zen-browser
sudo zypper ar -cf https://download.opensuse.org/repositories/devel:/tools:/ide:/vscode/openSUSE_Tumbleweed devel_tools_ide_vscode
sudo zypper in code
vi .config/nvim/init.lua
cd mkdir nvim
mkdir nvim
cd nvim/
vi init.lua
nvim
nvim init.lua 
kitty + list-fonts --psnames
```

# sudo zypper in
```
btop
cowsay
eww
fortune
hyprshot
jq
mpv
neovim
pyenv
tmux
waybar
wofi
zen-browser
```

waybarの再起動の自動化とか
hyprshotとか
hyprhookのビルドし直しとかやった

検証も含めて自動で行ってくれるようにしたい

#
`fortune | cowsay -r`
