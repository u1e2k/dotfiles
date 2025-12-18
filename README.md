# dotfiles

作業環境の設定ファイル（Nix Home Manager + Flakes管理）

このリポジトリは、Nix FlakesとHome Managerを使用して宣言的に環境を管理しています。

## セットアップ手順

### 前提条件
- Nixパッケージマネージャーがインストールされていること
- Flakes機能が有効化されていること

### 新しいマシンでの環境構築

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

### 設定ファイルの更新

設定を変更した後は、以下のコマンドで反映します：

```bash
cd ~/dotfiles
home-manager switch --flake .#me
```

### 管理される設定ファイル

- **ルートディレクトリ**: `.bashrc`, `.zshrc`, `.vimrc`
- **`.config/`ディレクトリ**: `hypr/`, `waybar/`, `kitty/`, `tmux/`, `nvim/` など全て

### インストールされるパッケージ

以下のパッケージが自動的にインストールされます：
- Hyprland（Waylandコンポジタ）
- Waybar（ステータスバー）
- Wofi（アプリケーションランチャー）
- Kitty（ターミナル）
- Neovim / Vim（エディタ）
- Tmux（ターミナルマルチプレクサ）
- Git、curl、wget、tree、ripgrep、fd、fzfなどの基本ツール
- その他多数（詳細は[home.nix](home.nix)を参照）

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
