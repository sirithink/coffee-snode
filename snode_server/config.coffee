# appfog 环境
cloudPort = process.env.VCAP_APP_PORT
cloudServices = process.env.VCAP_SERVICES
# 端口
exports.port = cloudPort || 3000
# url供socket.io使用
exports.domain = if cloudPort then 'http://snode.hp.af.cm' else 'http://localhost:3000'
# 数据库url
if cloudServices
    env = JSON.parse process.env.VCAP_SERVICES
    exports.db = env['mysql-5.1'][0]['credentials']
else
    exports.db =
        url:      "localhost"
        port:     "3306"
        database: "snode"
        user:     "root"
        password: "root"
        
# secret
exports.secret = "snode"
# maxAge a month
exports.maxAge = 1000 * 60 * 60 * 24 * 31
# email 配置
exports.email = 
    user:     "q596392912"
    password: "6693722"
    host:     "smtp.126.com"
    ssl:      true
# rss 配置
exports.rss =
    title:        'Snode：Node.js博客'
    link:         'http://snode.hp.af.cm/'
    language:     'zh-cn'
    description:  'Snode：Node.js博客'
    author:       'admin'
    # 最多获取的RSS Item数量
    max_items: 20
# logentries log token api https://logentries.com/doc/appfog/
exports.logToken =
    token: process.env.LOGENTRIES_TOKEN