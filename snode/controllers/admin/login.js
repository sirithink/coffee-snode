// Generated by CoffeeScript 1.4.0
var codecUtil;

codecUtil = require("../../util/codecUtil");

exports.get = function(req, res) {
  return res.render('admin/signin', {
    title: 'Snode管理后台'
  });
};

exports.auth = function(req, res, next) {
  if (req.session.admin) {
    res.locals.admin = req.session.admin;
    console.log("has session!");
    return next();
  } else {
    return res.render('admin/signin', {
      title: 'Snode管理后台'
    });
  }
};

exports.post = function(req, res) {
  var admin, remember;
  admin = req.body.admin;
  remember = req.body.remember;
  console.log(remember);
  admin.password = codecUtil.md5Hex(admin.password);
  console.log(admin);
  req.session.admin = admin;
  res.locals.admin = admin;
  return res.render('admin/index', {
    title: 'Snode管理后台'
  });
};

exports.logout = function(req, res) {
  req.session.destroy();
  res.clearCookie('snode_admin', {
    path: '/'
  });
  return res.redirect('/');
};
