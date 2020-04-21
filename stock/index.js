const express = require('express');
const app = express();

const PORT = process.env.PORT || 3003;

var stock = 0;

app.get('/api/stock', (req, res, next) => {
  console.log('stock');
  res.send({ stock });
});

app.post('/api/stock/consume', (req, res, next) => {
  console.log('consume');
  if (stock > 0) {
    stock--;
    res.send('consumed')
  } else {
    res.status(409).send('not consumed');
  }
});

app.post('/api/stock/produce', (req, res, next) => {
  console.log('produce');
  stock++;
  res.send('produced');
});

app.listen(PORT, () => {
  console.log(`Stock listening on port: ${PORT}`);
});
