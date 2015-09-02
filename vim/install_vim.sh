#!/bin/bash
# coding:	utf-8
# Author:	hjy
# Gmail:	haojunyu2012@gmail.com
# detail:	此脚本用于vim的安装以及庞大插件的配置，目前仅适用于ubuntu版本


# 安装vim
if which apt-get > /dev/null
then
    # 基本配置
	sudo apt-get install vim vim-scripts vim-doc
    # ctags
    sudo apt-get install exuberant-ctags
fi

# 备份原来配置文件
mv $HOME/.vimrc $HOME/.vimrc.bak
mv $HOME/.vim $HOME/.vim.bak


# 配置vim
ln `pwd`/.vimrc $HOME/
ln -s `pwd`/.vim $HOME/.vim

# 配置插件
