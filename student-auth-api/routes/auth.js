// routes/auth.js
const express = require("express");
const bcrypt = require("bcryptjs");
const jwt = require("jsonwebtoken");
const router = express.Router();

const {
  createUser,
  getUserByEmail,
  findByEmail,
  updatePassword,
} = require("../models/User");

const SECRET = "my_secret_key"; //  Use .env in production

//  Register
router.post("/register", async (req, res) => {
  const { name, email, password } = req.body;

  getUserByEmail(email, async (err, existingUser) => {
    if (existingUser) {
      return res.status(400).json({ message: "User already exists" });
    }

    const hashedPassword = await bcrypt.hash(password, 10);
    createUser(name, email, hashedPassword, (err, userId) => {
      if (err) return res.status(500).json({ message: "Error creating user" });

      const token = jwt.sign({ id: userId, email }, SECRET);
      res.json({ token });
    });
  });
});

// Login
router.post("/login", (req, res) => {
  const { email, password } = req.body;

  getUserByEmail(email, async (err, user) => {
    if (!user) return res.status(400).json({ message: "User not found" });

    const valid = await bcrypt.compare(password, user.password);
    if (!valid) return res.status(401).json({ message: "Invalid credentials" });

    const token = jwt.sign({ id: user.id, email: user.email }, SECRET);
    res.json({ token });
  });
});


// Get all registered users
router.get('/users', async (req, res) => {
  const db = require('../db');
  try {
    db.all('SELECT id, name, email FROM users', [], (err, rows) => {
      if (err) {
        console.error("DB error:", err.message);
        return res.status(500).json({ success: false, message: "Failed to fetch users" });
      }
      res.json({ success: true, users: rows });
    });
  } catch (error) {
    console.error("Unexpected error:", error.message);
    res.status(500).json({ success: false, message: "Server error" });
  }
});


//  Reset Password
router.post("/reset-password", async (req, res) => {
  const { email, newPassword } = req.body;

  if (!email || !newPassword) {
    return res
      .status(400)
      .json({ success: false, message: "Email and new password required" });
  }

  try {
    const user = await findByEmail(email);
    if (!user) {
      return res
        .status(404)
        .json({ success: false, message: "No user found with that email" });
    }

    const hashedPassword = await bcrypt.hash(newPassword, 10);
    const changes = await updatePassword(email, hashedPassword);

    if (changes === 0) {
      return res
        .status(404)
        .json({ success: false, message: "No user found with that email" });
    }

    return res.json({
      success: true,
      message: "Password updated successfully",
    });
  } catch (error) {
    console.error("Reset Error:", error.message);
    return res.status(500).json({ success: false, message: "Server error" });
  }
});

module.exports = router;
