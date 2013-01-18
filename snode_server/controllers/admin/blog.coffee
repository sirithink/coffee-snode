dao = require '../../models/BlogDao'

exports.get = (req, res) ->
    res.render 'admin/blog-add', title: 'snode写博'
    
exports.post = (req, res) ->
    blog = req.body.blog
    console.log blog
    dao.save blog, (err, results) ->
        res.render 'admin/blog-add', title: 'snode写博'
