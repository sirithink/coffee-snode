// Generated by CoffeeScript 1.5.0
var app, config, express, expressValidator, gzippo, http, log, logentries, path, routes, server, socket;

express = require('express');

expressValidator = require('express-validator');

logentries = require('node-logentries');

gzippo = require('gzippo');

config = require('./config');

routes = require('./routes');

socket = require('./socket');

http = require('http');

path = require('path');

app = express();

log = logentries.logger(config.logToken);

app.configure(function() {
  app.set('port', process.env.VCAP_APP_PORT || config.port);
  app.set('views', __dirname + '/../views');
  app.set('view engine', 'jade');
  app.use(express.favicon(__dirname + '/../public/favicon.ico'));
  app.use(express.logger('dev'));
  app.use(express.bodyParser({
    uploadDir: __dirname + '/../public/temp'
  }));
  app.use(expressValidator);
  app.use(express.methodOverride());
  app.use(express.cookieParser());
  app.use(express.session({
    secret: config.secret
  }));
  app.use(app.router);
  app.use(gzippo.staticGzip(path.join(__dirname, '/../public')));
  return app.use(function(error, req, res, next) {
    return res.render('error/500');
  });
});

app.configure('development', function() {
  return app.use(express.errorHandler());
});

app.configure('production', function() {
  app.use(express["static"](static_dir, {
    maxAge: config.maxAge
  }));
  app.use(express.errorHandler());
  return app.set('view cache', true);
});

routes(app);

server = http.createServer(app).listen(app.get('port'), function() {
  console.log("listening on port " + app.get('port'));
  return log.info("listening on port " + app.get('port'));
});

socket(server);
