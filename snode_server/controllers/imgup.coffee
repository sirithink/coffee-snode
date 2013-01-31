logentries = require 'node-logentries'
cloudinary = require 'cloudinary'
fs = require 'fs'
util = require 'util'
config = require '../config'

# log
log = logentries.logger config.logToken

# 校验传图
exports.validator = (req, res, next) ->
    file_name = req.files.imgFile.name
    tmp_path = req.files.imgFile.path
    if !/(\S+)(.JPG|.jpg|.JPEG|.jpeg|.GIF|.gif|.BMP|.bmp|.PNG|.png)/.test file_name
        fs.unlink tmp_path, (err) ->
            console.log err if err
            log.log "debug", err if err
        res.json errors: 1, message: "亲，不支持这种格式的图片噢！"
    else
        next()
        
# Cloudinary 图片上传
exports.editor = (req, res) ->
    tmp_path = req.files.imgFile.path
    img_name = new Date().getTime()
    # Cloudinary api
    stream = cloudinary.uploader.upload_stream (result) ->
        console.log result.url
        log.log "debug", result.url
        # del local img
        fs.unlink tmp_path, (err) ->
            console.log err if err
            log.log "debug", err if err
        res.json error: 0, url:result.url    
    , public_id: img_name 
    fs.createReadStream(tmp_path, 
        encoding: 'binary').on('data', stream.write).on('end', stream.end)
        
    