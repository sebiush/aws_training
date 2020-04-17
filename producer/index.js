const express = require('express');
const app = express();
const axios = require('axios');

const PORT = process.env.PORT || 3001;

const sendResponse = (res, data) => {
  res.header('Access-Control-Allow-Origin', 'http://localhost:3000');
  res.header('Access-Control-Allow-Headers', 'Origin, X-Requested-With, Content-Type, Accept');
  res.send(data);
};

app.post('/api/produce', (req, res, next) => {
  console.log('produced');
  axios.post('http://localhost:3003/api/produce')
    .then(() => { sendResponse(res, 'produced') })
    .catch(error => { sendResponse(res, error) });
});

app.listen(PORT, () => {
  console.log(`Producer listening on port: ${PORT}`);
});
