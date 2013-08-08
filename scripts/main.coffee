app = angular.module("formsApp", [])



app.factory "EventsData", () -> events: []



app.factory "socket", ($rootScope) ->

  console.log "socket factory"

  socket = io.connect('http://localhost:3000')

  on: (event, callback) ->
    socket.on event, ->
      args = arguments
      $rootScope.$apply ->
        callback.apply socket, args

  emit: (event, data, callback) ->
    socket.emit event, data, ->
      args = arguments
      $rootScope.$apply ->
        callback.apply socket, args if callback




EventList = ($scope, socket, EventsData) ->

  $scope.events = EventsData.events

  socket.emit "get-events", {}, (resp) ->
    console.log "get-events", resp
    for ev in resp.events
      $scope.events.push(ev)


  

EventForm = ($scope, socket, EventsData) ->
  console.log "load EventForm controller"

  guid = ->
    "xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx".replace(/[xy]/g, (c) ->
      r = Math.random() * 16 | 0
      v = (if c is "x" then r else r & 3 | 8)
      v.toString 16
    ).toUpperCase()

  $scope.form = 
    title: "Super event"
    time: "12:00"
    desc: "Hello world"

  $scope.events = EventsData.events

  $scope.submit = ->
    data = 
      id: guid()
      title: $scope.form.title
      time:  $scope.form.time
      desc:  $scope.form.desc

    console.log data

    $scope.events.push(data)

    socket.emit "submit", data, (resp) ->
      console.log resp