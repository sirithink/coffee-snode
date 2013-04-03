logentries = require 'node-logentries'
config = require '../config'
# db cache
{dbCache} = require '../dao/cache'
# log
log = logentries.logger config.logToken

exports.get = (req, res) ->
  blog  = dbCache.get req.params.id
  blogs = dbCache.get 'blogs'
  if blog? and blogs?
      res.render 'blog', title: blog.title, blog: blog, spots: blogs
  else
      res.render 'error/404'