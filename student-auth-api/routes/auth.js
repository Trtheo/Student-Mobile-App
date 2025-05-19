// routes/auth.js
const express = require('express');
const bcrypt = require('bcryptjs');
const jwt = require('jsonwebtoken');
const { createUser, getUserByEmail } = require('../models/User');
const router = express.Router();

const SECRET = "my_secret_key"; // use env for production

// Register
router.post('/register', async (req, res) => {
  const { name, email, password } = req.body;
  getUserByEmail(email, async (err, existingUser) => {
    if (existingUser) return res.status(400).json({ message: 'User already exists' });

    const hashedPassword = await bcrypt.hash(password, 10);
    createUser(name, email, hashedPassword, (err, userId) => {
      if (err) return res.status(500).json({ message: 'Error creating user' });
      const token = jwt.sign({ id: userId, email }, SECRET);
      res.json({ token });
    });
  });
});

// Login
router.post('/login', (req, res) => {
  const { email, password } = req.body;
  getUserByEmail(email, async (err, user) => {
    if (!user) return res.status(400).json({ message: 'User not found' });
    const valid = await bcrypt.compare(password, user.password);
    if (!valid) return res.status(401).json({ message: 'Invalid credentials' });

    const token = jwt.sign({ id: user.id, email: user.email }, SECRET);
    res.json({ token });
  });
});

module.exports = router;
