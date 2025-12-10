-- Stored Procedores --

-- Insertar Usuario --
-- Inserta un nuevo usuario con sus datos básicos, se va utilizar por otros SP nunca directamente--

CREATE PROCEDURE sp_CrearUsuario
    @Cedula CHAR(9),
    @Nombre NVARCHAR(50),
    @Apellido NVARCHAR(50),
    @Telefono NVARCHAR(8),
    @Correo NVARCHAR(50),
    @NuevoUsuarioID INT OUTPUT
AS
BEGIN
    INSERT INTO Usuario (Cedula, Nombre, Apellido, Telefono, Correo)
    VALUES (@Cedula, @Nombre, @Apellido, @Telefono, @Correo);

    SET @NuevoUsuarioID = SCOPE_IDENTITY();
END;
GO

-- Consultar Informacion de Usuario --
-- Consulta la información de un usuario según su ID

USE Cooperativa;
GO

CREATE PROCEDURE sp_ObtenerUsuarioPorID
    @UsuarioID INT
AS
BEGIN
    SELECT * FROM Usuario
    WHERE UsuarioID = @UsuarioID;
END;
GO

-- Insertar Estudiante --

USE Cooperativa;
GO

CREATE PROCEDURE sp_CrearEstudiante
    @Cedula CHAR(9),
    @Nombre NVARCHAR(50),
    @Apellido NVARCHAR(50),
    @Telefono NVARCHAR(8),
    @Correo NVARCHAR(50),
    @Carrera NVARCHAR(50),
    @Nivel INT
AS
BEGIN
    DECLARE @UserID INT;

    EXEC sp_CrearUsuario
        @Cedula = @Cedula,
        @Nombre = @Nombre,
        @Apellido = @Apellido,
        @Telefono = @Telefono,
        @Correo = @Correo,
        @NuevoUsuarioID = @UserID OUTPUT;

    INSERT INTO Estudiantes (UsuarioID, Carrera, Nivel)
    VALUES (@UserID, @Carrera, @Nivel);
END;
GO

-- Insertar Usuario --

USE Cooperativa;
GO

CREATE PROCEDURE sp_InsertarEstudiante
    @UsuarioID INT
AS
BEGIN
    INSERT INTO Estudiantes (UsuarioID)
    VALUES (@UsuarioID);
END;
GO
-- Insertar Usuario --

-- Insertar Usuario --

-- Insertar Usuario --

-- Insertar Usuario --

-- Insertar Usuario --

-- Insertar Usuario --

-- Insertar Usuario --

-- Insertar Usuario --

-- Insertar Usuario --

-- Insertar Usuario --

-- Insertar Usuario --

-- Insertar Usuario --

-- Insertar Usuario --

-- Insertar Usuario --

-- Insertar Usuario --

-- Insertar Usuario --

-- Insertar Usuario --
