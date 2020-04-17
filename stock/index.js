const express = require('express');
const app = express();

const PORT = process.env.PORT || 3003;

var stock = 0;

app.get('/api/stock', (req, res, next) => {
  console.log('stock');
  res.header('Access-Control-Allow-Origin', 'http://localhost:3000');
  res.header('Access-Control-Allow-Headers', 'Origin, X-Requested-With, Content-Type, Accept');
  res.send({ stock });
});

app.post('/api/consume', (req, res, next) => {
  console.log('consume');
  if (stock > 0) {
    stock--;
    res.send('consumed')
  } else {
    res.status(409).send('not consumed');
  }
});

app.post('/api/produce', (req, res, next) => {
  console.log('produce');
  stock++;
  res.send('produced');
});

app.listen(PORT, () => {
  console.log(`Stock listening on port: ${PORT}`);
});
