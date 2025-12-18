{ config, pkgs, ... }:

let
  username = builtins.getEnv "USER";
  homeDirectory = builtins.getEnv "HOME";
in
{
  # ユーザー情報を環境変数から自動取得
  home.username = username;
  home.homeDirectory = homeDirectory;

  # Home Managerのバージョン
  home.stateVersion = "24.05";

  # ルートの設定ファイルをリンク
  home.file = {
    ".bashrc" = {
      source = ./.bashrc;
      force = true;
    };
    ".zshrc" = {
      source = ./.zshrc;
      force = true;
    };
    ".vimrc" = {
      source = ./.vimrc;
      force = true;
    };
    # .config ディレクトリ全体を再帰的にリンク
    ".config" = {
      source = ./.config;
      recursive = true;
      force = true;
    };
  };

  # 必要なパッケージをインストール
  home.packages = with pkgs; [
    # Wayland / Hyprland関連
    hyprland
    waybar
    wofi
    
    # ターミナル
    kitty
    
    # エディタ
    neovim
    vim
    
    # ターミナルマルチプレクサ
    tmux
    
    # シェル
    bash
    zsh
    
    # 基本ツール
    git
    curl
    wget
    tree
    ripgrep
    fd
    fzf
    
    # その他便利ツール
    htop
    btop
    eza
    bat
  ];

  # プログラムの設定
  programs.home-manager.enable = true;
  
  # Git設定（必要に応じてカスタマイズ）
  programs.git = {
    enable = true;
  };

  # Bash設定（既存の.bashrcを使用）
  programs.bash = {
    enable = true;
  };

  # Zsh設定（既存の.zshrcを使用）
  programs.zsh = {
    enable = true;
  };
}
