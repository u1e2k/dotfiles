# dotfiles

作業環境の構築用メモ

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
