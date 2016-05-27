http = require 'http'
httpProxy = require 'http-proxy'
port = process.env.PORT || 5050
{parse} = require 'url'

proxy = httpProxy.createProxyServer {}

server = http.createServer (req, res) =>
  host = req.headers.host
    .toUpperCase()
    .replace /\./g, '_'

  # domain env vars point to the linked server they should redirect to
  # e.g. EXAMPLE_SENTIA_IO=EXAMPLE_PORT_80_TCP
  target = process.env[process.env[host]]
  if !target
    res.statusCode = 404
    return res.end "#{host} does not point to any service"



  proxy.web req, res, target: target.replace 'tcp', 'http'

console.log "listening on port #{port}"
server.listen port
