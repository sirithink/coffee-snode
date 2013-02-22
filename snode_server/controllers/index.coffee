logentries = require 'node-logentries'
mailUtil = require '../util/mailUtil'
codecUtil = require '../util/codecUtil'
config = require '../config'

# dao
dao = require '../models/BlogDao'
# log
log = logentries.logger config.logToken

# pageBean 
pageBean = (@page, count) ->
    size = 8
    @limit = if page >= 1 then page * size else size
    @offset = if page >= 1 then (page - 1) * size else 0
    @pageCount = Math.ceil count / size
    
# index
exports.get = (req, res) ->
    page = req.query.page
    if not page
        page = 1
    else if isNaN page
        res.render 'error/404'
    dao.counts {del_status: 0}, (count) ->
        pagebean = new pageBean parseInt(page), count
        dao.all {del_status: 0}, only: ['id','title','update_time'], offset: pagebean.offset, limit: pagebean.limit, order: ['-id'], (blogs) ->
            dao.all {del_status: 0}, only: ['id','title'], limit: 10, order: ['-id'], (spots) ->
                if blogs? and spots?
                    res.render 'index', title: 'snode', blogs: blogs, spots: spots, pagebean: pagebean
                else
                    res.render 'error/404'

# mail
exports.mailGet = (req, res) ->
    res.render 'mail', title: 'snode邮件发送'

# send mail
exports.mailPost = (req, res) ->
    email = req.body.email 
    user = 
        email    : email
        nick_name: email.substr 0, email.indexOf('@')
    code = codecUtil.md5Hex email
    mailUtil.sendSignup user, code
    res.redirect '/'