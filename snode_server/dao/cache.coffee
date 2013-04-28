logentries = require 'node-logentries'
cache = require 'memory-cache'
{db} = require './db'

config = require '../config'
dateUtil = require '../util/dateUtil'
htmlFilter = require '../util/htmlFilter'
# log
log = logentries.logger config.logToken

exports.dbCache = class dbCache
  @get: (key) ->          # get cache
    cache.get key
  @init: ->
    _this = @
    sqlBlogs = "SELECT * FROM `blog` WHERE `del_status` = 0 ORDER BY `id` DESC"
    sqlSpots = "SELECT id,title,content FROM `blog` WHERE `del_status` = 0 ORDER BY `id` DESC LIMIT 0, 10"
    db.query sqlBlogs, (error, data) ->
      cache.put 'count', data.length
      blogs = _this.resetObj(data)
      cache.put 'blogs', blogs
      for blog in blogs
        blog.content = blog.content
        cache.put blog.id, blog
    db.query sqlBlogs, (error, data) ->
      blogs = _this.resetObj(data)
      for blog in blogs
        blog.content = htmlFilter.clean blog.content
      cache.put 'blogsclean', blogs
    db.query sqlSpots, (error, data) ->
      cache.put 'spots', data
  @reload: ->             # reload cache
    cache.clear()
    @init()
  @resetObj: (object)->   # reset date
    if Array.isArray(object)
      for obj in object
        for key of obj
          obj[key] = dateUtil.format obj[key] if obj[key] instanceof Date
      return object
    if object.constructor is Object
      for key of object
        object[key] = dateUtil.format object[key] if object[key] instanceof Date
      return object
    else return object