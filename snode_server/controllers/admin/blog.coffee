dao = require '../../models/BlogDao'

exports.getAdd = (req, res) ->
    res.render 'admin/blog-add', title: 'snode写博'
    
exports.postAdd = (req, res) ->
    blog = req.body.blog
    console.log blog
    dao.save blog, (err, results) ->
        res.render 'admin/blog-add', title: 'snode写博'

exports.getEdit = (req, res) ->
    dao.findOne id:req.params.id, (err, blog) ->
        res.render 'admin/blog-edit', title: 'snode博客编辑', blog: blog
    
exports.postEdit = (req, res) ->
    blog = req.body.blog
    console.log blog
    dao.update blog, (err, results) ->
        dao.all {}, only: ['id','title', 'del_status'], order: ['id'], (err, blogs) ->
            res.render 'admin/index', title: 'Snode管理后台', blogs: blogs
