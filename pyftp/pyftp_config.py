ip = "0.0.0.0"
port = "21"

#最大上传速度
max_upload = 3000 * 1024
#最大下载速度
max_download = 3000 * 1024
#最大连接数
max_cons = 360
#最多IP连接数
max_pre_ip = 100
#被动连接端口
passive_ports = (2223, 2323)
#是否允许匿名访问
enable_anonymous = False

#是否打开日志记录
enable_logging = False

#日志名称
logging_name = r'pyftp.log'

#公网IP  只在内网使用，现已废弃
#masquerade_address = "0.0.0.0"

#显示欢迎标题
welcom_banner = r'Welcome to my ftp'

#默认的匿名用户路径
anyonmous_path = r'D:\temp'