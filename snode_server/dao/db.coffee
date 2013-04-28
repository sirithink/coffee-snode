logentries = require 'node-logentries'
poolModule = require 'generic-pool'

config = require '../config'
# log
log = logentries.logger config.logToken

###
* mysql generic pool
* @type {Object}
###
pool = poolModule.Pool
  name: 'mysql'
  create: (callback) ->
    connection = require("mysql").createConnection(config.db)
    connection.connect()
    callback null, connection
  destroy: (client) ->
    client.end()
  max: 10
  min: 2
  idleTimeoutMillis: 30000
  log: false

###
* mysql query
* @param sql
* @param param
* @param callback
###
exports.db = class db
  @query: (args...) ->
    if typeof args[args.length - 1] is "function"
      callback = args.pop()
    else
      callback = ->
    pool.acquire (error, client) ->
      if error
        log.info "#{error}"
        callback(error, null);
      else
        client.query args..., (error, rows) ->
          callback error, rows
          pool.release client
  @insert: (table, data, callback) ->
    sqlStr = "INSERT INTO `#{table}` SET ?"
    @query sqlStr, data, callback
  @update: (table, data, params, callback) ->
    dataKeys = []
    dataVals = []
    for key, val of data
      dataKeys.push "`#{key}` = ?"
      dataVals.push "#{val}"
    paraKeys = []
    paraVals = []
    for key, val of params
      paraKeys.push "`#{key}` = ?"
      paraVals.push "#{val}"
    sqlStr = "UPDATE `#{table}` SET #{dataKeys.join(', ')} WHERE #{paraKeys.join(' AND ')}"
    @query sqlStr, dataVals.concat(paraVals), callback
  @delete: (table, data, callback) ->
    columns = []
    values  = []
    for key, val of data
      columns.push "`#{key}` = ?"
      values.push "#{val}"
    sqlStr = "DELETE FROM `#{table}` WHERE #{columns.join(' AND ')}"
    @query sqlStr, values, callback
  @findById: (table, id, callback) ->
    sql = "SELECT * FROM `#{table}` WHERE id = ?"
    @query sql, id, callback
  @findAll: (table, callback) ->
    sql = "SELECT * FROM `#{table}` ORDER BY `id` DESC"
    @query sql, callback