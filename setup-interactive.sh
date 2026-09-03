#!/bin/bash -eu

# インタラクティブなセットアップスクリプト
# 実行時に選択肢を表示し、選択した項目のみシンボリックリンクを張る

CURRENT_DIR=`pwd`

# --- 項目定義: "表示名|パス" の形式 ---
# カテゴリごとにグルーピングしておく
declare -A categories=(
    ["HOME直下"]=".vimrc|.vimrc
.bashrc|.bashrc
.zshrc|.zshrc
.gitconfig|.gitconfig
.wezterm.lua|.wezterm.lua
.bin|.bin"

    [".config 直下ファイル"]=".config/cachyos-hello.json|.config/cachyos-hello.json
.config/dolphinrc|.config/dolphinrc
.config/electron-flags.conf|.config/electron-flags.conf
.config/kdeglobals|.config/kdeglobals
.config/mimeapps.list|.config/mimeapps.list
.config/user-dirs.dirs|.config/user-dirs.dirs
.config/user-dirs.locale|.config/user-dirs.locale"

    [".config ディレクトリ"]=".config/alacritty|.config/alacritty
.config/btop|.config/btop
.config/eww-which-key|.config/eww-which-key
.config/fcitx5|.config/fcitx5
.config/fish|.config/fish
.config/gtk-3.0|.config/gtk-3.0
.config/gtk-4.0|.config/gtk-4.0
.config/hypr|.config/hypr
.config/kitty|.config/kitty
.config/micro|.config/micro
.config/nvim|.config/nvim
.config/qt5ct|.config/qt5ct
.config/qt6ct|.config/qt6ct
.config/satty|.config/satty
.config/tmux|.config/tmux
.config/uwsm|.config/uwsm
.config/waybar|.config/waybar
.config/xsettingsd|.config/xsettingsd"

    [".local/share"]=".local/share/color-schemes|.local/share/color-schemes
.local/share/fonts|.local/share/fonts"
)

# 全項目をフラットな配列に展開（インデックス管理用）
declare -a all_items=()
declare -a item_names=()
declare -a item_paths=()
declare -a item_categories=()

build_items() {
    all_items=()
    item_names=()
    item_paths=()
    item_categories=()
    local idx=0
    for cat in "HOME直下" ".config 直下ファイル" ".config ディレクトリ" ".local/share"; do
        local list="${categories[$cat]}"
        while IFS= read -r line; do
            [ -z "$line" ] && continue
            local name="${line%%|*}"
            local path="${line#*|}"
            all_items+=("$idx:$cat:$name")
            item_names+=("$name")
            item_paths+=("$path")
            item_categories+=("$cat")
            ((idx++))
        done <<< "$list"
    done
}

# 項目が存在するかチェック
item_exists() {
    local path="$1"
    [ -e "$CURRENT_DIR/$path" ]
}

# シンボリックリンク作成
link_item() {
    local path="$1"
    local local_path="$HOME/$path"
    local source_path="$CURRENT_DIR/$path"

    if [ ! -e "$source_path" ]; then
        echo "  ✗ ソースが存在しません: $source_path"
        return 1
    fi

    mkdir -p "$(dirname "$local_path")"
    ln -sfbv "$source_path" "$local_path"
}

# メニュー表示
show_menu() {
    local -n selected_ref=$1
    clear
    echo "=========================================="
    echo "  Dotfiles セットアップ - 項目選択"
    echo "=========================================="
    echo ""
    echo "操作: 数字=トグル, a=全選択, n=全解除, c=カテゴリ選択, Enter=実行, q=終了"
    echo ""

    local idx=0
    local current_cat=""
    for item in "${all_items[@]}"; do
        IFS=':' read -r i cat name <<< "$item"
        if [ "$cat" != "$current_cat" ]; then
            current_cat="$cat"
            echo ""
            echo "  ── $cat ──"
        fi

        local mark=" "
        if [[ " ${selected_ref[*]} " =~ " $idx " ]]; then
            mark="✓"
        fi

        local status=""
        if ! item_exists "${item_paths[$idx]}"; then
            status=" (ソースなし)"
        fi

        printf "  [%s] %2d) %s%s\n" "$mark" "$idx" "$name" "$status"
    done
    echo ""
    echo "選択中: ${#selected_ref[@]} 項目"
}

