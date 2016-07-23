console.log("hello")
App.products = App.cable.subscriptions.create "ProductsChannel",
  connected: ->
    # Called when the subscription is ready for use on the server

  disconnected: ->
    # Called when the subscription has been terminated by the server

  received: (data) ->
    # Called when there's incoming data on the websocket for this channel
    console.log("got data: #{data}")
    document.querySelector("tbody").insertAdjacentHTML("beforeEnd", data.products)

