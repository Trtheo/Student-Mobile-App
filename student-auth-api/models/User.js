// models/User.js
const db = require("../db");

// Register a new user
const createUser = (name, email, password, callback) => {
  const query = `INSERT INTO users (name, email, password) VALUES (?, ?, ?)`;
  db.run(query, [name, email, password], function (err) {
    callback(err, this?.lastID);
  });
};

// Get user by email (callback style)
const getUserByEmail = (email, callback) => {
  const query = `SELECT * FROM users WHERE email = ?`;
  db.get(query, [email], (err, row) => {
    callback(err, row);
  });
};

// Get user by email (async style)
const findByEmail = async (email) => {
  return await db.get("SELECT * FROM users WHERE email = ?", [email]);
};

// Update password with change detection
const updatePassword = async (email, newPassword) => {
  return new Promise((resolve, reject) => {
    db.run(
      "UPDATE users SET password = ? WHERE email = ?",
      [newPassword, email],
      function (err) {
        if (err) return reject(err);
        resolve(this.changes); //  Returns 1 if updated, 0 if not found
      }
    );
  });
};

module.exports = {
  createUser,
  getUserByEmail,
  findByEmail,
  updatePassword,
};
