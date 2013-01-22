index = require './controllers/index'
upload = require './controllers/upload'
blog = require './controllers/blog'
rss = require './controllers/rss'
###
signup = require './controllers/signup'
login = require './controllers/login'
user = require './controllers/user'
file = require './controllers/file'
mail = require './controllers/mail'
socket = require './controllers/socket.io'
blog = require './controllers/blog'
demo = require './controllers/demo'
xml = require './controllers/xmlTest'
admin = require './controllers/admin'
###

###
  admin
###
adminLogin = require './controllers/admin/login'
adminBlog = require './controllers/admin/blog'

module.exports = (app) ->
    # 配置session 页面中使用 user 获取
    # app.all '*', index.auth
    # home page
    app.get '/', index.get
    
    # mail
    app.get '/mail', index.mailGet
    app.post '/mail', index.mailPost
    
    # rss
    app.get '/rss', rss.get
    
    ###
    editor图片上传
    ###
    app.post '/upload/editor', upload.validator, upload.editor
    
    ###
    blog 
    ###
    app.get('/blog/:id', blog.get);
    
    ###
    admin
    ###
    app.get '/admin', adminLogin.get
    app.get '/admin/logout', adminLogin.logout
    app.post '/admin/session', adminLogin.post
    app.all '/admin/*', adminLogin.auth
    app.all '/admin/index', adminLogin.index
    app.get '/admin/blog/add', adminBlog.getAdd
    app.post '/admin/blog/add', adminBlog.postAdd
    app.get '/admin/blog/edit/:id', adminBlog.getEdit
    app.post '/admin/blog/edit', adminBlog.postEdit
    # app.get '/admin/blog/del/:id', adminBlog.getDel
    # app.post '/admin/blog/del', adminBlog.postDel
    
    ###
    page note Found
    ###
    app.get '*', (req, res, next) ->
        if /.*\.(gif|jpg|jpeg|png|bmp|js|css|html).*$/.test req.originalUrl
            next()
        else  
            res.render 'error/404'
            
###
    # 注册
    app.get '/signup', signup.get
    app.post '/signup', signup.validator, signup.post
    app.get '/finish', signup.finish

    # 登陆
    app.get '/login', login.get
    app.post '/login', login.validator, login.post
    # 登出
    app.get '/logout', login.logout

    # user
    app.get '/users', user.list

    # blog 相关
    app.get "/blog", blog.get
    app.get "/blog", blog.get

    app.get "/demo", demo.get

    # 上传相关
    app.get '/upload', file.get
    app.post '/upload', file.post
    app.post '/upload/editor', file.validator, file.editor

    # 邮件相关
    app.get '/mail', mail.get
    app.post '/mail', mail.post

    # xml test
    app.get "/xml", xml.get

    # test
    app.get "/test", xml.test
    app.get "/jadetest", xml.jadetest

    # socket.io chat room
    app.get '/socket', socket.index

    # admin
    app.get '/admin', admin.get
    app.all '/admin/*', admin.auth
    app.post '/admin/session', admin.post
###