# カテゴリ選択メニュー
select_category() {
    local -n selected_ref=$1
    local cat="$2"
    local action="$3"  # "add" or "remove"

    local indices=()
    for item in "${all_items[@]}"; do
        IFS=':' read -r i c name <<< "$item"
        if [ "$c" = "$cat" ]; then
            indices+=("$i")
        fi
    done

    if [ "$action" = "add" ]; then
        for i in "${indices[@]}"; do
            if ! item_exists "${item_paths[$i]}"; then
                continue
            fi
            if [[ ! " ${selected_ref[*]} " =~ " $i " ]]; then
                selected_ref+=("$i")
            fi
        done
    else
        local new_selected=()
        for s in "${selected_ref[@]}"; do
            local skip=0
            for i in "${indices[@]}"; do
                [ "$s" = "$i" ] && skip=1
            done
            [ $skip -eq 0 ] && new_selected+=("$s")
        done
        selected_ref=("${new_selected[@]}")
    fi
}

# メイン
build_items

# コマンドライン引数で --all なら全選択して即実行
if [ "${1:-}" = "--all" ] || [ "${1:-}" = "-a" ]; then
    selected=()
    for i in "${!item_paths[@]}"; do
        item_exists "${item_paths[$i]}" && selected+=("$i")
    done
    echo "全項目をインストールします..."
    for i in "${selected[@]}"; do
        link_item "${item_paths[$i]}"
    done
    echo "完了！"
    exit 0
fi

# インタラクティブモード
selected=()

while true; do
    show_menu selected
    read -rp "> " input

    case "$input" in
        q|Q)
            echo "終了します"
            exit 0
            ;;
        a|A)
            # 全選択（存在するもののみ）
            selected=()
            for i in "${!item_paths[@]}"; do
                item_exists "${item_paths[$i]}" && selected+=("$i")
            done
            ;;
        n|N)
            # 全解除
            selected=()
            ;;
        c|C)
            # カテゴリ選択サブメニュー
            echo ""
            echo "カテゴリを選択:"
            local cats=("HOME直下" ".config 直下ファイル" ".config ディレクトリ" ".local/share" "戻る")
            for j in "${!cats[@]}"; do
                echo "  $j) ${cats[$j]}"
            done
            read -rp "カテゴリ番号: " cat_idx
            if [[ "$cat_idx" =~ ^[0-3]$ ]]; then
                echo "  1) このカテゴリを全選択"
                echo "  2) このカテゴリを全解除"
                read -rp "操作: " cat_action
                if [ "$cat_action" = "1" ]; then
                    select_category selected "${cats[$cat_idx]}" add
                elif [ "$cat_action" = "2" ]; then
                    select_category selected "${cats[$cat_idx]}" remove
                fi
            fi
            ;;
        ""|$'\n')
            # Enter: 実行
            if [ ${#selected[@]} -eq 0 ]; then
                echo "何も選択されていません"
                sleep 1
                continue
            fi
            echo ""
            echo "=== インストール実行 ==="
            for i in "${selected[@]}"; do
                link_item "${item_paths[$i]}"
            done
            echo ""
            echo "完了！"
            read -rp "Enterで終了"
            exit 0
            ;;
        *)
            # 数字入力: トグル
            if [[ "$input" =~ ^[0-9]+$ ]] && [ "$input" -lt ${#item_paths[@]} ]; then
                if item_exists "${item_paths[$input]}"; then
                    if [[ " ${selected[*]} " =~ " $input " ]]; then
                        # 解除
                        new_selected=()
                        for s in "${selected[@]}"; do
                            [ "$s" != "$input" ] && new_selected+=("$s")
                        done
                        selected=("${new_selected[@]}")
                    else
                        # 選択
                        selected+=("$input")
                    fi
                else
                    echo "ソースが存在しないため選択できません"
                    sleep 1
                fi
            else
                echo "無効な入力: $input"
                sleep 1
            fi
            ;;
    esac
done