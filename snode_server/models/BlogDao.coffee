FastLegSBase = require 'FastLegS'
FastLegS = new FastLegSBase 'mysql'

config = require '../config'
# connect db
FastLegS.connect config.db

# Blog
Blog = FastLegS.Base.extend
  tableName: 'blog'
  primaryKey: 'id'
  
# BlogTags
BlogTags = FastLegS.Base.extend
  tableName: 'blog_tags'
  primaryKey: 'id'
  
###
Blog findById
###
exports.findById = (id, callback) ->
  Blog.find id, (err, results) ->
    callback err, results
    
    