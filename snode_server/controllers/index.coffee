logentries = require 'node-logentries'
dateUtil = require '../util/dateUtil'
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
        console.log err or blogs
        log.log "debug", err or blogs
        # format date
        for blog in blogs
            for b of blog
                blog[b] = dateUtil.format blog[b] if blog[b] instanceof Date
        res.render 'index', title: 'snode', blogs: blogs

exports.mailGet = (req, res) ->
    res.render 'mail', title: 'snode邮件发送'

# 发送邮件
exports.mailPost = (req, res) ->
    email = req.body.email 
    user = 
        email    : email
        nick_name: email.substr 0, email.indexOf('@')
    code = codecUtil.md5Hex email
    mailUtil.sendSignup user, code
    dao.all {del_status: 0}, only: ['id','title','update_time'], order: ['-id'], (err, blogs) ->
        console.log err or blogs
        log.log "debug", err or blogs
        # format date
        for blog in blogs
            for b of blog
                blog[b] = dateUtil.format blog[b] if blog[b] instanceof Date
        res.render 'index', title: 'snode', blogs: blogs