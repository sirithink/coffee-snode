# socket.io
module.exports = (server) ->
    io = require('socket.io').listen server, log:false
    conns = {}
    io.sockets.on 'connection', (socket) ->
        cid = socket.id
        for ccid in conns
            soc = conns[ccid]
            soc.emit 'join', cid: socket.id
        conns[cid] = socket
        socket.on 'disconnect', ->
            delete conns[cid]
            for cid in conns
                soc = conns[cid]
                soc.emit 'quit', cid: cid
        socket.on 'say', (data) ->
            data.cid = cid
            for ccid in conns
                soc = conns[ccid]
                soc.emit 'broadcast', data