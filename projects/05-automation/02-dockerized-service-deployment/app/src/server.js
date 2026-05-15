require('dotenv').config();
const express = require('express');

const app = express();
const PORT = process.env.PORT || 3000;

const USERNAME = process.env.APP_USERNAME;
const PASSWORD = process.env.APP_PASSWORD;
const SECRET_MESSAGE = process.env.SECRET_MESSAGE;

app.get('/', (req, res) => {
  res.json({ message: 'Service is running', status: 'ok' });
});

app.get('/secret', (req, res) => {
  const authHeader = req.headers['authorization'];

  if (!authHeader || !authHeader.startsWith('Basic ')) {
    res.set('WWW-Authenticate', 'Basic realm="Restricted"');
    return res.status(401).json({ error: 'Authentication required' });
  }

  const base64 = authHeader.split(' ')[1];
  const [user, pass] = Buffer.from(base64, 'base64').toString().split(':');

  if (user !== USERNAME || pass !== PASSWORD) {
    return res.status(403).json({ error: 'Invalid credentials' });
  }

  res.json({ secret: SECRET_MESSAGE });
});

const server = app.listen(PORT, () => {
  console.log(`Server running on port ${PORT}`);
});

module.exports = { app, server };
