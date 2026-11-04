const { Pool } = require('pg');

const pool = new Pool({
  host: process.env.DB_HOST || 'localhost',
  port: Number(process.env.DB_PORT) || 5432,
  user: process.env.DB_USER || 'ds1',
  password: process.env.DB_PASSWORD || 'ds1password',
  database: process.env.DB_NAME || 'ds1',
});

module.exports = pool;
