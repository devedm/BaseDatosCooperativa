const express = require('express');
const path = require('path');
const cors = require('cors');
const app = express();
const db = require('./db');

app.use(cors());
app.use(express.json());

// Conexión a BD
db.connect();

// Servir frontend
app.use(express.static(path.join(__dirname, 'frontend')));

app.get('/', (req, res) => {
    res.sendFile(path.join(__dirname, 'frontend', 'index.html'));
});

// Rutas API
app.use('/api/usuario', require('./backend/routes/usuario'));

const PORT = 3000;
app.listen(PORT, () => {
    console.log(`Servidor ejecutándose en http://localhost:${PORT}`);
});
