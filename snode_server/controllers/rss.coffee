logentries = require 'node-logentries'
data2xml = require('data2xml')()
config = require '../config'
# dao
dao = require '../models/BlogDao'
# log
log = logentries.logger config.logToken

exports.get = (req, res) ->
    rss_obj = 
      _attr: version: '2.0'
      channel:
        title: config.rss.title,
        link: config.rss.link,
        language: config.rss.language,
        description: config.rss.description,
        item: []
    
    dao.all {del_status: 0}, only: ['id','title', 'content','update_time'], limit: config.max_items, order: ['-id'], (err, blogs) ->
        console.log err if err
        log.log "debug", err if err
        for key, value of blogs
            rss_obj.channel.item.push
                title: value.title,
                link: config.rss.link + 'blog/' + value.id,
                guid: config.rss.link + 'blog/' + value.id,
                description: value.content
                author: config.rss.author
                pubDate: value.update_time.toUTCString()
                
        rss_content = data2xml 'rss', rss_obj
        res.contentType 'application/xml'
        res.send(rss_content);        