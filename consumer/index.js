const express = require('express');
const app = express();
const axios = require('axios');

const PORT = process.env.PORT || 3002;
const STOCK_HOST = process.env.STOCK_HOST || 'http://localhost:3003';

const sendResponse = (res, data) => {
  res.send(data);
};

app.post('/api/consumer', (req, res, next) => {
  console.log('consumed');
  axios.post(`${STOCK_HOST}/api/stock/consume`)
    .then(() => { sendResponse(res, 'consumed') })
    .catch(error => { sendResponse(res, error) });
});

app.listen(PORT, () => {
  console.log(`Consumer listening on port: ${PORT}`);
});
