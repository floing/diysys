# VIM的个性化

## 基本配置
### 安装vim,scripts,doc

    ```sh
    sudo apt-get install vim vim-scripts vim-doc
    ```
    > **Tips:**
    > * vim         vim软件，安装目录是/usr/share/vim
    > * vim-scripts vim的基本插件，包括语法高亮等，安装目录是/usr/share/vim-scripts
    > * vim-doc     vim帮助文件，不过是英文版本的

### 中文帮助文档
    1. 下载[最新版本](http://sourceforge.net/projects/vimcdoc/files/vimcdoc/)的vim中文帮助文档
    2. 解压doc文件夹到~/.vim目录下

### 配置~/.vimrc文件
    
    配置个性化的[.vimrc](.vimrc)（不懂的命令可以用`:help command`查看中文帮助文档）


## 实用插件
vim的插件很多，而且功能很强大，非常强大。官网的插件地址在[这里](http://www.vim.org/scripts/script_search_results.php?order_by=creation_date&direction=descending)。
### ctags
ctags可以建立源码树的标签索引（标签就是一个标识符被定义的地方，如函数定义），使程序员在编程时能迅速定位函数、变量、宏定义等位置去查看原形。
1. 安装exuberant-ctags工具
    ```sh
    sudo apt-get install exuberant-ctags
    ```
2. 创建ANSI C（VC）代码库索引
    1. 从VC安装目录的CRT文件夹里获取C Run-Time库的大部分源代码，至于wlibc文件夹中。
    2. 将wlibc文件夹移到~/.vim/tags目录后执行ctags命令
        ```sh
        ctags -f vctag -h ".h.H" -R --c-kinds=+p --fields=+iaS --extra=+q --language-force=C wlib
        ```
    3. 在.vimrc中设置
        ```vim
        set tags+=~/.vim/tags/vctag
        ```
3. 创建GNU C代码库索引
    1. 到[官网](http://www.gnu.org/software/libc/index.html)下载[glibc](http://ftp.gnu.org/gnu/glibc/glibc-2.22.tar.xz)
    2. 将下载的文件glibc-2.22.tar.xz移到~/.vim/tags目录后执行以下命令
        ```sh
        # 解压xz文件并保留源文件
        xz -dk glibc-2.22.tar.xz
        # 解压tar文件并删除tar源文件
        tar -xvf glibc-2.22.tar && rm glibc-2.22.tar
        ctags -f gctag -h ".h.H" -R --c-kinds=+p --fields=+iaS --extra=+q --language-force=C glibc-2.22
        ```
    3. 在.vimrc中设置
        ```vim
        set tags+=~/.vim/tags/gctag
        ```

4. 创建C++代码库索引
    1. 下载[libstdc++](http://www.vim.org/scripts/download_script.php?src_id=9178)头文件,包含c++中STL，streams等。
    2. 解压到~/.vim/tags目录后执行ctags命令
        ```sh
        ctags -f cpptag -R --c++-kinds=+p --fields=+iaS --extra=+q --language-force=C++ cpp_src
        ```
    3. 在.vimrc中设置
        ```vim
        set tags+=~/.vim/tags/cpptag
        ```
5. 创建GCC代码库索引
    1. ubuntu中安装完build-essential后，会在/usr/include/c++目录下有C/C++的头文件。
        ```sh
        sudo apt-get install build-essential
        ```
    2. 为/usr/include目录下面所有的.h/.H文件构建索引
        ```sh
        ctags -f gcctag -h ".h.H" -R --c++-kinds=+p --fields=+iaS --extra=+q /usr/include
        ```
    3. 在.vimrc中设置
        ```vim
        set tags+=~/.vim/tags/gcctag

### taglist
在屏幕右侧出现的就是taglist窗口，从中可以看到文件中定义的所有tag：宏、定义、变量、函数等；通过单击某个tag，可以跳到该tag定义的位置；也可以把某一类的tag折叠起来，方便查看。
1. 安装taglist
    ```sh
    vim-addon-manager install taglist
    ```
2. 在.vimrc中配置
    ```vim

    ```
3. 自定义快捷键说明
    * <F10>     打开/关闭标签列表

### winmanager
WinManager用于管理文件浏览器和缓冲区（buffer）。2.0以上版本的WinManager还可以管理其他IDE类型插件，不过要用户在插件中增加一些辅助变量和hook来支持WinManager（帮助文档有相关说明）。
1. 安装winmanager
    ```sh
    vim-addon-manager install winmanager
    ```
2. 在.vimrc中配置
    ```vim

    ```
3. 自定义快捷键说明
    * <F9>     打开/关闭文件浏览器

### minibufexplorer
MiniBufferExplorer用于浏览和管理buffer，如果只打开一个文件，是不会显示在屏幕上的，而打开多个文件之后，会自动出现在屏幕上。vim也有自带的buffer管理工具，不过只有:ls, :bnext, :bdelete 等的命令, 既不好用, 又不直观.
1. 安装minibufexplorer
    ```sh
    vim-addon-manager install minibufexplorer
    ```
2. 在.vimrc中配置
    ```vim

    ```
3. 自定义快捷键说明
    * <Tab>     移动到下一个buffer
    * <C-Tab>   移动到上一个buffer

### quickfix
通过quickfix命令集，你可在 Vim 内编译程序并直接跳转到出错位置进行修正。你可以接着重新编译并做修正，直到不再出错为止。因为quickfix已经在vim里集成了，只要配置就好了。
1. 在.vimrc中配置
    ```vim

    ```
3. 自定义快捷键说明
    * <F2>     make当前程序
    * <F10>    make clean当前程序
    * <F3>     光标移动到上一个错误所在行
    * <F4>     光标移动到下一个错误所在行

    


