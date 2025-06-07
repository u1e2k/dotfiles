#!/bin/bash

# dotfilesリポジトリのパス（このスクリプトがあるディレクトリを想定）
DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# 管理したいdotfileのリスト
declare -a dotfiles=(
    ".vimrc"
    # 他のファイルもここに追加していく
    ".bashrc"
    # ".gitconfig"
)

echo "--- Dotfiles Setup Started ---"

for file in "${dotfiles[@]}"; do
    local_file="$HOME/$file"       # ホームディレクトリでのパス
    source_file="$DOTFILES_DIR/$file" # dotfilesリポジトリ内のパス

    # dotfilesリポジトリに実体が存在しない場合はスキップ
    if [ ! -f "$source_file" ]; then
        echo "Warning: Source file '$source_file' not found. Skipping '$file'."
        continue
    fi

    # ホームディレクトリに同名のファイルまたはシンボリックリンクが既に存在する場合
    if [ -e "$local_file" ] || [ -L "$local_file" ]; then
        # 既存のファイルをバックアップ
        backup_dir="$HOME/dotfiles_backup_$(date +%Y%m%d)"
        mkdir -p "$backup_dir" # バックアップディレクトリが存在しなければ作成

        echo "Backup: Moving existing '$local_file' to '$backup_dir/'"
        mv "$local_file" "$backup_dir/$file"
    fi

    # シンボリックリンクを張る
    echo "Creating symlink: '$source_file' -> '$local_file'"
    ln -s "$source_file" "$local_file"
    # -f オプションは不要になります（既存ファイルをmvで移動済みのため）
    # -n オプションは通常不要ですが、もし必要なら追加しても良い
    # -v オプションは表示のため残しておく
done

echo "--- Dotfiles Setup Complete! ---"

# シェルを再読み込みするなどの後処理があれば追加
# source ~/.bashrc
