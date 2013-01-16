FastLegSBase = require 'FastLegS'
FastLegS = new FastLegSBase 'mysql'

config = require '../config'
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
    callback err, results
    
###
  
###