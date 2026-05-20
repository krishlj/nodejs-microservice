const client = require('prom-client');
const collectDefaultMetrics = client.collectDefaultMetrics;
collectDefaultMetrics();
app.get('/metrics', async (req, res) => {
  res.set('Content-Type', client.register.contentType);
  res.end(await client.register.metrics());
});

const express = require('express');

const app = express();

const PORT = 3000;

app.get('/', (req, res) => {
  res.send('Node.js Microservice Running');
});

app.get('/health', (req, res) => {
  res.status(200).json({
    status: 'healthy'
  });
});

app.listen(PORT, () => {
  console.log(`Server running on port ${PORT}`);
});