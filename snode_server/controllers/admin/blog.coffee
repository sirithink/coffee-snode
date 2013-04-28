dateUtil = require '../../util/dateUtil'
logentries = require 'node-logentries'
{dbCache} = require '../../dao/cache'
{db} = require '../../dao/db'
config = require '../../config'

# log
log = logentries.logger config.logToken

###
  跳转到写博
###
exports.getAdd = (req, res) ->
  res.render 'admin/blog-add', title: 'snode写博'

###
  保存文章
###
exports.postAdd = (req, res) ->
  blog = req.body.blog
  blog.create_time = dateUtil.time()
  blog.update_time = dateUtil.time()
  blog.user_id = 1
  console.log "Add:\t#{blog.title}"
  log.log "debug", "Add:\t#{blog.title}"
  db.insert 'blog', blog, (error, data) ->
    log.info error or data
    dbCache.reload()
    res.render 'admin/blog-add', title: 'snode写博'

###
  跳转到编辑
###
exports.getEdit = (req, res) ->
  db.findById 'blog', req.params.id, (error, data) ->
    log.info error if error
    res.render 'admin/blog-edit', title: 'snode博客编辑', blog: data[0]

###
  跟新文章
###
exports.postEdit = (req, res) ->
  blog = req.body.blog
  blog.update_time = dateUtil.time()
  console.log "Updata:\t#{blog.title}\ttime:#{blog.update_time}"
  log.log "debug", "Updata:\t#{blog.title}"
  db.update 'blog', blog, {id: blog.id}, (error, data) ->
    log.info error or data
    dbCache.reload()
    res.redirect 'admin/index'