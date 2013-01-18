dateUtil = require '../util/dateUtil'
mailUtil = require '../util/mailUtil'

# dao
dao = require '../models/BlogDao'
# index
exports.get = (req, res) ->
    df = dateUtil.time()
    console.log "time:\t#{df}"
    dao.all {del_status: 0}, only: ['id','title','update_time'], order: ['-id'], (err, blogs) ->
        console.log err or blogs
        # format date
        for blog in blogs
            for b of blog
                blog[b] = dateUtil.format blog[b] if blog[b] instanceof Date
        res.render 'index', title: 'snode', blogs: blogs

exports.mail = (req, res) ->
    user = 
        email    : "596392912@qq.com"
        nick_name: "春梦"
    code = "123123"
    mailUtil.sendSignup user, code
    res.render 'index', name: 'snode'