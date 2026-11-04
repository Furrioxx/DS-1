const express = require('express');
const bcrypt = require('bcrypt');
const pool = require('../db');

const router = express.Router();

router.post('/login', async (req, res) => {
  const { email, password } = req.body || {};

  if (!email || !password) {
    return res.status(400).json({ status: 400, message: 'Email et mot de passe requis' });
  }

  try {
    const { rows } = await pool.query(
      `SELECT u.id, u.firstname, u.lastname, u.email, u.password, r.name AS role
       FROM users u
       JOIN roles r ON r.id = u.role_id
       WHERE u.email = $1`,
      [email.trim().toLowerCase()]
    );

    const user = rows[0];
    if (!user || !(await bcrypt.compare(password, user.password))) {
      return res.status(401).json({ status: 401, message: 'Identifiants invalides' });
    }

    return res.status(200).json({
      status: 200,
      message: 'Success',
      id: user.id,
      firstname: user.firstname,
      lastname: user.lastname,
      email: user.email,
      role: user.role_id,
    });
  } catch (err) {
    console.error(err);
    return res.status(500).json({ status: 500, message: 'Erreur serveur' });
  }
});

module.exports = router;
