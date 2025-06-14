#!/bin/bash -xeu

CURRENT_DIR=`pwd`

# 管理したいdotfileのリスト *HOME直下
declare -a dotfiles=(
    ".bin"  # フォルダ
    ".vimrc"
    ".bashrc"
    # ".gitconfig"
)

echo "--- Dotfiles Setup Started ---"

for file in "${dotfiles[@]}"; do
    local_file="$HOME/$file"       # ホームディレクトリでのパス
    source_file="$CURRENT_DIR/$file" # dotfilesリポジトリ内のパス

    # シンボリックリンクを張る
    echo "Creating symlink: '$source_file' -> '$local_file'"
    ln -sfbv "$source_file" "$local_file"
    # -f force
    # -b backup
    # -n オプションは通常不要、もし必要なら追加しても良い
    # -v オプションは表示のため残しておく
done


echo "--- Dotfiles Setup Complete! ---"


# シェルを再読み込みするなどの後処理があれば追加
# source ~/.bashrc

folder_path="$HOME/.config" # ~/.configフォルダが存在しているかを確認する

if [ ! -d "$folder_path" ]; then
  echo "フォルダ '$folder_path' は存在しません。作成します..."
  mkdir -p "$folder_path"
  if [ $? -eq 0 ]; then
    echo "フォルダ '$folder_path' が正常に作成されました。"
  else
    echo "フォルダ '$folder_path' の作成に失敗しました。"
    exit 1 # エラーとして終了
  fi
else
  echo "フォルダ '$folder_path' は既に存在します。"
fi

#####################################

# --- .config 直下に置きたいファイルの管理 ---
declare -a config_files=(
    "electron-flags.conf"
    # 他の.config直下のファイルもここに追加していく
    # 例: "custom-app-config.conf"
)

echo "--- Dotfiles Setup Started (.config Directory Files) ---"

for file in "${config_files[@]}"; do
    local_file="$HOME/.config/$file"       # ~/.config/直下でのパス
    source_file="$CURRENT_DIR/.config/$file" # dotfilesリポジトリ内の.configディレクトリでのパス

    # source_file (dotfiles内の元のファイル) が存在することを確認
    if [ ! -f "$source_file" ]; then
        echo "Source file '$source_file' does not exist. Skipping."
        continue # 次のループへ
    fi

    echo "Creating symlink: '$source_file' -> '$local_file'"
    ln -sfbv "$source_file" "$local_file"
done

echo "--- Dotfiles Setup Complete (.config Directory Files) ---"


####################################################

# --- .config 以下の管理 ---
# 例: ~/.config/nvim を ~/dotfiles/.config/nvim にリンク
# 例: ~/.config/alacritty を ~/dotfiles/.config/alacritty にリンク

declare -a config_dirs=(
    "eww-which-key"
    "hypr"
    "waybar"
    "kitty"
    "nvim"
    "tmux"
    # 他の.config以下のディレクトリを追加
)

echo "--- .config Directories Setup Started ---"

for dir in "${config_dirs[@]}"; do
    local_dir="$HOME/.config/$dir"      # ホームディレクトリでのパス
    source_dir="$CURRENT_DIR/.config/$dir" # dotfilesリポジトリ内のパス

    # source_dir (dotfiles内の元のディレクトリ) が存在することを確認
    if [ ! -d "$source_dir" ]; then
        echo "Source directory '$source_dir' does not exist. Skipping."
        continue # 次のループへ
    fi

    echo "Creating symlink for directory: '$source_dir' -> '$local_dir'"
    ln -sfbv "$source_dir" "$local_dir"
done

echo "--- .config Directories Setup Complete! ---"