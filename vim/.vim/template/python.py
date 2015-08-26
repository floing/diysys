# coding=utf-8
#!/usr/bin/python

# 导入所用模块 -- sys 是常用的模块 
import sys

# 代码写在main()里面
def main():
    # 命令行的参数在 sys.argv[1], sys.argv[2] ...
    # sys.argv[0] 表示脚本名称
    print 'Hello there', sys.argv[1]

# 调用main()函数来启动程序的样板
if __name__ == '__main__':
    main()
