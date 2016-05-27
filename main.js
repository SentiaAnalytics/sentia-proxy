const http = require('http');
const httpProxy = require('http-proxy');
const port = process.env.PORT || 5050
const {parse} = require('url')

const proxy = httpProxy.createProxyServer({});

const server = http.createServer((req, res) => {
  try {
    const host = req.headers.host
      .toUpperCase()
      .replace(/\./g, '_')

    // domain env vars point to the linked server they should redirect to
    /// e.g. EXAMPLE_SENTIA_IO=EXAMPLE_PORT_80_TCP
    const link = process.env[host]

    if (!link) {
      res.statusCode = 404
      return res.end('Subdomain is not recognised')
    }

    const target = process.env[link]

    if (!target) {
      res.statusCode = 404
      return res.end(`no linked service for ${link}`)
    }
    
    proxy.web(req, res, { target: target });
  } catch (e) {
    res.statusCode = 500
    res.end(`ERROR ${e}`)
  }
});

console.log(`listening on port ${port}`)
server.listen(port);
