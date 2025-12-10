---- Stored Procedores ----

-- Crear Usuario --
-- Crear un nuevo usuario con sus datos básicos, se va utilizar por otros SP nunca directamente--

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

-- Insertar Estudiante --
-- SP para insertar un estudiante y al mismo tiempo crear un usuario usando sp_CrearUsuario
USE Cooperativa;
GO

CREATE PROCEDURE sp_CrearEstudiante
    @Cedula CHAR(9),
    @Nombre NVARCHAR(50),
    @Apellido NVARCHAR(50),
    @Telefono NVARCHAR(8),
    @Correo NVARCHAR(50)
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

    INSERT INTO Estudiantes (UsuarioID)
    VALUES (@UserID);
END;
GO

-- Insertar Empleado --
-- SP para insertar un empleado y al mismo tiempo crear un usuario usando sp_CrearUsuario
USE Cooperativa;
GO

CREATE PROCEDURE sp_CrearEmpleado
    @Cedula CHAR(9),
    @Nombre NVARCHAR(50),
    @Apellido NVARCHAR(50),
    @Telefono NVARCHAR(8),
    @Correo NVARCHAR(50)
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

    INSERT INTO Empleado (UsuarioID)
    VALUES (@UserID);
END;
GO

-- Insertar Conductor --
-- SP para insertar un conductor y al mismo tiempo crear un usuario usando sp_CrearUsuario
USE Cooperativa;
GO

CREATE PROCEDURE sp_CrearConductor
    @Cedula CHAR(9),
    @Nombre NVARCHAR(50),
    @Apellido NVARCHAR(50),
    @Telefono NVARCHAR(8),
    @Correo NVARCHAR(50),
    @NumeroLicencia NVARCHAR(20),
    @FechaExpiracion DATE
AS
BEGIN
    DECLARE @UserID INT, @ConductorID INT;

    EXEC sp_CrearUsuario
        @Cedula = @Cedula,
        @Nombre = @Nombre,
        @Apellido = @Apellido,
        @Telefono = @Telefono,
        @Correo = @Correo,
        @NuevoUsuarioID = @UserID OUTPUT;

    INSERT INTO Conductores (UsuarioID)
    VALUES (@UserID);

    SET @ConductorID = SCOPE_IDENTITY();

    INSERT INTO Licencia (NumeroLicencia, FechaExpiracion, ConductorID)
    VALUES (@NumeroLicencia, @FechaExpiracion, @ConductorID);
END;
GO

-- Buscar Estudiantes por Cedula --
-- SP para buscar estudiante por cedula
USE Cooperativa;
GO

CREATE PROCEDURE sp_ConsultarEstudiantePorCedula
    @Cedula CHAR(9)
AS
BEGIN
    SELECT 
        e.EstudianteID,
        u.UsuarioID,
        u.Cedula,
        u.Nombre,
        u.Apellido,
        u.Telefono,
        u.Correo
    FROM Estudiantes e
    INNER JOIN Usuario u ON e.UsuarioID = u.UsuarioID
    WHERE u.Cedula = @Cedula;
END;
GO

-- Buscar Conductor por Cedula --
-- SP para buscar conductor por cedula
USE Cooperativa;
GO

CREATE PROCEDURE sp_ConsultarConductorPorCedula
    @Cedula CHAR(9)
AS
BEGIN
    SELECT 
        c.ConductorID,
        u.UsuarioID,
        u.Cedula,
        u.Nombre,
        u.Apellido,
        u.Telefono,
        u.Correo
    FROM Conductores c
    INNER JOIN Usuario u ON c.UsuarioID = u.UsuarioID
    WHERE u.Cedula = @Cedula;
END;
GO

-- Buscar Empleado por Cedula --
-- SP para buscar empleado por cedula
USE Cooperativa;
GO

CREATE PROCEDURE sp_ConsultarEmpleadoPorCedula
    @Cedula CHAR(9)
AS
BEGIN
    SELECT 
        e.EmpleadoID,
        u.UsuarioID,
        u.Cedula,
        u.Nombre,
        u.Apellido,
        u.Telefono,
        u.Correo
    FROM Empleado e
    INNER JOIN Usuario u ON e.UsuarioID = u.UsuarioID
    WHERE u.Cedula = @Cedula;
END;
GO

-- Crear Incidencia --
-- SP para crear una incidencia con toda la informacion necesaria y luego la 
USE Cooperativa;
GO

CREATE PROCEDURE sp_CrearIncidencia
    @Cedula CHAR(9),
    @RutaID INT,
    @Fecha DATE,
    @Descripcion NVARCHAR(200)
