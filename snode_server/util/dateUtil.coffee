###
 时间对象的格式化#
 扩展 format 方法
###
Date.prototype.format = (format) ->
    # eg:format="yyyy-MM-dd hh:mm:ss"#
    o = 
        "M+" : @getMonth() + 1 # month
        "d+" : @getDate() # day
        "h+" : @getHours() # hour
        "m+" : @getMinutes() # minute
        "s+" : @getSeconds() # second
        "q+" : Math.floor((@getMonth() + 3) / 3) # quarter
        "S"  : @getMilliseconds()  # millisecond

    if /(y+)/.test format
        format = format.replace RegExp.$1, (@getFullYear() + "").substr 4 - RegExp.$1.length

    for k of o
       if new RegExp("(" + k + ")").test format
            format = format.replace RegExp.$1, 
              if RegExp.$1.length is 1 then o[k] else ("00" + o[k]).substr ("" + o[k]).length
    format

###
 时间格式化
 yyyy-MM-dd hh:mm:ss
 @return {*}
###
exports.time = ->
    new Date().format("yyyy-MM-dd hh:mm:ss")