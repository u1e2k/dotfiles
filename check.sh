#!/bin/bash -eu

# -x : シェルスクリプト内で実際に実行されたコマンドを表示するオプション。変数が使用されている場合は、その変数の値が展開された状態で表示される。
# -e : 実行したコマンドが0でないステータスで終了した場合、即座に終了するオプション。
# -u : 未設定の変数を参照しようとしたときにエラーを発生

CURRENT_PATH=`pwd`
# echo $CURRENT_PATH
HOME_PATH=$HOME
#echo `ls -al $HOME_PATH`
if [ -L $HOME_PATH/.bashrc ]; then
    echo "check"
else
    echo "try"
fi