AS
BEGIN
    DECLARE @EstudianteID INT;

    SELECT @EstudianteID = e.EstudianteID
    FROM Estudiantes e
    INNER JOIN Usuario u ON e.UsuarioID = u.UsuarioID
    WHERE u.Cedula = @Cedula;

    -- Validar Estudiante
    IF @EstudianteID IS NULL
    BEGIN
        PRINT 'No existe un estudiante con la cédula indicada';
        RETURN;
    END

    -- Validar Ruta
    IF NOT EXISTS (SELECT 1 FROM Rutas WHERE RutaID = @RutaID)
    BEGIN
        PRINT 'La ruta no existe';
        RETURN;
    END

    INSERT INTO Incidencias (EstudianteID, CodigoRuta, Fecha, Descripcion)
    VALUES (@EstudianteID, @RutaID, @Fecha, @Descripcion);

    DECLARE @IncidenciaID INT = SCOPE_IDENTITY();

    SELECT 
        i.IncidenciaID,
        i.EstudianteID,
        u.Nombre,
        u.Apellido,
        u.Cedula,
        i.CodigoRuta AS RutaID,
        r.NombreRuta,
        i.Fecha,
        i.Descripcion
    FROM Incidencias i
    INNER JOIN Estudiantes e ON i.EstudianteID = e.EstudianteID
    INNER JOIN Usuario u ON e.UsuarioID = u.UsuarioID
    INNER JOIN Rutas r ON r.RutaID = i.CodigoRuta
    WHERE i.IncidenciaID = @IncidenciaID;
END;
GO

-- Insertar Vehiculo --
-- SP para insertar vehiculo validando la placa y capacidad
USE Cooperativa;
GO

CREATE PROCEDURE sp_InsertarVehiculo
    @Placa NVARCHAR(20),
    @Capacidad INT
AS
BEGIN

    -- Validar placa
    IF @Placa IS NULL OR LTRIM(RTRIM(@Placa)) = ''
    BEGIN
        PRINT 'La placa no es valida';
        RETURN;
    END

    -- Validar capacidad
    IF @Capacidad IS NULL OR @Capacidad <= 0
    BEGIN
        PRINT 'La capacidad debe ser mayor a 0';
        RETURN;
    END

    -- Validar duplicado
    IF EXISTS (SELECT 1 FROM Vehiculos WHERE Placa = @Placa)
    BEGIN
        PRINT 'Ya existe un vehículo con esta placa';
        RETURN;
    END

    -- Insertar
    INSERT INTO Vehiculos (Placa, Capacidad)
    VALUES (@Placa, @Capacidad);

    PRINT 'Vehiculo insertado correctamente';
END;
GO

-- Insertar Tarifa --
-- SP para insertar Tarifa
USE Cooperativa;
GO

CREATE PROCEDURE sp_InsertarTarifa
    @Monto DECIMAL(10,2),
    @Descripcion NVARCHAR(100)
AS
BEGIN
    SET NOCOUNT ON;

    -- Validar monto
    IF @Monto IS NULL OR @Monto <= 0
    BEGIN
        PRINT 'El monto debe ser mayor a 0';
        RETURN;
    END

    -- Validar descripción
    IF @Descripcion IS NULL OR LTRIM(RTRIM(@Descripcion)) = ''
    BEGIN
        PRINT 'La descripción no puede estar vacía';
        RETURN;
    END

    -- Validar tarifa duplicada
    IF EXISTS (SELECT 1 FROM Tarifas WHERE Monto = @Monto AND Descripcion = @Descripcion)
    BEGIN
        PRINT 'Ya existe una tarifa con el mismo monto y descripción';
        RETURN;
    END

    -- Insertar tarifa
    INSERT INTO Tarifas (Monto, Descripcion)
    VALUES (@Monto, @Descripcion);

    PRINT 'Tarifa insertada correctamente';
END;
GO

-- Insertar Pago --
-- SP para insertar Pago
USE Cooperativa;
GO

CREATE PROCEDURE sp_InsertarPago
    @EstudianteID INT,
    @MetodoPagoID INT,
    @TarifaID INT,
    @Monto DECIMAL(10,2)
AS
BEGIN
    -- Validar estudiante
    IF NOT EXISTS (SELECT 1 FROM Estudiantes WHERE EstudianteID = @EstudianteID)
    BEGIN
        PRINT 'El EstudianteID no existe';
        RETURN;
    END

    -- Validar método de pago
    IF NOT EXISTS (SELECT 1 FROM MetodoPago WHERE MetodoPagoID = @MetodoPagoID)
    BEGIN
        PRINT 'El Método de Pago no existe';
        RETURN;
    END

    -- Validar tarifa
    IF NOT EXISTS (SELECT 1 FROM Tarifas WHERE TarifaID = @TarifaID)
    BEGIN
        PRINT 'La tarifa indicada no existe';
        RETURN;
    END
    -- Validar monto
    IF @Monto IS NULL OR @Monto <= 0
    BEGIN
        PRINT 'El monto debe ser mayor a 0';
        RETURN;
    END

    -- Insertar pago
    INSERT INTO Pagos (EstudianteID, MetodoPagoID, TarifaID, Monto, FechaPago)
    VALUES (@EstudianteID, @MetodoPagoID, @TarifaID, @Monto, GETDATE());

    PRINT 'Pago registrado correctamente';
END;
GO

