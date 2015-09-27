""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Author:	hjy
" Gmail:	haojunyu2012@gmail.com
" Detail:	vim的个人定制化文件,使用Vundle管理vim插件，通用linux发行版本
" Refer:	https://www.ituring.com.cn/article/53300
"			http://beiyuu.com/git-vim-tutorial/
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""""""""""""""""""""""
" 通用配置
""""""""""""""""""""""""""""""""""""""""""""""""""
""""""""""""""""""""""""""""""""""
" 基本配置
""""""""""""""""""""""""""""""""""
" 关闭兼容模式，打开Vim的扩展功能
set nocompatible
" 启动时不显示援助索马里儿童的提示
set shortmess=atI
" 在所有模式都可以使用鼠标
set mouse=a
" history存储长度
set history=1000
" 粘贴时保持格式
set paste
" 当文件被改动时自动载入
set autoread
" 自动把内容写回文件
set autowrite
" 退格键可以处理indent，eol，start
set backspace=indent,eol,start

" 文件默认编码
set encoding=utf-8
" 检测文件编码顺序
set fileencodings=utf-8,ucs-bom,cp936,gb2312,gbk,gb18030,big5,euc-jp,euc-kr,latin1
"防止特殊符号无法显示
"set ambiwidth=double



""""""""""""""""""""""""""""""""""
" 外观配置
""""""""""""""""""""""""""""""""""
" elflord/ron/peachpuff/default/... 设置配色方案，vim自带的配色方案保存在/usr/share/vim/vim74/colors目录下
colorscheme peachpuff 
" colorscheme solarized
" 设置字体
set guifont=Courier\ 12
" 设置vim前景背景颜色
hi Normal ctermfg=green ctermbg=black guifg=green guibg=black
hi LineNr ctermfg=blue ctermbg=black guifg=blue guibg=black
hi CursorLine cterm=NONE ctermbg=white ctermfg=black guibg=white guifg=black

" 自定义高亮配色
hi User1 ctermfg=black  ctermbg=white " guifg=black guibg=white
hi User2 ctermfg=red    "ctermbg=white " guifg=red   guibg=white
hi User3 ctermfg=green  "ctermbg=white " guifg=green guibg=white
hi User4 ctermfg=red    ctermbg=green " guifg=red   guibg=green
hi User5 guifg=#002600  guibg=#67ab6e   gui=italic

" 显示行号
set number
" 突出显示当前行
set cursorline
" 整词换行
set linebreak
" 光标从行首和行末时可以跳到另一行去
set whichwrap=b,s,<,>,[,]
" TAB和空格可见（显示方便）
set list
" TAB为>---，空格为-
set listchars=tab:>-,trail:-

" 设置折叠文本
set foldenable
" 设置折叠等级，越大越少的折叠
set foldlevel=30
" 折叠语法高亮
set foldmethod=syntax
" 设置折叠栏宽度
set foldcolumn=4
" 空格展开折叠
nnoremap <space>  zA


" 总是开启状态栏
set laststatus=2
" 状态栏显示
set statusline=
    " 正常高亮显示缓冲区号,占三个字符
set statusline+=%3*%-3.3n\ 
    " User{3}高亮显示文件名
set statusline+=%0*%f\ 
    " User{2}高亮显示缓冲区标志：帮助|修改|只读|预览窗口
set statusline+=%2*%h%m%r%w\ 
    " 正常高亮显示
set statusline+=%2*[
    " vim版本高于6.0
if v:version >= 600
        " 显示文件类型
    set statusline+=%{strlen(&ft)?&ft:'none'},
        " 显示文本编码
    set statusline+=%{&fileencoding},
endif
    " 显示文件格式 dos/unix/mac
set statusline+=%{&fileformat}]
    " 用微笑符中的鼻子状态表现文件状态error|warning|norm
if filereadable(expand("$HOME/.vim/plugin/vimbuddy.vim"))
    set statusline+=%0*\ %{VimBuddy()}
endif
    " User{2}高亮显示时间
set statusline+=%2*\ %-16{strftime(\"%Y-%m-%d\ %H:%M\")}\ 
    " 左对齐和右对齐项目之间的分割点
set statusline+=%0*%=
    " 正常高亮显示光标所在字符的值（十六进制）
set statusline+=0x%-4B\ 
    " 正常高亮显示光标所在的位置（行，列-虚拟列 行数百分百）
set statusline+=%-10.(%l,%c%V%)\ %<%P

" 命令行显示输入的命令
set showcmd
" 命令行显示vim当前模式
set showmode


""""""""""""""""""""""""""""""""""
" 缩进配置
""""""""""""""""""""""""""""""""""
" 设置制表符（tab键）的宽度
set tabstop=4
" 插入tab符号以空格替换（通用）
set expandtab
" （自动）缩进使用4个空格
set shiftwidth=4

" 设置自动对齐（缩进）：即每行的缩进值与上一行相等
set autoindent
" 开启新行时使用智能自动缩进
set smarttab
" 开启c程序缩进
" set cindent
"设置C/C++语言的具体缩进方式
" set cinoptions={0,1s,t0,n-2,p2s,(03s,=.5s,>1s,=1s,:1s 


""""""""""""""""""""""""""""""""""
" 搜索配置
""""""""""""""""""""""""""""""""""
" 输入搜索内容时就显示搜索结果
set incsearch
" 搜索时高亮显示被查找的文本
set hlsearch

" 搜索时忽略大小写
set ignorecase
" 全小写时才不敏感，有大写时就敏感
set smartcase


""""""""""""""""""""""""""""""""""
" 高亮匹配
""""""""""""""""""""""""""""""""""
" 如果支持语法高亮，则开启
if has("syntax")
	syntax on
endif
" 高亮匹配括号
set showmatch
" 将每行超出80列的字符标记为白字红底
highlight OverLength ctermbg=DarkGray guibg=#592929
match OverLength /\%81v.\+/



""""""""""""""""""""""""""""""""""
" 自动载入模板文件
""""""""""""""""""""""""""""""""""
" markdown模板，主要是为了写博文
autocmd BufNewFile *.md     0r  ~/.vim/template/markdown.md
" python模板
autocmd BufNewFile *.py     0r  ~/.vim/template/python.py
" shell模板
autocmd BufNewFile *.sh     0r  ~/.vim/template/shell.sh
"autocmd BufNewFile *.tex    0r  ~/.vim/template/latex.tex
"autocmd BufNewFile *.html   0r  ~/.vim/template/html.html

autocmd GUIEnter * simalt ~x




""""""""""""""""""""""""""""""""""""""""""""""""""
" 自定义函数
""""""""""""""""""""""""""""""""""""""""""""""""""
""""""""""""""""""""""""""""""""""
" <Ctrl-s>保存
""""""""""""""""""""""""""""""""""







""""""""""""""""""""""""""""""""""""""""""""""""""
" 插件配置--Vundle管理
""""""""""""""""""""""""""""""""""""""""""""""""""
""""""""""""""""""""""""""""""""""
" Vundle配置
""""""""""""""""""""""""""""""""""
" 文件类型检测关闭[必须]（/usr/share/vim/vim74/filetype.vim）
filetype off
" 设置runtime path包含Vundle的路径并且初始化
set rtp+=~/.vim/bundle/Vundle.vim
" 设置plugins安装地址
call vundle#begin('~/.vim/bundle/')

""""""""""""""""""""""""""""""""""
" vundle管理的插件
""""""""""""""""""""""""""""""""""
" 安装Vundle，让其管理插件[必须]
Plugin 'gmarik/Vundle.vim'

" 在Vim的编辑窗口中树状显示文件目录[The-NERD-tree]
Plugin 'The-NERD-tree'

" 快速添加/去除注释
Plugin 'The-NERD-Commenter'

" solarized主题
Plugin 'altercation/vim-colors-solarized'

" molokai主题
Plugin 'tomasr/molokai'

" 替换taglist的插件[tagbar]
Plugin 'majutsushi/tagbar'

" 状态栏增强展示[vim-powerline]
Plugin 'Lokaltog/vim-powerline'

" 多文档编辑
Plugin 'fholgado/minibufexpl.vim'

" 文件搜索
Plugin 'kien/ctrlp.vim'

" 括号显示增强
Plugin 'luochen1990/rainbow'

" 快速移动
Plugin 'Lokaltog/vim-easymotion'

" 语义高亮
Plugin 'scrooloose/syntastic'

" 自动补全
Plugin 'Valloric/YouCompleteMe'

" python集成开发
Plugin 'Python-mode-klen'

""""""""""""""""""""""""""""""""""
" Vundle插件安装样例:
" 插件在github上
" Plugin 'tpope/vim-fugitive'
" 插件来自网页http://vim-scripts.org/vim/scripts.html
" Plugin 'L9'
" Git插件，但插件不在Github上
" Plugin 'git://git.wincent.com/command-t.git'
" 插件在本地机器上 (i.e. when working on your own plugin)
" Plugin 'file:///home/gmarik/path/to/plugin'
" The sparkup vim script is in a subdirectory of this repo called vim.
" Pass the path to set the runtimepath properly.
" Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
" 使用用户名来避免插件冲突 ie. L9
" Plugin 'user/L9', {'name': 'newL9'}
""""""""""""""""""""""""""""""""""

" 所有插件的添加在end之前[必须]
call vundle#end()            
" 文件类型对应的插件[必须]（/usr/share/vim/vim74/ftplugin.vim）
filetype plugin on
" 文件类型对应的缩进文件
filetype indent on



""""""""""""""""""""""""""""""""""
" The-NERD-tree配置
""""""""""""""""""""""""""""""""""
" 不显示缓冲文件，中间文件
let NERDTreeIgnore=[ '.pyc$', '.pyo$', '.obj$', '.o$', '.so$', '.egg$', '^.git$', '^.svn$', '^.hg$' ]
" 只剩一个NERDTree窗口时退出vim
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") &&b:NERDTreeType == "primary") | q | endif
" <F9>打开/关闭文件管理器
nnoremap <silent> <F9> :NERDTreeToggle<CR>


""""""""""""""""""""""""""""""""""
" The-NERD-Commenter配置
""""""""""""""""""""""""""""""""""
" 注释的时候自动加个空格, 强迫症必配
let g:NERDSpaceDelims=1
" mm智能判断加上/解开注释
map mm <leader>c<space>


""""""""""""""""""""""""""""""""""
" solarized配置（最优）
""""""""""""""""""""""""""""""""""
" 设置终端的颜色范围
" let g:solarized_termcolors=256
" 设置终端背景是否透明
let g:solarized_termtrans=1
" 设置特殊字符：末尾空格，Tab，换行显示模式high|normal|low
let g:solarized_visibility='high'


""""""""""""""""""""""""""""""""""
" molokai配置（次优）
""""""""""""""""""""""""""""""""""
" 使用molokai原先的颜色模式
let g:molokai_original = 1



""""""""""""""""""""""""""""""""""
" ctag配置
""""""""""""""""""""""""""""""""""
" 添加vc标签文件
"set tags+=~/.vim/tags/vctag
" 添加gnu c标签文件
set tags+=~/.vim/tags/gctag
" 添加gcc标签文件
"set tags+=~/.vim/tags/gcctag
" 添加c++标签文件
"set tags+=~/.vim/tags/cpptag


""""""""""""""""""""""""""""""""""
" tagbar配置
""""""""""""""""""""""""""""""""""
" 启动时自动focus
let g:tagbar_autofocus=1
" <F10>打开/关闭Tagbar
nnoremap <silent> <F10> :TagbarToggle<CR>



""""""""""""""""""""""""""""""""""
" vim-powerline配置
""""""""""""""""""""""""""""""""""
" powerline设置状态栏的模式fancy|unicode
let g:Powerline_symbols = 'unicode'



""""""""""""""""""""""""""""""""""
" minibufexpl配置
""""""""""""""""""""""""""""""""""
" 用<C-h/j/k/l>切换到上下左右窗口
let g:miniBufExplMapWindowNavVim    = 1
" 用Ctrl+箭头切换到上下左右窗口
let g:miniBufExplMapWindowNavArrows = 1
" 不要在不可编辑内容的窗口（如TagList）中打开选中的buffer
let g:miniBufExplModSelTarget       = 1
" 解决FileExplorer窗口变小问题
let g:miniBufExplorerMoreThanOne=2
" buffer切换循环
let g:miniBufExplCycleArround=1
" normal模式下<Tab>移动到下一个buffer，<C-Tab>上一个
nnoremap <silent> <Tab> :bn<CR>
nnoremap <silent> <C-Tab> :bp<CR>


""""""""""""""""""""""""""""""""""
" ctrlp配置
""""""""""""""""""""""""""""""""""
" 设置CtrlP的本地工作目录，0代表不设置该功能
let g:ctrlp_working_path_mode=0
" ctrlp窗口在底部
let g:ctrlp_match_window_bottom=1
" ctrlp窗口最大高度为15行
let g:ctrlp_max_height=15
" 窗口
let g:ctrlp_match_window_reversed=0
" 最近打开的文件的个数
let g:ctrlp_mruf_max=500
" 记录但去掉重复的软链接
let g:ctrlp_follow_symlinks=1
" <Ctrl-f>启动文件查找
let g:ctrlp_map = '<c-f>'
" Ctrlp启动文件查找
let g:ctrlp_cmd = 'CtrlP'
" 相当于mru功能，show recently opened files
map <c-p> :CtrlPMRU<CR>
" 忽略以下文件类型
set wildignore+=*/tmp/*,*.so,*.swp,*.zip
" 忽略以下文件目录
let g:ctrlp_custom_ignore = {'dir':  '/].(git|hg|svn|rvm)$','file': '(exe|so|dll|zip|tar|tar.gz)$'}


""""""""""""""""""""""""""""""""""
" rainbow配置
""""""""""""""""""""""""""""""""""
" rainbow激活
let g:rainbow_active = 1


""""""""""""""""""""""""""""""""""
" syntastic配置
""""""""""""""""""""""""""""""""""
" 首次打开和保存时都要进行语义检查
let g:syntastic_check_on_open = 1  
" 设置错误提示符'x'
let g:syntastic_error_symbol = 'x'  
" 设置警告提示符'!'
let g:syntastic_warning_symbol = '!'  
" 当鼠标放在错误行则显示错误信息
let g:syntastic_enable_balloons = 1  
" 保存退出时不用进行语义检测
let g:syntastic_check_on_wq = 0
" 编译有误则错误窗口显示，否在不显示
let g:syntastic_auto_loc_list = 1
" 错误总会填充到错误窗口
let g:syntastic_always_populate_loc_list = 1

" set statusline+=%#warningmsg#
" set statusline+=%{SyntasticStatuslineFlag()}
" set statusline+=%*




""""""""""""""""""""""""""""""""""
" YouCompleteMe配置
""""""""""""""""""""""""""""""""""
" 设置YCM配置文件的路径
let g:ycm_global_ycm_extra_conf='~/.vim/bundle/YouCompleteMe/third_party/ycmd/cpp/ycm/.ycm_extra_conf.py'
" 开启关键字语法检测
let g:ycm_seed_identifiers_with_syntax = 1 
" 自动触发补全
let g:ycm_auto_trigger = 1 
" YCM触发的条件
let g:ycm_semantic_triggers = {  
\ 'c' : ['->' , '.'],
\ 'cpp,objcpp' : ['->','.','::'],
\ 'java,javascript,python,scala' : ['.'],
\ 'ruby' : ['.','::'],
\}
" 不用每次询问.ycm_extra_conf.py位置
let g:ycm_confirm_extra_conf=0
" YCM也从tags文件中收集标识符
let g:ycm_collect_identifiers_from_tags_files=1
" 当输入注释的时候不用弹出提示
let g:ycm_complete_in_comments=0
" 当输入字符的时候弹出提示
let g:ycm_complete_in_strings=1

































"-- markdown --
let g:vimmarkdownfoldingdisabled=1 "取消代码折叠
let g:vimmarkdownnodefaultkeymappings=1 "取消默认的键对应
let g:vimmarkdownmath=1 "使用数学符号
let g:vimmarkdownfrontmatter=1 "高亮YMAL frontmatter









""""""""""""""""""""""""""""""""""""""""""""
" undo
""""""""""""""""""""""""""""""""""""""""""""
" （1）vundle 为嘛filetype off
" （2）利用vundle管理插件，可以将状态栏多彩化
" （4）尝试exvim
" （5）尝试cscope代替ctags
" （6）nerdtree代替fileexplore

