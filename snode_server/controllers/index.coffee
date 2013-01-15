# dateUtil = require '../util/dateUtil'
# ck = require 'coffeekup'
# index
exports.get = (req, res) ->
    # df = dateUtil.time()
    # console.log "time:\t#{df}"
    
    res.render 'index', name: 'snode'
    # res.render 'index', title: 'snode', index: 'activd'