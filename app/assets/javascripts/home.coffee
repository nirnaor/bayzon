document.addEventListener "DOMContentLoaded",  ->
  prod = document.querySelector("#product")
  return if not prod
  prod = prod.innerHTML
  console.log "Will now fetch data for #{prod}"
  fetch("/sellers?product=#{prod}").then ->
   console.log "Done fetching data #{prod}"
