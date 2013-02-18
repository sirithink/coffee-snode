###
 加密 工具
 @type {*}
###
crypto = require 'crypto'

# md5
exports.md5Hex = (str) ->
    md5 = crypto.createHash 'md5'
    md5.update str, 'utf8'
    md5.digest 'hex'
    
# aes
exports.aesEncrypt = (str,secret) ->
    cipher = crypto.createCipher 'aes192', secret
    enc = cipher.update str,'utf8','hex'
    enc += cipher.final 'hex'

# aes
exports.aesDecrypt = (str,secret) ->
    decipher = crypto.createDecipher 'aes192', secret
    dec = decipher.update str,'hex','utf8'
    dec += decipher.final 'utf8'
