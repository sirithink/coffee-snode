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
    callback err, reset results

###
Blog all
###
exports.all = (obj ,only, callback) ->
  Blog.find obj, only, (err, results) ->
    callback err, reset results
    
# reset object 
# format date
reset = (object) ->
  if object.constructor is Object
    for key of object
      object[key] = dateUtil.format object[key] if object[key] instanceof Date
    return object
  else if object.constructor is Array
    for obj in object
      for key of obj
        obj[key] = dateUtil.format obj[key] if obj[key] instanceof Date
    return object
  else return object
           
    