require('dotenv').config();
const express = require('express');
const authRoutes = require('./src/routes/auth');
const migrate = require('./src/migrate');

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

app.get('/health', (req, res) => {
  res.json({ status: 'ok' });
});

app.use('/', authRoutes);

migrate()
  .then(() => {
    app.listen(PORT, () => {
      console.log(`API démarrée sur http://localhost:${PORT}`);
    });
  })
  .catch((err) => {
    console.error('Impossible de préparer la base de données :', err);
    process.exit(1);
  });
