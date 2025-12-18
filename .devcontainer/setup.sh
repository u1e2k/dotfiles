#!/usr/bin/env bash
set -e

echo "🚀 Setting up Nix environment..."

# Flakes機能を有効化
mkdir -p ~/.config/nix
echo "experimental-features = nix-command flakes" > ~/.config/nix/nix.conf

# Nixの環境変数を読み込み
if [ -e ~/.nix-profile/etc/profile.d/nix.sh ]; then
  . ~/.nix-profile/etc/profile.d/nix.sh
fi

echo "✅ Nix configuration completed!"

# Home Managerのインストールと初回適用
echo "📦 Installing Home Manager..."
nix run home-manager/release-24.05 -- switch --flake .#me --impure

echo "🎉 Development environment is ready!"
echo ""
echo "To apply configuration changes, run:"
echo "  home-manager switch --flake .#me"
