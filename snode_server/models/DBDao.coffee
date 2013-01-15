FastLegSBase = require 'FastLegS'
FastLegS = new FastLegSBase 'mysql'

config = require '../config'

FastLegS.connect config.db

User = FastLegS.Base.extend
  tableName: 'user'
  primaryKey: 'id'
  
callback = (err, results) ->
  console.dir err
  console.dir results

exports.all = ->
  User.find {}, callback