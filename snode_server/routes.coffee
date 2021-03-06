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
  # home page
  app.get '/', index.get

  # fm
  app.get '/playlist', fm.list
  app.get '/playmusic', fm.music

  # rss
  app.get '/rss', rss.get
  app.get '/json', rss.json

  # mail
  app.get '/mail', index.mailGet
  app.post '/mail', index.mailPost

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
  app.get '/admin/reload', adminLogin.reloadCache
  app.get '/admin/blog/add', adminBlog.getAdd
  app.post '/admin/blog/add', adminBlog.postAdd
  app.get '/admin/blog/edit/:id', adminBlog.getEdit
  app.post '/admin/blog/edit', adminBlog.postEdit

  ###
  page note Found
  ###
  app.all '*', (req, res) ->
      res.render 'error/404'