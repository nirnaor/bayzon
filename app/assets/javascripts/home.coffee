document.addEventListener "DOMContentLoaded",  ->
  prod = document.querySelector("#product")
  return if not prod
  prod = prod.innerHTML

  # Create a subscription BEFORE fetching the data
  App.cable.subscriptions.create { channel: "ProductsChannel", product: prod },
    received: (data) ->
      console.log("Yes! I have some data")
      document.querySelector("tbody").insertAdjacentHTML("beforeEnd", data.products)

  console.log "Will now fetch data for #{prod}"
  fetch("/sellers?product=#{prod}").then ->
   console.log "Done fetching data #{prod}"
