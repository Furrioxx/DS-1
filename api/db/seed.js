require('dotenv').config();
const fs = require('fs');
const path = require('path');
const bcrypt = require('bcrypt');
const pool = require('../src/db');

const roles = ['admin', 'user'];

const users = [
  { firstname: 'Admin', lastname: 'Root', email: 'admin@example.com', password: 'admin123', role: 'admin' },
  { firstname: 'John', lastname: 'Doe', email: 'john.doe@example.com', password: 'password123', role: 'user' },
  { firstname: 'Jane', lastname: 'Smith', email: 'jane.smith@example.com', password: 'password123', role: 'user' },
];

async function seed() {
  const client = await pool.connect();
  try {
    await client.query('BEGIN');

    // Crée les tables si besoin, puis repart de zéro
    await client.query(fs.readFileSync(path.join(__dirname, 'schema.sql'), 'utf8'));
    await client.query('TRUNCATE users, roles RESTART IDENTITY CASCADE');

    const roleIds = {};
    for (const name of roles) {
      const { rows } = await client.query('INSERT INTO roles (name) VALUES ($1) RETURNING id', [name]);
      roleIds[name] = rows[0].id;
    }

    for (const u of users) {
      const hash = await bcrypt.hash(u.password, 10);
      await client.query(
        'INSERT INTO users (firstname, lastname, email, password, role_id) VALUES ($1, $2, $3, $4, $5)',
        [u.firstname, u.lastname, u.email, hash, roleIds[u.role]]
      );
    }

    await client.query('COMMIT');
    console.log(`Seed terminé : ${roles.length} rôles, ${users.length} utilisateurs.`);
  } catch (err) {
    await client.query('ROLLBACK');
    console.error('Erreur pendant le seed :', err);
    process.exitCode = 1;
  } finally {
    client.release();
    await pool.end();
  }
}

seed();
