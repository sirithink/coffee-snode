# dao
dao = require '../models/BlogDao'

exports.get = (req, res) ->
    dao.findById req.params.id, (err, blog) ->
        dao.all {del_status: 0}, only: ['id','title'], order: ['-id'], (err, blogs) ->
            res.render 'blog', title: 'snode', blog: blog, blogs: blogs