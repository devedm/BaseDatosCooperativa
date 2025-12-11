const db = require('../../db');

exports.getUsuario = async (req, res) => {
    try {
        const pool = await db.connect();
        const result = await pool.request().query("SELECT * FROM Usuario");
        res.json(result.recordset);
    } catch (err) {
        res.status(500).json({ error: err.message });
    }
};

exports.createUsuario = async (req, res) => {
    try {
        const { Cedula, Nombre, Apellido, Telefono, Correo } = req.body;
        const pool = await db.connect();
        await pool.request()
            .input("Cedula", db.sql.Char(9), Cedula)
            .input("Nombre", db.sql.NVarChar(50), Nombre)
            .input("Apellido", db.sql.NVarChar(50), Apellido)
            .input("Telefono", db.sql.NVarChar(8), Telefono)
            .input("Correo", db.sql.NVarChar(50), Correo)
            .query(`
                INSERT INTO Usuario (Cedula, Nombre, Apellido, Telefono, Correo)
                VALUES (@Cedula, @Nombre, @Apellido, @Telefono, @Correo)
            `);

        res.json({ message: "Usuario creado" });
    } catch (err) {
        res.status(500).json({ error: err.message });
    }
};

exports.updateUsuario = async (req, res) => {
    try {
        const { id } = req.params;
        const { Nombre, Apellido, Telefono, Correo } = req.body;
        const pool = await db.connect();

        await pool.request()
            .input("id", db.sql.Int, id)
            .input("Nombre", db.sql.NVarChar(50), Nombre)
            .input("Apellido", db.sql.NVarChar(50), Apellido)
            .input("Telefono", db.sql.NVarChar(8), Telefono)
            .input("Correo", db.sql.NVarChar(50), Correo)
            .query(`
                UPDATE Usuario SET 
                Nombre=@Nombre,
                Apellido=@Apellido,
                Telefono=@Telefono,
                Correo=@Correo
                WHERE UsuarioID=@id
            `);

        res.json({ message: "Usuario actualizado" });
    } catch (err) {
        res.status(500).json({ error: err.message });
    }
};

exports.deleteUsuario = async (req, res) => {
    try {
        const { id } = req.params;
        const pool = await db.connect();

        await pool.request()
            .input("id", db.sql.Int, id)
            .query("DELETE FROM Usuario WHERE UsuarioID=@id");

        res.json({ message: "Usuario eliminado" });
    } catch (err) {
        res.status(500).json({ error: err.message });
    }
};
