logentries = require 'node-logentries'
mailUtil = require '../util/mailUtil'
codecUtil = require '../util/codecUtil'
config = require '../config'

# dao
dao = require '../models/BlogDao'
# log
log = logentries.logger config.logToken

# index
exports.get = (req, res) ->
    dao.all {del_status: 0}, only: ['id','title','update_time'], order: ['-id'], (err, blogs) ->
        console.log err if err
        log.log "debug", err if err
        res.render 'index', title: 'snode', blogs: blogs

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
    dao.all {del_status: 0}, only: ['id','title','update_time'], order: ['-id'], (err, blogs) ->
        console.log err if err
        log.log "debug", err if err
        res.render 'index', title: 'snode', blogs: blogs