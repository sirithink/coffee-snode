logentries = require 'node-logentries'
{dbCache} = require '../../dao/cache'
{db} = require '../../dao/db'
config = require '../../config'

# log
log = logentries.logger config.logToken

exports.getAdd = (req, res) ->
  res.render 'admin/blog-add', title: 'snode写博'

exports.postAdd = (req, res) ->
  blog = req.body.blog
  blog.create_time = new Date()
  blog.update_time = new Date()
  blog.user_id = new Date()
  console.log "Add:\t#{blog.title}"
  log.log "debug", "Add:\t#{blog.title}"
  db.insert 'blog', blog, (error, data) ->
    dbCache.reload()
    res.render 'admin/blog-add', title: 'snode写博'

exports.getEdit = (req, res) ->
  blog = dbCache.get req.params.id
  res.render 'admin/blog-edit', title: 'snode博客编辑', blog: blog

exports.postEdit = (req, res) ->
  blog = req.body.blog
  blog.update_time = new Date()
  console.log "Updata:\t#{blog.title}"
  log.log "debug", "Updata:\t#{blog.title}"
  db.update 'blog', blog, {id: blog.id}, (error, data) ->
    dbCache.reload()
    res.redirect 'admin/index'