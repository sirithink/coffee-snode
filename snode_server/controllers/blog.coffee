logentries = require 'node-logentries'
config = require '../config'
# dao
dao = require '../models/BlogDao'
# log
log = logentries.logger config.logToken

exports.get = (req, res) ->
    dao.findOne id:req.params.id, del_status:0, (blog) ->
        dao.all {del_status: 0}, only: ['id','title'], limit: 10, order: ['-id'], (blogs) ->
            if blog? and blogs?
                res.render 'blog', title: blog.title, blog: blog, spots: blogs
            else    
                res.render 'error/404'