require('dotenv').config();
const express = require('express');
const authRoutes = require('./src/routes/auth');

const app = express();
const PORT = process.env.PORT || 3000;

app.use(express.json());

app.get('/', (req, res) => {
  res.json({ message: 'Hello World' });
});

app.use('/', authRoutes);

app.listen(PORT, () => {
  console.log(`API démarrée sur http://localhost:${PORT}`);
});
