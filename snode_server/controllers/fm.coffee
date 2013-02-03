needle = require 'needle';

listUrl = "http://douban.fm/j/mine/playlist";
exports.list = (req, res) ->
    needle.get listUrl, (error, resp, result) ->
        if !error and resp.statusCode is 200
            res.json(result)
            
exports.music = (req, res) ->
    url = req.query.url;
    needle.get url, (error, resp, result) ->
        if !error and resp.statusCode is 200
          # res.set('Content-Type', 'audio/mpeg')
          res.end(result)