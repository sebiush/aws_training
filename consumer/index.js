const express = require('express');
const app = express();
const axios = require('axios');

const PORT = process.env.PORT || 3002;
const ACCESS_ALLOW_ORIGIN = process.env.ACCESS_ALLOW_ORIGIN || 'http://localhost:3000';
const STOCK_HOST = 'http://localhost:3003';

const sendResponse = (res, data) => {
  res.header('Access-Control-Allow-Origin', ACCESS_ALLOW_ORIGIN);
  res.header('Access-Control-Allow-Headers', 'Origin, X-Requested-With, Content-Type, Accept');
  res.send(data);
};

app.post('/api/consume', (req, res, next) => {
  console.log('consumed');
  axios.post(`${STOCK_HOST}/api/consume`)
    .then(() => { sendResponse(res, 'consumed') })
    .catch(error => { sendResponse(res, error) });
});

app.listen(PORT, () => {
  console.log(`Consumer listening on port: ${PORT}`);
});
