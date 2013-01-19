# dao
dao = require '../models/BlogDao'

exports.get = (req, res) ->
    dao.findOne id:req.params.id, del_status:0, (err, blog) ->
        dao.all {del_status: 0}, only: ['id','title'], order: ['-id'], (err, blogs) ->
            if typeof blog == 'undefined' or typeof blogs == 'undefined'
                res.render 'error/404'
            else    
              console.log blog
              console.log blogs
              res.render 'blog', title: 'snode', blog: blog, blogs: blogs