FastLegSBase = require 'FastLegS'
FastLegS = new FastLegSBase 'mysql'

dateUtil = require '../util/dateUtil'
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
Blog create
###
exports.save = (obj, callback) ->
  obj.user_id = 1
  obj.create_time = dateUtil.time()
  obj.update_time = dateUtil.time()
  Blog.create obj, (err, results) ->
    console.log err or results
    callback err, results
  
  
###
Blog findById
###
exports.findById = (id, callback) ->
  Blog.find id, (err, results) ->
    callback err, results
    
    