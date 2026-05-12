const express = require('express');

const app = express();
const PORT = process.env.PORT || 3000;
const START_TIME = Date.now();

app.get('/', (req, res) => {
  res.json({
    message: 'Hello, world!',
    version: process.env.npm_package_version || '1.0.0',
    uptime_seconds: Math.floor((Date.now() - START_TIME) / 1000),
  });
});

app.get('/health', (req, res) => {
  res.json({
    status: 'ok',
    timestamp: new Date().toISOString(),
  });
});

const server = app.listen(PORT, () => {
  console.log(`Server running on port ${PORT}`);
});

module.exports = { app, server };
