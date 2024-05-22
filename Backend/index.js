// index.js
const express = require('express');
const http = require('http');
const socketIo = require('socket.io');

const app = express();
const server = http.createServer(app);
const io = socketIo(server, {
    cors: {
        origin: '*',
    }
});

// Pone a disposición la carpeta de frontend (si ya está construida)
app.use(express.static('public'));



// Inicia el servidor
const PORT = process.env.PORT || 3000;
server.listen(PORT, () => {
    console.log(`Servidor escuchando en http://localhost:${PORT}`);
});
