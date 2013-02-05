logentries = require 'node-logentries'
FastLegSBase = require 'FastLegS'
FastLegS = new FastLegSBase 'mysql'

config = require '../config'
# log
log = logentries.logger config.logToken
# connect db
FastLegS.connect config.db

User = FastLegS.Base.extend
  tableName: 'user_info'
  primaryKey: 'id'
  
###
User findById
###
exports.findById = (id, callback) ->
  User.find id, (err, results) ->
    console.log err if err
    log.log "debug", err if err
    callback results
    
###
  
###