// Generated by CoffeeScript 1.6.1
var cloudinary, config, fs, log, logentries, util;

logentries = require('node-logentries');

cloudinary = require('cloudinary');

fs = require('fs');

util = require('util');

config = require('../config');

log = logentries.logger(config.logToken);

exports.validator = function(req, res, next) {
  var file_name, tmp_path;
  file_name = req.files.imgFile.name;
  tmp_path = req.files.imgFile.path;
  if (!/(\S+)(.JPG|.jpg|.JPEG|.jpeg|.GIF|.gif|.BMP|.bmp|.PNG|.png)/.test(file_name)) {
    fs.unlink(tmp_path, function(err) {
      if (err) {
        console.log(err);
      }
      if (err) {
        return log.log("debug", err);
      }
    });
    return res.json({
      errors: 1,
      message: "亲，不支持这种格式的图片噢！"
    });
  } else {
    return next();
  }
};

exports.editor = function(req, res) {
  var img_name, stream, tmp_path;
  tmp_path = req.files.imgFile.path;
  img_name = new Date().getTime();
  stream = cloudinary.uploader.upload_stream(function(result) {
    console.log(result.url);
    log.log("debug", result.url);
    fs.unlink(tmp_path, function(err) {
      if (err) {
        console.log(err);
      }
      if (err) {
        return log.log("debug", err);
      }
    });
    return res.json({
      error: 0,
      url: result.url
    });
  }, {
    public_id: img_name
  });
  return fs.createReadStream(tmp_path, {
    encoding: 'binary'
  }).on('data', stream.write).on('end', stream.end);
};
