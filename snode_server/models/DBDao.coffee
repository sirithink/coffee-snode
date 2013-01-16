FastLegSBase = require 'FastLegS'
FastLegS = new FastLegSBase 'mysql'

config = require '../config'

FastLegS.connect config.db

User = FastLegS.Base.extend
  tableName: 'user'
  primaryKey: 'id'
  
exports.all = (callback) ->
  User.find {}, (err, results) ->
    callback err, results