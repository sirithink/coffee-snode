logentries = require 'node-logentries'
config = require '../config'
# dao
dao = require '../models/BlogDao'
# log
log = logentries.logger config.logToken

exports.get = (req, res) ->
    dao.findOne id:req.params.id, del_status:0, (err, blog) ->
        dao.all {del_status: 0}, only: ['id','title'], order: ['id'], (err, blogs) ->
            console.log err or blogs
            log.log "debug", err or blogs
            if typeof blog == 'undefined' or typeof blogs == 'undefined'
                res.render 'error/404'
            else    
              res.render 'blog', title: 'snode', blog: blog, blogs: blogs