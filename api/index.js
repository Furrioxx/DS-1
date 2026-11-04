require('dotenv').config();
const express = require('express');
const authRoutes = require('./src/routes/auth');

if (!process.env.JWT_SECRET) {
  console.error('JWT_SECRET manquant dans le fichier .env');
  process.exit(1);
}

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
