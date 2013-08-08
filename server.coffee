require "colors"
exs = require('express')
app = exs()
srv = require('http').Server(app)
io  = require('socket.io').listen(srv)

app.events = []

io.on 'connection', (sock) ->
  console.log "on connection"

  sock.on "submit", (data, done) ->
    console.log data
    app.events.push(data)
    done(status: 0)

  sock.on "get-events", (data, done) ->
    console.log "get-events", data, done
    done(events: app.events)

app
  .use(exs.favicon())
  .use(exs.static(__dirname + "/public"))
  .use(exs.logger("tiny"))

srv.listen(3000)

console.log "start server on port 3000".green