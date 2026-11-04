const fs = require('fs');
const path = require('path');
const pool = require('./db');

// Crée les tables si elles n'existent pas (schema.sql est idempotent)
async function migrate() {
  const sql = fs.readFileSync(path.join(__dirname, '..', 'db', 'schema.sql'), 'utf8');
  await pool.query(sql);
}

module.exports = migrate;
