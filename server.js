const express = require('express');

const app = express();

const port = process.env.PORT ? process.env.PORT : 3001;
const build = `${__dirname}/dist`;

app.use(express.static(build));

app.get('*', function response(req, res) {
  res.sendFile(`${__dirname}/static/index.html`);
});


app.listen(port, function (error) {
  if (error) {
    console.log(error);
  }
  console.info('Express is listening on port %s.', port);
});
