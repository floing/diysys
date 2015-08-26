#!/bin/bash
# coding:	utf-8
# Author:	hjy
# Gmail:	haojunyu2012@gmail.com
# detail:	此脚本用于vim的安装以及庞大插件的配置，目前仅适用于ubuntu版本


# 安装vim
sudo apt-get install vim vim-scripts vim-doc

# 配置vim
ln `pwd`/.vimrc $HOME/
ln `pwd`/.vim $HOME/

# 配置插件
