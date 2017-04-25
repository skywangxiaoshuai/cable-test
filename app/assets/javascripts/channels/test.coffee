App.test = App.test.subscriptions.create "TestChannel",
# App.cable.subscriptions.create "TestChannel",

  connected: ->


  disconnected: ->


  received: (data) ->
    alert(data)
