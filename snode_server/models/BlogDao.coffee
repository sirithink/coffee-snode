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
    callback err, results

###
Blog update
###
exports.update = (obj, callback) ->
  obj.update_time = dateUtil.time()
  Blog.update {id: obj.id}, obj, (err, results) ->
    callback err, results 
 
###
Blog findById
###
exports.findOne = (obj, callback) ->
  Blog.findOne obj, (err, results) ->
    console.log results
    callback err, results

###
Blog all
###
exports.all = (obj ,only, callback) ->
  Blog.find obj, only, (err, results) ->
    console.log results
    callback err, results
    
    