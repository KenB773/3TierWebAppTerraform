const express = require('express');
const app = express();
const port = process.env.PORT || 3000;
const { Pool } = require("pg");

let pool;
try {
  pool = new Pool({
    host: process.env.DB_HOST,
    user: process.env.DB_USER,
    password: process.env.DB_PASS,
    database: process.env.DB_NAME,
    port: 5432,
    ssl: {
      rejectUnauthorized: false
    }
  });
  console.log("Connected to PostgreSQL pool (SSL enabled).");
} catch (err) {
  console.error("Failed to initialize DB pool:", err.message);
}

app.use(express.json());

app.get("/", (req, res) => {
  res.json({ message: "Node.js backend is live!" });
});

app.get("/health", (req, res) => {
  res.send("OK");
});

app.get("/dbtest", async (req, res) => {
  if (!pool) {
    return res.status(500).json({ error: "No DB connection available" });
  }
  try {
    const result = await pool.query("SELECT NOW()");
    res.json({ time: result.rows[0].now });
  } catch (err) {
    res.status(500).json({ error: "DB error", details: err.message });
  }
});

app.listen(port, '0.0.0.0', () => {
  console.log(`App listening on port ${port}`);
});
