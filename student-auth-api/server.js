// server.js
const express = require('express');
const cors = require('cors');
const authRoutes = require('./routes/auth');

const app = express();

//  Middlewares
app.use(cors());
app.use(express.json());

//  API routes
app.use('/api', authRoutes);

//  Server start
const PORT = 5000;
app.listen(PORT, () => {
  console.log(`Server running on http://localhost:${PORT}`);
});
