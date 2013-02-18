logentries = require 'node-logentries'
FastLegSBase = require 'FastLegS'
FastLegS = new FastLegSBase 'mysql'

config = require '../config'
# log
log = logentries.logger config.logToken
# connect db
FastLegS.connect config.db

Admin = FastLegS.Base.extend
  tableName: 'admin'
  primaryKey: 'id'
  
###
Admin findById
###
exports.findById = (id, callback) ->
  Admin.find id, (err, results) ->
    console.log err if err
    log.log "debug", err if err
    callback results
    
###
Admin login
###
exports.login = (obj, callback) ->
  Admin.find obj, (err, results) ->
    console.log err if err
    log.log "debug", err if err
    callback results