config = require '../config'
orm = require "orm"

orm.connect(config.db, (err, db) ->
	if err 
		throw err

	Person = db.define "person", {
		name      : String,
		surname   : String,
		age       : Number,
		male      : Boolean,
		dt        : Date,
		photo     : Buffer
	}, {
		methods: {
			fullName: ->
				return [ this.name, this.surname ].join(' ')
		}
  }
	Person.hasMany "friends", {
		rate      : Number
	}

	Person.get(1, (err, Jane) ->
		# console.log(Jane)
		Jane.getFriends().only("name").run( (err, people) ->
			console.log(err, people)
		)
	)
)