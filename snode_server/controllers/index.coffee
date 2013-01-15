dateUtil = require '../util/dateUtil'
mailUtil = require '../util/mailUtil' 
dao = require '../models/DBDao'
# index
exports.get = (req, res) ->
    df = dateUtil.time()
    console.log "time:\t#{df}"
    dao.all()
    res.render 'index', title: 'snode'

exports.mail = (req, res) ->
    user = 
      email    : "596392912@qq.com"
      nick_name: "春梦"
    code = "123123"
    mailUtil.sendSignup user, code
    res.render 'index', name: 'snode'