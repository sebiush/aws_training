const express = require('express');
const app = express();
const axios = require('axios');

const PORT = process.env.PORT || 3001;
const STOCK_HOST = process.env.STOCK_HOST || 'http://localhost:3003';

const sendResponse = (res, data) => {
  res.send(data);
};

app.post('/api/producer', (req, res, next) => {
  console.log('produced');
  axios.post(`${STOCK_HOST}/api/stock/produce`)
    .then(() => { sendResponse(res, 'produced') })
    .catch(error => { sendResponse(res, error) });
});

app.listen(PORT, () => {
  console.log(`Producer listening on port: ${PORT}`);
});
