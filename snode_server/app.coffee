express = require 'express'
expressValidator = require 'express-validator'
logentries = require 'node-logentries'
config = require './config'
routes = require './routes'
socket = require './socket'
http = require 'http'
path = require 'path'

app = express()
# node-logentries api https://logentries.com/doc/appfog/
log = logentries.logger config.logToken

# config
app.configure ->
    app.set 'port', process.env.VCAP_APP_PORT || config.port
    app.set 'views', __dirname + '/../views'
    app.set 'view engine', 'jade'
    app.use express.favicon __dirname + '/../public/favicon.ico'
    app.use express.logger 'dev'
    app.use express.bodyParser uploadDir: __dirname + '/../public/temp'
    app.use expressValidator
    app.use express.methodOverride()
    app.use express.cookieParser()
    app.use express.session secret: config.secret
    app.use app.router
    app.use express.static path.join __dirname, '/../public'
    
    app.use (error, req, res, next) ->
        res.render error, title: 'Sorry something bad happened!'

# 开发环境
app.configure 'development', ->
    app.use express.errorHandler()

# 现网
app.configure 'production', ->
    app.use express.static static_dir, {
        maxAge : config.maxAge
    }
    app.use express.errorHandler()
    app.set 'view cache', true

# routes
routes app

server = http.createServer(app).listen app.get('port'), ->
    console.log "listening on port " + app.get 'port'
    log.info "listening on port " + app.get 'port'
# socket.io
socket server
