# dotfiles

作業環境の設定ファイル（Nix Home Manager + Flakes 管理）

このリポジトリは、Nix Flakes と Home Manager を使用して宣言的に環境を管理しています。

---

## 🚀 クイックスタート

### 方法 A：Nix + Home Manager（推奨・完全自動）

```bash
# 1. Nix インストール（未インストールの場合）
sh <(curl -L https://nixos.org/nix/install) --daemon
mkdir -p ~/.config/nix
echo "experimental-features = nix-command flakes" >> ~/.config/nix/nix.conf

# 2. リポジトリクローン
git clone https://github.com/u1e2k/dotfiles.git ~/dotfiles
cd ~/dotfiles

# 3. 環境構築（初回）
nix run home-manager/release-24.05 -- switch --flake .#me

# 4. 以降の更新
home-manager switch --flake .#me
```

**メリット**: パッケージインストール・設定リンク・サービス有効化まで全部自動、冪等

---

### 方法 B：GitHub Codespaces（ブラウザだけで試せる）

1. GitHub リポジトリページで **Code → Codespaces → Create codespace on main**
2. 5-10 分待つ（自動で `home-manager switch` が走る）
3. ターミナルで `tmux`、`nvim`、`kitty` 等を確認

> **制限**: GUI（Hyprland、Waybar 等）は動作しません。CLI ツールと設定リンクのみテスト可能。

---

### 方法 C：手動スクリプト（Nix なし・選択的適用）

```bash
git clone https://github.com/u1e2k/dotfiles.git ~/dotfiles
cd ~/dotfiles

# インタラクティブ（推奨）
./setup-interactive.sh

# または全自動
./setup-interactive.sh --all

# 従来のスクリプト
./install.sh   # 詳細版
./setup.sh     # シンプル版
./check.sh     # リンク状態検証
```

---

## 📁 管理対象ファイル

| 場所 | ファイル/ディレクトリ |
|------|----------------------|
| **HOME 直下** | `.bashrc`, `.zshrc`, `.vimrc`, `.gitconfig`, `.wezterm.lua`, `.bin/` |
| **.config/** | `alacritty/`, `btop/`, `eww-which-key/`, `fcitx5/`, `fish/` |
| | `gtk-3.0/`, `gtk-4.0/`, `hypr/`, `kitty/`, `micro/` |
| | `nvim/`, `qt5ct/`, `qt6ct/`, `satty/`, `tmux/` |
| | `uwsm/`, `waybar/`, `xsettingsd/` |
| **.config/ 直下ファイル** | `cachyos-hello.json`, `dolphinrc`, `electron-flags.conf`, `kdeglobals`, `mimeapps.list`, `user-dirs.dirs`, `user-dirs.locale` |
| **.local/share/** | `color-schemes/` (noctalia), `fonts/` (HackGen Nerd Fonts v2.10.0) |

---

## 🛠 手動スクリプト詳細

### `setup-interactive.sh`（インタラクティブ・推奨）

項目をカテゴリ別に表示し、選択したものだけリンクします。

```bash
./setup-interactive.sh        # 対話モード
./setup-interactive.sh --all  # 全自動
```

**操作:**
| キー | アクション |
|------|-----------|
| `0-38` | 項目トグル選択/解除 |
| `a` | 全選択（存在するもののみ） |
| `n` | 全解除 |
| `c` | カテゴリ単位で全選択/全解除 |
| `Enter` | 実行 |
| `q` | 終了 |

**カテゴリ:**
- **HOME直下** (6)
- **.config 直下ファイル** (7)
- **.config ディレクトリ** (18)
- **.local/share** (2)

存在しないソースは自動的にスキップされます。

---

### `install.sh` / `setup.sh`（非インタラクティブ）

定義済み全項目を `ln -sfbv` で一括リンク（既存は `.bak` としてバックアップ）。

```bash
./install.sh  # 詳細ログ付き
./setup.sh    # シンプル版
```

---

### `check.sh`（検証）

現在のシンボリックリンク状態を検証。

```bash
./check.sh
```

出力例:
```
✓ OK: .zshrc
✓ OK: .config/hypr
✗ MISSING: .config/waybar
...

=== Summary ===
OK:       32
Missing:  1
Wrong:    0
Total:    33
```

---

## 📦 インストールされる主なパッケージ（Nix 経由）

- **Wayland/Hyprland**: `hyprland`, `waybar`, `wofi`
- **ターミナル**: `kitty`
- **エディタ**: `neovim`, `vim`
- **マルチプレクサ**: `tmux`
- **シェル**: `bash`, `zsh`, `fish`
- **基本ツール**: `git`, `curl`, `wget`, `tree`, `ripgrep`, `fd`, `fzf`, `btop`, `eza`, `bat`
- 詳細は [home.nix](home.nix) を参照

---

## 🔧 設定の更新

```bash
cd ~/dotfiles

# Nix 管理の場合
home-manager switch --flake .#me

# 手動スクリプトの場合
./setup-interactive.sh  # 差分だけ適用したいとき
# または
./install.sh            # 全上書き
```

---

## 📜 変更履歴・メモ（参考）

<details>
<summary>従来の手動セットアップ手順（openSUSE/CachyOS 時代のメモ）</summary>

```bash
# ディレクトリ名英語化
LANG=C xdg-user-dirs-gtk-update

# 主要パッケージ
sudo zypper in hyprland kitty git wofi waybar fcitx5 rofi zen-browser \
  btop cowsay eww fortune hyprshot jq mpv neovim pyenv tmux

# 設定ファイル手動配置
mkdir -p ~/.config/waybar ~/.config/hypr ~/.config/kitty
cp config.jsonc ~/.config/waybar/
# ... 以下手作業
```

</details>

---

## 📄 ライセンス

個人用設定ファイルのため、自由に参考・流用してください。