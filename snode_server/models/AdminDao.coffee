FastLegSBase = require 'FastLegS'
FastLegS = new FastLegSBase 'mysql'

config = require '../config'
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
    callback err, results
    
###
Admin login
###
exports.login = (obj, callback) ->
  Admin.find obj, (err, results) ->
    callback err, results