logentries = require 'node-logentries'
dao = require '../../models/BlogDao'
config = require '../../config'

# log
log = logentries.logger config.logToken

exports.getAdd = (req, res) ->
    res.render 'admin/blog-add', title: 'snode写博'
    
exports.postAdd = (req, res) ->
    blog = req.body.blog
    console.log blog.title
    log.log "debug", blog.title
    dao.save blog, (err, results) ->
        log.log "debug", err if err
        res.render 'admin/blog-add', title: 'snode写博'

exports.getEdit = (req, res) ->
    dao.findOne id:req.params.id, (err, blog) ->
        log.log "debug", err if err
        res.render 'admin/blog-edit', title: 'snode博客编辑', blog: blog
    
exports.postEdit = (req, res) ->
    blog = req.body.blog
    console.log blog
    log.log "debug", blog
    dao.update blog, (err, results) ->
        dao.all {}, only: ['id','title', 'del_status'], order: ['-id'], (err, blogs) ->
            log.log "debug", err if err
            res.render 'admin/index', title: 'Snode管理后台', blogs: blogs
