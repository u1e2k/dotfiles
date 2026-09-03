#!/bin/bash -xeu

# シンプルなセットアップスクリプトを目指して

CURRENT_DIR=`pwd`

# --- ~/.config ディレクトリの確認と作成 ---
# .config以下のファイルやディレクトリをリンクする前に、
# 必ずこのディレクトリが存在することを確認・作成する必要があります。
folder_path="$HOME/.config"

if [ ! -d "$folder_path" ]; then
  echo "Folder '$folder_path' does not exist. Creating..."
  mkdir -p "$folder_path"
  if [ $? -eq 0 ]; then
    echo "Folder '$folder_path' created successfully."
  else
    echo "Failed to create folder '$folder_path'. Exiting."
    exit 1 # エラーとして終了
  fi
else
  echo "Folder '$folder_path' already exists."
fi

# --- ~/.local/share ディレクトリの確認と作成 ---
local_share_path="$HOME/.local/share"

if [ ! -d "$local_share_path" ]; then
  echo "Folder '$local_share_path' does not exist. Creating..."
  mkdir -p "$local_share_path"
  if [ $? -eq 0 ]; then
    echo "Folder '$local_share_path' created successfully."
  else
    echo "Failed to create folder '$local_share_path'. Exiting."
    exit 1
  fi
else
  echo "Folder '$local_share_path' already exists."
fi


# 管理したいdotfileのリスト
# HOME直下と.config以下のファイルを全てここに記述
declare -a dotfiles_to_link=(
    # HOME直下のファイル
    ".vimrc"
    ".bashrc"
    ".zshrc"
    ".gitconfig"
    ".wezterm.lua"
    ".bin"

    # .configディレクトリ直下のファイル
    ".config/cachyos-hello.json"
    ".config/dolphinrc"
    ".config/electron-flags.conf"
    ".config/kdeglobals"
    ".config/mimeapps.list"
    ".config/user-dirs.dirs"
    ".config/user-dirs.locale"

    # .config 直下のディレクトリ
    ".config/alacritty"
    ".config/btop"
    ".config/eww-which-key"
    ".config/fcitx5"
    ".config/fish"
    ".config/gtk-3.0"
    ".config/gtk-4.0"
    ".config/hypr"
    ".config/kitty"
    ".config/micro"
    ".config/nvim"
    ".config/qt5ct"
    ".config/qt6ct"
    ".config/satty"
    ".config/tmux"
    ".config/uwsm"
    ".config/waybar"
    ".config/xsettingsd"

    # .local/share 以下
    ".local/share/color-schemes"
    ".local/share/fonts"
)

echo "--- Dotfiles Setup Started ---"

for item in "${dotfiles_to_link[@]}"; do
    local_path="$HOME/$item"          # 例: $HOME/.vimrc または $HOME/.config/nvim
    source_path="$CURRENT_DIR/$item" # 例: $CURRENT_DIR/.vimrc または $CURRENT_DIR/.config/nvim

    # source_path (dotfilesリポジトリ内の元の項目) が存在することを確認
    # -e はファイルまたはディレクトリのどちらでも存在することを確認します。
    if [ ! -e "$source_path" ]; then
        echo "Source item '$source_path' does not exist. Skipping."
        continue # 次のループへ
    fi

    echo "Creating symlink: '$source_path' -> '$local_path'"
    # ln はファイルでもディレクトリでも同じ -sfbv オプションでリンクできます。
    ln -sfbv "$source_path" "$local_path"
done

echo "--- Dotfiles Setup Complete! ---"


# 後処理 (シェルを再読み込みするなど)
if [ -f "$HOME/.bashrc" ]; then
    echo "Sourcing ~/.bashrc to apply changes."
    source "$HOME/.bashrc"
fi

echo "--- All Dotfiles Setup Complete! ---"