-- Prueba sp_CrearEstudiante --
EXEC sp_CrearEstudiante
    @Cedula = '111111111',
    @Nombre = 'Ana',
    @Apellido = 'Soto',
    @Telefono = '88881234',
    @Correo = 'ana@example.com';

SELECT * FROM Usuario;
SELECT * FROM Estudiantes;