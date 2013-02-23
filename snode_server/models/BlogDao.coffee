logentries = require 'node-logentries'
FastLegSBase = require 'FastLegS'
FastLegS = new FastLegSBase 'mysql'

dateUtil = require '../util/dateUtil'
config = require '../config'
# log
log = logentries.logger config.logToken
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
    console.log err if err
    log.log "debug", err if err
    if results
      callback reset results
    else
      callback null

###
Blog update
###
exports.update = (obj, callback) ->
  obj.update_time = dateUtil.time()
  Blog.update {id: obj.id}, obj, (err, results) ->
    console.log err if err
    log.log "debug", err if err
    if results
      callback reset results
    else
      callback null 
 
###
Blog findById
###
exports.findOne = (obj, callback) ->
  Blog.findOne obj, (err, results) ->
    console.log err if err
    log.log "debug", err if err
    if results
      callback reset results
    else
      callback null

###
Blog all
###
exports.all = (obj ,only, callback) ->
  Blog.find obj, only, (err, results) ->
    console.log err if err
    log.log "debug", err if err
    if results?
      callback reset results
    else
      callback null
    
# count #{del_status: 0}
exports.counts = (obj, callback) ->
  Blog.find obj, {count: true}, (err, results) ->
    console.log err or results
    log.log "debug", err or results
    callback results.count
    
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
           
    