fs = require 'fs'
util = require 'util'
config = require '../config'

# 校验传图
exports.validator = (req, res, next) ->
    file_name = req.files.imgFile.name
    tmp_path = req.files.imgFile.path
    if !/(\S+)(.JPG|.jpg|.JPEG|.jpeg|.GIF|.gif|.BMP|.bmp|.PNG|.png)/.test file_name
        fs.unlink tmp_path, (err) ->
            console.log err if err
        res.json errors: 1, message: "亲，不支持这种格式的图片噢！"
    else
        next()

# kindeditor 图片上传
exports.editor = (req, res) ->
    tmp_path = req.files.imgFile.path
    file_name = req.files.imgFile.name
    img_name = new Date().getTime() + file_name.substr file_name.lastIndexOf('.'), file_name.length
    # 发送邮件里的图片地址 必须为全路径
    img_path = config.domain + '/uploads/' + img_name
    console.log img_path
    target_path = './public/uploads/' + img_name

    readStream = fs.createReadStream tmp_path
    writeStream = fs.createWriteStream target_path
    
    # 移动文件
    util.pump readStream, writeStream, ->
        fs.unlinkSync tmp_path
        
    res.json error: 0, url:img_path