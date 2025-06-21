#!/bin/bash

# Waybarの設定ファイルとスタイルシートのパスをあなたの環境に合わせて変更してください
# 例: ~/.config/waybar/config.jsonc
CONFIG_FILE="$HOME/.config/waybar/config.jsonc"
#STYLE_FILE="$HOME/.config/waybar/style.css"

echo "Watching for changes in $CONFIG_FILE "

while true; do
  # inotifywait でファイルの変更を監視します
  # -e modify: ファイルが変更されたことを検出
  inotifywait -e modify "$CONFIG_FILE"

  echo "Waybar config changed, restarting Waybar..."

  # 実行中のWaybarを終了させ、新しい設定で再起動します
  # config.jsonc を使用している場合は、Waybarの起動コマンドもそれに合わせて調整してください
  # 例: killall waybar && waybar -c "$CONFIG_FILE" &
  killall waybar && /usr/bin/waybar &
done
