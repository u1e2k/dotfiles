# Sample .bashrc for SUSE Linux
# Copyright (c) SUSE Software Solutions Germany GmbH

# There are 3 different types of shells in bash: the login shell, normal shell
# and interactive shell. Login shells read ~/.profile and interactive shells
# read ~/.bashrc; in our setup, /etc/profile sources ~/.bashrc - thus all
# settings made here will also take effect in a login shell.
#
# NOTE: It is recommended to make language settings in ~/.profile rather than
# here, since multilingual X sessions would not work properly if LANG is over-
# ridden in every subshell.

test -s ~/.alias && . ~/.alias || true

# 色付きのプロンプト
#PS1='\[\e[1;32m\]\u@\h:\w\$\[\e[0m\] '

# コマンド補完を強化する
if [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
fi

##################
### プロンプト ###
##################

# Gitブランチ名を取得する関数
parse_git_branch() {
     git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}

# プロンプトのフォーマット設定
# \[\e[...m\]: 色設定（非表示文字）
# \u: ユーザー名
# \W: 現在のディレクトリのベース名 (例: foo/bar の bar)
# \w: 現在のディレクトリのフルパス
# \$: rootユーザーなら #、それ以外なら $
# $(parse_git_branch): 上記で定義したGitブランチ表示関数

# 例1: ユーザー名:カレントディレクトリ (Gitブランチ) $
# 緑色のユーザー名、水色のカレントディレクトリ、赤色のGitブランチ
export PS1="\[\e[01;32m\]\u:\[\e[01;36m\]\W\[\e[01;31m\]\$(parse_git_branch)\[\e[00m\]\$ "

# 例2: コマンドの成否に応じてプロンプトの色を変える (より高度な設定)
# PROMPT_COMMAND='EXIT_STATUS=$?; \
# if [ $EXIT_STATUS != 0 ]; then \
#   PS1_COLOR="\[\e[01;31m\]"; # 赤色 (失敗) \
# else \
#   PS1_COLOR="\[\e[01;32m\]"; # 緑色 (成功) \
# fi; \
# export PS1="$PS1_COLOR\u:\[\e[01;36m\]\W\[\e[01;31m\]\$(parse_git_branch)\[\e[00m\]\$ "'

####################
#### エイリアス ####
####################

if type -P eza &>/dev/null; then
	alias ls='eza'
fi

if type -P bat &>/dev/null; then
    alias cat='bat'
fi

eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
