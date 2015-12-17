#!/bin/bash
# coding:	utf-8
# Author:	hjy
# Gmail:	haojunyu2012@gmail.com
# detail:	此脚本用于Ubuntu/Mac系统下的vim安装以及庞大插件的配置


# 安装vim
if which apt-get > /dev/null
then
    # 基本配置
    sudo apt-get install -y  vim vim-scripts vim-doc
    # ctags
    sudo apt-get install -y exuberant-ctags
    # YouCompleteMe
    sudo apt-get install -y clang llvm cmake xz-utils python python-dev

elif
    which yum > /dev/null; then
        echo "You are using CentOS!"

elif
    which brew > /dev/null; then
        echo "You are using Mac OS X!"
        brew install macvim CMake
        # 给mvim -v取别名
        echo "alias vi='mvim -v'" >> ~/.bashrc
        echo "alias vim='mvim -v'" >> ~/.bashrc
        echo "if [ -f ~/etc/bashrc ]; then . ~/etc/bashrc fi" >> ~/.bashrc
        source ~/.bashrc
fi

# 备份原来配置文件
mv $HOME/.vimrc $HOME/.vimrc.bak
mv $HOME/.vim $HOME/.vim.bak


# 配置vim
ln `pwd`/.vimrc $HOME/
ln -s `pwd`/.vim $HOME/.vim

# 配置插件
vi install -c "PluginInstall" -c "q" -c "q!"

pushd $HOME/.vim/bundle/YouCompleteMe
YCM_CORES=1 ./install.py --clang-completer
popd

