#!/bin/bash -xeu

CURRENT_DIR=`pwd`

# 管理したいdotfileのリスト *HOME直下
declare -a dotfiles=(
    ".vimrc"
    # 他のファイルもここに追加していく
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
