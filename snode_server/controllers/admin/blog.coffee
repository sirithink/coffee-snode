dao = require '../../models/BlogDao'

exports.getAdd = (req, res) ->
    res.render 'admin/blog-add', title: 'snode写博'
    
exports.postAdd = (req, res) ->
    blog = req.body.blog
    console.log blog
    dao.save blog, (err, results) ->
        res.render 'admin/blog-add', title: 'snode写博'

exports.getEdit = (req, res) ->
    res.render 'admin/blog-edit', title: 'snode博客编辑'
    
exports.postEdit = (req, res) ->
    blog = req.body.blog
    console.log blog
    dao.save blog, (err, results) ->
        res.render 'admin/blog-edit', title: 'snode博客编辑'
