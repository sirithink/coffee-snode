codecUtil = require "../../util/codecUtil"
dateUtil = require '../../util/dateUtil'
dao = require '../../models/BlogDao'

exports.get = (req, res) ->
    res.render 'admin/signin', title: 'Snode管理后台'
    
exports.auth = (req, res, next) ->
    if req.session.admin
        res.locals.admin = req.session.admin;
        console.log("has session!");
        next();
    else
        res.render 'admin/signin', title: 'Snode管理后台'
        
exports.post = (req, res) ->
    admin = req.body.admin
    remember = req.body.remember
    console.log remember

    admin.password = codecUtil.md5Hex admin.password
    console.log admin
    req.session.admin = admin
    res.locals.admin = admin
    dao.all {}, only: ['id','title', 'del_status'], order: ['-id'], (err, blogs) ->
        res.render 'admin/index', title: 'Snode管理后台', blogs: blogs
    
exports.index = (req, res) ->
    dao.all {}, only: ['id','title', 'del_status'], order: ['-id'], (err, blogs) ->
        res.render 'admin/index', title: 'Snode管理后台', blogs: blogs
    
exports.logout = (req, res) ->
    req.session.destroy();
    res.clearCookie 'snode_admin', path: '/' 
    res.redirect '/'