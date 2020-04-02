# 开机自启

## supervisor
`supervisor` 是跨平台的软件，因为它依赖的 python2/3 是跨平台的。而且因为python 的包可以使用 `--user` 来安装，所以它既可以是用户级的也可以是系统级的。
对应 mac 的系统推荐使用 `brew` 安装，这样就不用增加让 supervisor 本身服务化的操作。
### python2

### python3

```bash
# ubuntu
cp supervisord.service /lib/systemd/system
#cp supervisord.service /etc/systemd/system
systemctl enable supervisord.service
systemctl start supervisord.service
```

## mac
这里介绍两种方式，一种是用户级的，使用 `brew` 安装对应的软件，使用 `brew service` 来管理软件服务化；一种是系统级的，需要管理员权限，使用 `launchctl` 进行软件服务化。
### brew service
安装软件优先使用 `brew` 进行安装，对于可以充当服务的软件会在 `~/Library/LaunchAgents/homebrew.mxcl.xxx.plist` 文件，目前常用的
* supervisor  应用基本的程序服务化（开机自启）
* grafana 监控图表化（开机自启）
* filebeat 日志上传（开机自启）
* gitlab-runner CICD
* zookeeper/hbase/kafka  大数据工具
* redis/mysql/postgresql 本地开发数据库

以supervisor为例看一下对应的plist内容
```xml
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
  <dict>
    <key>KeepAlive</key>
    <dict>
      <key>SuccessfulExit</key>
      <false/>
    </dict>
    <key>Label</key>
    <string>homebrew.mxcl.supervisor</string>
    <key>ProgramArguments</key>
    <array>
      <string>/usr/local/opt/supervisor/bin/supervisord</string>
      <string>-c</string>
      <string>/usr/local/etc/supervisord.ini</string>
      <string>--nodaemon</string>
    </array>
  </dict>
</plist>
```

### launchctl





## linux

### sysctl 