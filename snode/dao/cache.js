// Generated by CoffeeScript 1.6.2
var cache, config, dateUtil, db, dbCache, htmlFilter, log, logentries;

logentries = require('node-logentries');

cache = require('memory-cache');

db = require('./db').db;

config = require('../config');

dateUtil = require('../util/dateUtil');

htmlFilter = require('../util/htmlFilter');

log = logentries.logger(config.logToken);

exports.dbCache = dbCache = (function() {
  function dbCache() {}

  dbCache.get = function(key) {
    return cache.get(key);
  };

  dbCache.init = function() {
    var sqlBlogs, sqlSpots, _this;

    _this = this;
    sqlBlogs = "SELECT * FROM `blog` WHERE `del_status` = 0 ORDER BY `id` DESC";
    sqlSpots = "SELECT id,title,content FROM `blog` WHERE `del_status` = 0 ORDER BY `id` DESC LIMIT 0, 10";
    db.query(sqlBlogs, function(error, data) {
      var blog, blogs, _i, _len, _results;

      cache.put('count', data.length);
      blogs = _this.resetObj(data);
      cache.put('blogs', blogs);
      _results = [];
      for (_i = 0, _len = blogs.length; _i < _len; _i++) {
        blog = blogs[_i];
        blog.content = blog.content;
        _results.push(cache.put(blog.id, blog));
      }
      return _results;
    });
    db.query(sqlBlogs, function(error, data) {
      var blog, blogs, _i, _len;

      blogs = _this.resetObj(data);
      for (_i = 0, _len = blogs.length; _i < _len; _i++) {
        blog = blogs[_i];
        blog.content = htmlFilter.clean(blog.content);
      }
      return cache.put('blogsclean', blogs);
    });
    return db.query(sqlSpots, function(error, data) {
      return cache.put('spots', data);
    });
  };

  dbCache.reload = function() {
    cache.clear();
    return this.init();
  };

  dbCache.resetObj = function(object) {
    var key, obj, _i, _len;

    if (Array.isArray(object)) {
      for (_i = 0, _len = object.length; _i < _len; _i++) {
        obj = object[_i];
        for (key in obj) {
          if (obj[key] instanceof Date) {
            obj[key] = dateUtil.format(obj[key]);
          }
        }
      }
      return object;
    }
    if (object.constructor === Object) {
      for (key in object) {
        if (object[key] instanceof Date) {
          object[key] = dateUtil.format(object[key]);
        }
      }
      return object;
    } else {
      return object;
    }
  };

  return dbCache;

})();
