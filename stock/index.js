const express = require('express');
const app = express();
const stock = require('./stock');

const PORT = process.env.PORT || 3003;

const errorHandler = (res, error) => {
  res.status(500).send(error);
  console.log(error);
}

app.get('/api/stock', (req, res, next) => {
  console.log('stock request');

  stock.currentValue()
    .then((stock) => { res.send({ stock }) })
    .catch((error) => { errorHandler(res, error) });
});

app.post('/api/stock/consume', (req, res, next) => {
  console.log('consume request');

  stock.takeOne()
    .then((result) => {
      if (result) {
        res.send('consumed');
      } else {
        res.status(409).send('not consumed');
      }
    })
    .catch((error) => { errorHandler(res, error) });
});

app.post('/api/stock/produce', (req, res, next) => {
  console.log('produce request');

  stock.addOne()
    .then(() => { res.send('produced') })
    .catch((error) => { errorHandler(res, error) });
});

app.listen(PORT, () => {
  console.log(`Stock listening on port: ${PORT}`);
});
