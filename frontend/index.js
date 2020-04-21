const express = require('express');
const { createProxyMiddleware } = require('http-proxy-middleware');
const app = express();

const PORT = process.env.PORT || 3000;
const PRODUCER_API = process.env.PRODUCER_API || 'http://localhost:3001';
const CONSUMER_API = process.env.CONSUMER_API || 'http://localhost:3002';
const STOCK_API = process.env.STOCK_API || 'http://localhost:3003';

app.use(express.static('public'));

app.use('/api/producer', createProxyMiddleware({ target: PRODUCER_API, changeOrigin: true }));
app.use('/api/consumer', createProxyMiddleware({ target: CONSUMER_API, changeOrigin: true }));
app.use('/api/stock', createProxyMiddleware({ target: STOCK_API, changeOrigin: true }));

app.listen(PORT, () => {
  console.log(`Frontend listening on port: ${PORT}`);
});
