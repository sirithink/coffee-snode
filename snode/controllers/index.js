// Generated by CoffeeScript 1.4.0
var dao, dateUtil, mailUtil;

dateUtil = require('../util/dateUtil');

mailUtil = require('../util/mailUtil');

dao = require('../models/BlogDao');

exports.get = function(req, res) {
  var df;
  df = dateUtil.time();
  console.log("time:\t" + df);
  return dao.all(function(err, results) {
    console.log(err || results);
    return res.render('index', {
      title: 'snode',
      blogs: results
    });
  });
};

exports.mail = function(req, res) {
  var code, user;
  user = {
    email: "596392912@qq.com",
    nick_name: "春梦"
  };
  code = "123123";
  mailUtil.sendSignup(user, code);
  return res.render('index', {
    name: 'snode'
  });
};
