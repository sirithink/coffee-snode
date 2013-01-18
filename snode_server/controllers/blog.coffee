# dao
dao = require '../models/BlogDao'

exports.get = (req, res) ->
    dao.findById req.params.id, (err, blog) ->
      dao.all (err, blogs) ->
        res.render 'blog', title: 'snode', blog: blog, blogs: blogs