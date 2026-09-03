#!/bin/bash -eu

# チェックスクリプト: 管理対象のシンボリックリンクが正しく張られているか確認

CURRENT_DIR=`pwd`
HOME_PATH=$HOME

# チェック対象リスト（setup.sh と同じ）
declare -a check_items=(
    # HOME直下
    ".vimrc"
    ".bashrc"
    ".zshrc"
    ".gitconfig"
    ".wezterm.lua"
    ".bin"

    # .config直下ファイル
    ".config/cachyos-hello.json"
    ".config/dolphinrc"
    ".config/electron-flags.conf"
    ".config/kdeglobals"
    ".config/mimeapps.list"
    ".config/user-dirs.dirs"
    ".config/user-dirs.locale"

    # .config直下ディレクトリ
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

    # .local/share
    ".local/share/color-schemes"
    ".local/share/fonts"
)

echo "=== Symlink Status Check ==="
echo ""

ok=0
missing=0
wrong=0

for item in "${check_items[@]}"; do
    local_path="$HOME_PATH/$item"
    source_path="$CURRENT_DIR/$item"

    if [ ! -e "$source_path" ]; then
        echo "⚠ SOURCE MISSING: $source_path"
        ((wrong++))
        continue
    fi

    if [ -L "$local_path" ]; then
        target=$(readlink "$local_path")
        if [ "$target" = "$source_path" ]; then
            echo "✓ OK: $item"
            ((ok++))
        else
            echo "✗ WRONG TARGET: $item -> $target (expected: $source_path)"
            ((wrong++))
        fi
    elif [ -e "$local_path" ]; then
        echo "✗ EXISTS BUT NOT SYMLINK: $item (regular file/dir)"
        ((wrong++))
    else
        echo "✗ MISSING: $item"
        ((missing++))
    fi
done

echo ""
echo "=== Summary ==="
echo "OK:       $ok"
echo "Missing:  $missing"
echo "Wrong:    $wrong"
echo "Total:    ${#check_items[@]}"

if [ $missing -gt 0 ] || [ $wrong -gt 0 ]; then
    echo ""
    echo "Run ./setup.sh or ./install.sh to fix."
    exit 1
else
    echo ""
    echo "All symlinks are correct!"
    exit 0
fi