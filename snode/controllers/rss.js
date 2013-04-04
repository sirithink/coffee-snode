// Generated by CoffeeScript 1.6.2
var config, data2xml, dbCache, log, logentries;

logentries = require('node-logentries');

data2xml = require('data2xml')();

config = require('../config');

dbCache = require('../dao/cache').dbCache;

log = logentries.logger(config.logToken);

exports.get = function(req, res) {
  var blogs, key, rss_content, rss_obj, value;

  rss_obj = {
    _attr: {
      version: '2.0'
    },
    channel: {
      title: config.rss.title,
      link: config.rss.link,
      language: config.rss.language,
      description: config.rss.description,
      item: []
    }
  };
  blogs = dbCache.get('blogs');
  for (key in blogs) {
    value = blogs[key];
    rss_obj.channel.item.push({
      title: value.title,
      link: config.rss.link + 'blog/' + value.id,
      guid: config.rss.link + 'blog/' + value.id,
      description: value.content,
      author: config.rss.author,
      pubDate: value.update_time
    });
  }
  rss_content = data2xml('rss', rss_obj);
  res.contentType('application/xml');
  return res.send(rss_content);
};

exports.json = function(req, res) {
  var blogs;

  blogs = dbCache.get('blogs');
  return res.jsonp(blogs);
};
