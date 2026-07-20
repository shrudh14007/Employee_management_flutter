const express = require('express');
const bcrypt = require('bcryptjs');
const pool = require('./database');

const app = express();
const jwt = require('jsonwebtoken');

const JWT_SECRET = 'my-secret-key';
app.use(express.json());

app.post('/register', async (req, res) => {
  try {
    const { email, password } = req.body;

    const hashedPassword = await bcrypt.hash(password, 10);

    await pool.query(
      'INSERT INTO users(email, password) VALUES($1, $2)',
      [email, hashedPassword]
    );

    res.status(201).json({
      success: true,
      message: 'User created'
    });

  } catch (err) {
    console.error(err);

    res.status(500).json({
      success: false,
      message: 'Something went wrong'
    });
  }
});

app.listen(3000, () => {
  console.log('Server running on port 3000');
});


app.post('/login', async (req, res) => {
  try {
    const { email, password } = req.body;

    const result = await pool.query(
      'SELECT * FROM users WHERE email = $1',
      [email]
    );

    if (result.rows.length === 0) {
      return res.status(401).json({
        success: false,
        message: 'Invalid email or password'
      });
    }

    const user = result.rows[0];

    const isMatch = await bcrypt.compare(
      password,
      user.password
    );

    if (!isMatch) {
      return res.status(401).json({
        success: false,
        message: 'Invalid email or password'
      });
    }

    const token = jwt.sign(
      {
        userId: user.id,
        email: user.email
      },
      JWT_SECRET,
      {
        expiresIn: '1h'
      }
    );

    res.json({
      success: true,
      token
    });

  } catch (err) {
    console.error(err);

    res.status(500).json({
      success: false,
      error: err.message
    });
  }
});


app.get('/profile', async (req, res) => {
  try {
    const authHeader = req.headers.authorization;

    if (!authHeader) {
      return res.status(401).json({
        message: 'Token missing'
      });
    }

    const token = authHeader.split(' ')[1];

    const decoded = jwt.verify(
      token,
      JWT_SECRET
    );

    res.json({
      success: true,
      user: decoded
    });

  } catch (err) {
    res.status(401).json({
      success: false,
      message: 'Invalid token'
    });
  }
});