// Generated by CoffeeScript 1.6.1
var codecUtil, config, dao, log, logentries, mailUtil, pageBean;

logentries = require('node-logentries');

mailUtil = require('../util/mailUtil');

codecUtil = require('../util/codecUtil');

config = require('../config');

dao = require('../models/BlogDao');

log = logentries.logger(config.logToken);

pageBean = function(page, count) {
  var size;
  this.page = page;
  size = 8;
  this.limit = page >= 1 ? page * size : size;
  this.offset = page >= 1 ? (page - 1) * size : 0;
  return this.pageCount = Math.ceil(count / size);
};

exports.get = function(req, res) {
  var page;
  page = req.query.page;
  if (!page) {
    page = 1;
  } else if (isNaN(page)) {
    res.render('error/404');
  }
  return dao.counts({
    del_status: 0
  }, function(count) {
    var pagebean;
    pagebean = new pageBean(parseInt(page), count);
    return dao.all({
      del_status: 0
    }, {
      only: ['id', 'title', 'update_time'],
      offset: pagebean.offset,
      limit: pagebean.limit,
      order: ['-id']
    }, function(blogs) {
      return dao.all({
        del_status: 0
      }, {
        only: ['id', 'title'],
        limit: 10,
        order: ['-id']
      }, function(spots) {
        if ((blogs != null) && (spots != null)) {
          return res.render('index', {
            title: 'snode',
            blogs: blogs,
            spots: spots,
            pagebean: pagebean
          });
        } else {
          return res.render('error/404');
        }
      });
    });
  });
};

exports.mailGet = function(req, res) {
  return res.render('mail', {
    title: 'snode邮件发送'
  });
};

exports.mailPost = function(req, res) {
  var code, email, user;
  email = req.body.email;
  user = {
    email: email,
    nick_name: email.substr(0, email.indexOf('@'))
  };
  code = codecUtil.md5Hex(email);
  mailUtil.sendSignup(user, code);
  return res.redirect('/');
};
