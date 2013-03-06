index = require './controllers/index'
upload = require './controllers/upload'
imgup = require './controllers/imgup'
blog = require './controllers/blog'
rss = require './controllers/rss'
fm = require './controllers/fm'

###
  admin
###
adminLogin = require './controllers/admin/login'
adminBlog = require './controllers/admin/blog'

module.exports = (app) ->
    # 配置session 页面中使用 user 获取
    # app.all '*', index.auth
    # 对域名的处理
    app.get '*', (req, res, next) ->
        if (req.subdomains).length is 0
            
            req.redirect "#{req.protocol}://www.#{req.originalUrl}" 

    # home page
    app.get '/', index.get
    
    # fm
    app.get '/playlist', fm.list
    app.get '/playmusic', fm.music
    
    # mail
    app.get '/mail', index.mailGet
    app.post '/mail', index.mailPost
    
    # rss
    app.get '/rss', rss.get
    
    # editor图片上传
    # app.post '/upload/editor', upload.validator, upload.editor

    # Cloudinary 图片上传
    app.post '/upload/editor', imgup.validator, imgup.editor
    
    ###
    blog 
    ###
    app.get '/blog/:id', blog.get
    
    ###
    admin
    ###
    app.get '/admin', adminLogin.get
    app.get '/admin/logout', adminLogin.logout
    app.post '/admin/session', adminLogin.post
    app.all '/admin/*', adminLogin.auth
    app.get '/admin/index', adminLogin.index
    app.get '/admin/blog/add', adminBlog.getAdd
    app.post '/admin/blog/add', adminBlog.postAdd
    app.get '/admin/blog/edit/:id', adminBlog.getEdit
    app.post '/admin/blog/edit', adminBlog.postEdit
    
    ###
    page note Found
    ###
    app.get '*', (req, res, next) ->
        if /.*\.(gif|jpg|jpeg|png|bmp|js|css|html).*$/.test req.originalUrl
            next()
        else  
            res.render 'error/404'
