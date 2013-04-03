logentries = require 'node-logentries'
codecUtil = require "../../util/codecUtil"
{dbCache} = require '../../dao/cache'
config = require '../../config'

# log
log = logentries.logger config.logToken

# admin user
admin_name = if process.env.ADMIN_NAME then process.env.ADMIN_NAME else "596392912@qq.com"
admin_pwd = if process.env.ADMIN_PWD then process.env.ADMIN_PWD else "4297f44b13955235245b2497399d7a93"

exports.get = (req, res) ->
    res.render 'admin/signin', title: 'Snode管理后台'
    
exports.auth = (req, res, next) ->
    if req.session.admin
        res.locals.admin = req.session.admin;
        console.log("has session!");
        log.debug "has session!"
        next();
    else
        res.render 'admin/signin', title: 'Snode管理后台'
        
exports.post = (req, res) ->
    admin = req.body.admin
    remember = req.body.remember
    # remember没去做 可以去参看 snode-test
    # url:https://github.com/ChunMengLu/node_mysql_test
    admin.password = codecUtil.md5Hex admin.password
    console.log "Admin:\t#{admin.email}"
    log.log "debug", "Admin:\t#{admin.email}"
    if admin_name is admin.email and admin_pwd is admin.password
        req.session.admin = admin
        res.locals.admin = admin
        res.redirect 'admin/index'
    else
        res.render 'admin/signin', title: 'Snode管理后台'
    
exports.index = (req, res) ->
    blogs = dbCache.get 'blogs'
    res.render 'admin/index', title: 'Snode管理后台', blogs: blogs
    
exports.logout = (req, res) ->
    log.info("Admin logout")
    req.session.destroy();
    res.clearCookie 'snode_admin', path: '/' 
    res.redirect '/'