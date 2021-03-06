logentries = require 'node-logentries'
mailUtil = require '../util/mailUtil'
codecUtil = require '../util/codecUtil'
config = require '../config'

# db cache
{dbCache} = require '../dao/cache'
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
  count = dbCache.get 'count'
  pagebean = new pageBean parseInt(page), count
  blogs = dbCache.get('blogs')[pagebean.offset...pagebean.limit]
  # 8条 分页
  spots = dbCache.get 'spots'
  # 10 条最新
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
    email: email
    nick_name: email.substr 0, email.indexOf('@')
  code = codecUtil.md5Hex email
  mailUtil.sendSignup user, code
  res.redirect '/'