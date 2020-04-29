const http = require("http");

const port = 3000;

const requestHandler = (request, response) => {
  console.log(`someone is accessing ${request.url}`)
  response.end('Hello Node.js Server from a Docker container!');
}

const server = http.createServer(requestHandler);

server.listen(port, (err) => {
  if (err) {
    return console.log('something bad happened', err)
  }

  console.log(`server is listening on http://localhost:${port}`)
});
