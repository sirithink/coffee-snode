// Generated by CoffeeScript 1.4.0
var Blog, BlogTags, FastLegS, FastLegSBase, config, dateUtil, log, logentries, reset;

logentries = require('node-logentries');

FastLegSBase = require('FastLegS');

FastLegS = new FastLegSBase('mysql');

dateUtil = require('../util/dateUtil');

config = require('../config');

log = logentries.logger(config.logToken);

FastLegS.connect(config.db);

Blog = FastLegS.Base.extend({
  tableName: 'blog',
  primaryKey: 'id'
});

BlogTags = FastLegS.Base.extend({
  tableName: 'blog_tags',
  primaryKey: 'id'
});

/*
Blog create
*/


exports.save = function(obj, callback) {
  obj.user_id = 1;
  obj.create_time = dateUtil.time();
  obj.update_time = dateUtil.time();
  return Blog.create(obj, function(err, results) {
    if (err) {
      console.log(err);
    }
    if (err) {
      log.log("debug", err);
    }
    return callback(results);
  });
};

/*
Blog update
*/


exports.update = function(obj, callback) {
  obj.update_time = dateUtil.time();
  return Blog.update({
    id: obj.id
  }, obj, function(err, results) {
    if (err) {
      console.log(err);
    }
    if (err) {
      log.log("debug", err);
    }
    return callback(results);
  });
};

/*
Blog findById
*/


exports.findOne = function(obj, callback) {
  return Blog.findOne(obj, function(err, results) {
    if (err) {
      console.log(err);
    }
    if (err) {
      log.log("debug", err);
    }
    return callback(reset(results));
  });
};

/*
Blog all
*/


exports.all = function(obj, only, callback) {
  return Blog.find(obj, only, function(err, results) {
    if (err) {
      console.log(err);
    }
    if (err) {
      log.log("debug", err);
    }
    return callback(reset(results));
  });
};

exports.count = function(obj, callback) {
  return Blog.find(obj, {
    count: true
  }, function(err, results) {
    if (err) {
      console.log(err);
    }
    if (err) {
      log.log("debug", err);
    }
    return callback(results);
  });
};

reset = function(object) {
  var key, obj, _i, _len;
  if (object.constructor === Object) {
    for (key in object) {
      if (object[key] instanceof Date) {
        object[key] = dateUtil.format(object[key]);
      }
    }
    return object;
  } else if (object.constructor === Array) {
    for (_i = 0, _len = object.length; _i < _len; _i++) {
      obj = object[_i];
      for (key in obj) {
        if (obj[key] instanceof Date) {
          obj[key] = dateUtil.format(obj[key]);
        }
      }
    }
    return object;
  } else {
    return object;
  }
};
