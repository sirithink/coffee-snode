// Generated by CoffeeScript 1.6.2
var admin_name, admin_pwd, codecUtil, config, db, dbCache, log, logentries;

logentries = require('node-logentries');

codecUtil = require("../../util/codecUtil");

dbCache = require('../../dao/cache').dbCache;

config = require('../../config');

db = require('../../dao/db').db;

log = logentries.logger(config.logToken);

admin_name = process.env.ADMIN_NAME ? process.env.ADMIN_NAME : "596392912@qq.com";

admin_pwd = process.env.ADMIN_PWD ? process.env.ADMIN_PWD : "4297f44b13955235245b2497399d7a93";

/*
  跳转到后台登录
*/


exports.get = function(req, res) {
  return res.render('admin/signin', {
    title: 'Snode管理后台'
  });
};

/*
  登录校验
*/


exports.auth = function(req, res, next) {
  if (req.session.admin) {
    res.locals.admin = req.session.admin;
    log.debug("has session!");
    return next();
  } else {
    return res.render('admin/signin', {
      title: 'Snode管理后台'
    });
  }
};

/*
  登录
*/


exports.post = function(req, res) {
  var admin, remember;

  admin = req.body.admin;
  remember = req.body.remember;
  admin.password = codecUtil.md5Hex(admin.password);
  console.log("Admin:\t" + admin.email);
  log.log("debug", "Admin:\t" + admin.email);
  if (admin_name === admin.email && admin_pwd === admin.password) {
    req.session.admin = admin;
    res.locals.admin = admin;
    return res.redirect('admin/index');
  } else {
    return res.render('admin/signin', {
      title: 'Snode管理后台'
    });
  }
};

/*
  后台
*/


exports.index = function(req, res) {
  return db.findAll('blog', function(error, data) {
    log.info(error || data.length);
    return res.render('admin/index', {
      title: 'Snode管理后台',
      blogs: data
    });
  });
};

/*
  刷新cache
*/


exports.reloadCache = function(req, res) {
  dbCache.reload();
  return res.redirect('admin/index');
};

/*
  登出
*/


exports.logout = function(req, res) {
  log.info("Admin logout");
  req.session.destroy();
  res.clearCookie('snode_admin', {
    path: '/'
  });
  return res.redirect('/');
};
