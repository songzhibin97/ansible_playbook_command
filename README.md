# ansible_playbook_command
about ansible command
### 结构简介
```shell
	
- SElinux_config.yml # 一键关闭内置防火墙
	
- IPtables_config.yml # 一键关闭IPtable防火墙
	
- yum_config.yml # 一键下载wget并且清空本地yum仓且去阿里镜像下载yum仓以及epel源且执行清空缓存生成新的缓存

- download_python3.yml # 一键使用编译安装python3 Ps:需要/etc/profile文件中 无PATH=环境变量 否则有可能无法正常添加环境变量

- download_virtualenv.yml # 一键安装虚拟环境以及虚拟环境管理工具 Ps:需要在一键安装完成python的前提下重新登录确保环境变量生效 或者自己安装完成且环境变量生效的前提下使用

- download_mariadb.yml # 一键下载mariadb(mysql分支) Ps:需要自己初始化 执行: mysql_secure_installation

- download_redis.yml # 一键编译下载redis Ps:启动端口 9763
	
- download_Nginx.yml # 一键下载编译Nginx Ps:需要先关闭IPtable以及SElinux
	
- roles # 角色目录

	- SElinux_config # 执行SElinux_config.yml中详细内容
		- files # 存放copy不需要传参的文件
			- config # 需要替换SElinux的配置文件
		- handlers # 存放需要被触发才执行的任务
		- tasks # 主任务文件
			- permissive.yml # 将系统临内置防火墙临时关闭
			- copy_config.yml # 修改配置文件,永久更改内置防火墙关闭
			- main.yml # 导入以上两个模块
		- template # 存放template需要传参的文件
		- vars # 存放变量

		
	- IPtables_config
		- files # 存放copy不需要传参的文件
		- handlers # 存放需要被触发才执行的任务
		- tasks # 主任务文件
			- close_iptable.yml # 关闭IPtable
			- main.yml # 导入以上一个模块
		- template # 存放template需要传参的文件
		- vars # 存放变量

		
	- yum_config
		- files # 存放copy不需要传参的文件
		- handlers # 存放需要被触发才执行的任务
		- tasks # 主任务文件
			- download_wget.yml # 下载wget
			- remove_local_yum.yml # 删除本地yum仓
			- download_yum.yml # 从阿里镜像下载yum源
			- download_yum_epel.yml # 从阿里镜像下载epel源
			- clear_yum_cache.yml # 清除yum缓存
			- make_yum_cache.yml # 生成新的yum缓存
			- main.yml # 导入以上七个模块
		- template # 存放template需要传参的文件
		- vars # 存放变量

	
	- download_python3
		- files # 存放copy不需要传参的文件
			- pip.conf # 放置pip源配置文件
		- handlers # 存放需要被触发才执行的任务
			- main.yml # 用于触发环境变量修改后重读profile文件
			
		- tasks # 主任务文件
			- yum_other_pack.yml # 安装相关包
			- download_python3.yml # 在/etc/opt下载源码包
			- decompression_python3.yml # 解压刚下载的源码包
			- choice_install_path.yml # 选择安装地点
			- compilation.yml # 编译
			- installation.yml # 安装
			- add_variate.yml # 添加环境变量并触发handlers任务激活 重新读取/etc/profile文件 Ps:需要/etc/profile中 无 PATH 行
			- mkdir_pip_conf.yml # 创建本地pip源文件存放文件夹
			- copy_pip_conf.yml # 复制配置文件到目标地点
			- update_pip3.yml # 升级pip到最新版本
			- logout.yml # 当前用户退出登录
			- main.yml # 导入以上十一个模块
		- template # 存放template需要传参的文件
		- vars # 存放变量
	
	
	- download_virtualenv
		- files # 存放copy不需要传参的文件
			- .bashrc # 存放virtualenv的配置文件
		- handlers # 存放需要被触发才执行的任务
			- main.yml # append_conf.yml触发任务
		- tasks # 主任务文件
			- pip_install_virtualenv.yml # 使用pip下载virtualenv
			- pip_install_virtualenvwrapper.yml # 使用pip下载virtualenvwrapper
			- copy_conf.yml # 复制配置文件到~/.bashrc文件中
			- main.yml # 导入以上三个模块
		- template # 存放temp
	
	
	- download_mariadb
		- files # 存放copy不需要传参的文件
			- MariaDB.repo # 存放yum仓配置文件
			- my.cnf # 存放mariadb的配置文件
		- handlers # 存放需要被触发才执行的任务
		- tasks # 主任务文件
			- copy_repo_warehouse.yml # copy mariadb yum仓
			- yum_mariadb.yml # 使用yum 安装MariaDB
			- copy_mariadb_conf.yml # copy mariadb 配置文件
			- strat_mariadb.yml # 启动mariadb并设置开机自启
			- main.yml # 导入以上四个模块
		- template # 存放temp

	
	- download_redis
		- files # 存放copy不需要传参的文件
			- redis.conf # 存放redis的配置文件
		- handlers # 存放需要被触发才执行的任务
		- tasks # 主任务文件
			- yum_other_pack.yml # 下载相关依赖包
			- download_redis.yml # 在/etc/opt下载源码包
			- decompression_redis.yml	# 解压刚下载的源码包
			- compilation.yml # 编译
			- installation.yml # 安装
			- copy_redis_conf.yml # 复制启动redis配置文件
			- start_redis.yml # 指定文件启动redis
			- main.yml # 导入以上七个模块
		- template # 存放temp


	- download_Nginx
		- files # 存放copy不需要传参的文件
			- redis.conf # 存放redis的配置文件
		- handlers # 存放需要被触发才执行的任务
		- tasks # 主任务文件
			- yum_other_pack.yml # 下载相关依赖包
			- download_nginx.yml # 在/etc/opt下载源码包
			- decompression_nginx.yml	# 解压刚下载的源码包
			- choice_install_path.yml # 选择安装地点并且开启nginx监控功能
			- compilation.yml # 编译
			- installation.yml # 安装
			- start_niginx.yml # 启动Nginx
			- main.yml # 导入以上七个模块
		- template # 存放temp

```
### 使用方法
```
yum install ansible # 在epel源中 需要在下载阿里镜像装载epel yum仓
添加控制主机Ip # /etc/ansible/hosts
将上述架构文件 download ~/
需要修改roles同级的.yml文件
	- hosts: [local_host] # 将[local_host] 改为自己设置的ip组或者ip

ansible-playbook xxx.yml 即可
	

		
	
