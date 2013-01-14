// Generated by CoffeeScript 1.4.0

module.exports = function(server) {
  var conns, io;
  io = require('socket.io').listen(server, {
    log: false
  });
  conns = {};
  return io.sockets.on('connection', function(socket) {
    var ccid, cid, soc, _i, _len;
    cid = socket.id;
    for (_i = 0, _len = conns.length; _i < _len; _i++) {
      ccid = conns[_i];
      soc = conns[ccid];
      soc.emit('join', {
        cid: socket.id
      });
    }
    conns[cid] = socket;
    socket.on('disconnect', function() {
      var _j, _len1, _results;
      delete conns[cid];
      _results = [];
      for (_j = 0, _len1 = conns.length; _j < _len1; _j++) {
        cid = conns[_j];
        soc = conns[cid];
        _results.push(soc.emit('quit', {
          cid: cid
        }));
      }
      return _results;
    });
    return socket.on('say', function(data) {
      var _j, _len1, _results;
      data.cid = cid;
      _results = [];
      for (_j = 0, _len1 = conns.length; _j < _len1; _j++) {
        ccid = conns[_j];
        soc = conns[ccid];
        _results.push(soc.emit('broadcast', data));
      }
      return _results;
    });
  });
};
