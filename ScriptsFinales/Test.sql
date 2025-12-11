------ Validacion de Inserts ------

SELECT TOP 20 * FROM Usuario;
SELECT TOP 20 * FROM Estudiantes;
SELECT TOP 20 * FROM Empleado;
SELECT TOP 20 * FROM Conductores;
SELECT TOP 20 * FROM Licencia;
SELECT TOP 20 * FROM Vehiculos;
SELECT TOP 20 * FROM Ocupacion;
SELECT TOP 20 * FROM Rutas;
SELECT TOP 20 * FROM Paradas;
SELECT TOP 20 * FROM Tarifas;
SELECT TOP 20 * FROM ParadasRutas;
SELECT TOP 20 * FROM TarifasRutas;
SELECT TOP 20 * FROM MetodoPago;
SELECT TOP 20 * FROM Pagos;
SELECT TOP 20 * FROM Incidencias;
SELECT TOP 20 * FROM MantenimientoVehiculo;
SELECT TOP 20 * FROM BitacoraAcceso;

------ Validacion de SP ------

-- sp_CrearUsuario
DECLARE @NuevoUsuarioID INT;

EXEC sp_CrearUsuario
    @Cedula = '123456789',
    @Nombre = 'UsuarioTest',
    @Apellido = 'Prueba',
    @Telefono = '88888888',
    @Correo = 'test@correo.com',
    @NuevoUsuarioID = @NuevoUsuarioID OUTPUT;

PRINT 'Nuevo UsuarioID generado: ' + CAST(@NuevoUsuarioID AS NVARCHAR(10));

SELECT * FROM Usuario WHERE UsuarioID = @NuevoUsuarioID;
GO

-- sp_CrearEstudiante
EXEC sp_CrearEstudiante
     @Cedula='111111111',
     @Nombre='Ana',
     @Apellido='Lopez',
     @Telefono='88887777',
     @Correo='ana@test.com';

SELECT TOP 5 * FROM Usuario ORDER BY UsuarioID DESC;
SELECT TOP 5 * FROM Estudiantes ORDER BY EstudianteID DESC;
GO

-- sp_CrearConductor
EXEC sp_CrearConductor
     @Cedula='333333333',
     @Nombre='Luis',
     @Apellido='Solano',
     @Telefono='87878787',
     @Correo='luis@test.com',
     @NumeroLicencia='LIC123',
     @FechaExpiracion='2030-05-10';

SELECT TOP 5 * FROM Conductores ORDER BY ConductorID DESC;
SELECT TOP 5 * FROM Licencia ORDER BY LicenciaID DESC;
GO

-- sp_ConsultarEstudiantePorCedula
EXEC sp_ConsultarEstudiantePorCedula @Cedula='111111111';

-- sp_ConsultarConductorPorCedula
EXEC sp_ConsultarConductorPorCedula @Cedula='333333333';

-- sp_ConsultarEmpleadoPorCedula
EXEC sp_ConsultarEmpleadoPorCedula @Cedula='222222222';

-- Prueba con cédula inexistente
EXEC sp_ConsultarEstudiantePorCedula @Cedula='999999999';
GO

-- sp_CrearIncidencia
EXEC sp_CrearIncidencia
     @Cedula='111111111',
     @RutaID=1,
     @Fecha='2024-10-01',
     @Descripcion='Estudiante llegó tarde.';

-- ! -- Prueba con estudiante inexistente
EXEC sp_CrearIncidencia
     @Cedula='000000000',
     @RutaID=1,
     @Fecha='2024-10-01',
     @Descripcion='No debería funcionar.';

-- ! -- Prueba con ruta inexistente
EXEC sp_CrearIncidencia
     @Cedula='111111111',
     @RutaID=999,
     @Fecha='2024-10-01',
     @Descripcion='Ruta incorrecta.';
GO

SELECT TOP 5 * FROM Incidencias ORDER BY IncidenciaID DESC;

-- sp_InsertarVehiculo
EXEC sp_InsertarVehiculo
     @Placa='AAA123',
     @Capacidad=20;

SELECT * FROM Vehiculos WHERE Placa='AAA123';

-- ! -- Pruebas de error
EXEC sp_InsertarVehiculo @Placa=NULL, @Capacidad=20;
EXEC sp_InsertarVehiculo @Placa='   ', @Capacidad=20;
EXEC sp_InsertarVehiculo @Placa='AAA123', @Capacidad=20; -- duplicado
EXEC sp_InsertarVehiculo @Placa='BBB456', @Capacidad=0;  -- capacidad inválida
GO

-- sp_InsertarTarifa
EXEC sp_InsertarTarifa
     @Monto=1500,
     @Descripcion='Tarifa mensual';

SELECT TOP 5 * FROM Tarifas ORDER BY TarifaID DESC;

-- Pruebas de error
EXEC sp_InsertarTarifa @Monto=0, @Descripcion='Error Monto';
EXEC sp_InsertarTarifa @Monto=2000, @Descripcion='   ';
EXEC sp_InsertarTarifa @Monto=1500, @Descripcion='Tarifa mensual'; -- duplicado
GO
-- sp_InsertarPago
DECLARE @EstudianteID INT = (SELECT TOP 1 EstudianteID FROM Estudiantes ORDER BY EstudianteID DESC);
DECLARE @TarifaID INT = (SELECT TOP 1 TarifaID FROM Tarifas ORDER BY TarifaID DESC);
DECLARE @MetodoPagoID INT = (SELECT TOP 1 MetodoPagoID FROM MetodoPago ORDER BY MetodoPagoID DESC);

EXEC sp_InsertarPago
     @EstudianteID=@EstudianteID,
     @MetodoPagoID=@MetodoPagoID,
     @TarifaID=@TarifaID,
     @Monto=1500;

SELECT TOP 5 * FROM Pagos ORDER BY PagoID DESC;

-- ! -- Pruebas de error
EXEC sp_InsertarPago @EstudianteID=9999, @MetodoPagoID=@MetodoPagoID, @TarifaID=@TarifaID, @Monto=1500;
EXEC sp_InsertarPago @EstudianteID=@EstudianteID, @MetodoPagoID=9999, @TarifaID=@TarifaID, @Monto=1500;
EXEC sp_InsertarPago @EstudianteID=@EstudianteID, @MetodoPagoID=@MetodoPagoID, @TarifaID=9999, @Monto=1500;
EXEC sp_InsertarPago @EstudianteID=@EstudianteID, @MetodoPagoID=@MetodoPagoID, @TarifaID=@TarifaID, @Monto=0;
GO

------ Validacion Funciones ------

-- Datos para pruebas

DECLARE @UsuarioID INT = (SELECT TOP 1 UsuarioID FROM Usuario ORDER BY UsuarioID DESC);
DECLARE @EstudianteID INT = (SELECT TOP 1 EstudianteID FROM Estudiantes ORDER BY EstudianteID DESC);
DECLARE @ConductorID INT = (SELECT TOP 1 ConductorID FROM Conductores ORDER BY ConductorID DESC);
DECLARE @VehiculoID INT = (SELECT TOP 1 VehiculoID FROM Vehiculos ORDER BY VehiculoID DESC);
DECLARE @TarifaID INT = (SELECT TOP 1 TarifaID FROM Tarifas ORDER BY TarifaID DESC);

PRINT 'Datos para pruebas:';
PRINT 'UsuarioID: ' + CAST(ISNULL(@UsuarioID,0) AS NVARCHAR(10));
PRINT 'EstudianteID: ' + CAST(ISNULL(@EstudianteID,0) AS NVARCHAR(10));
PRINT 'ConductorID: ' + CAST(ISNULL(@ConductorID,0) AS NVARCHAR(10));
PRINT 'VehiculoID: ' + CAST(ISNULL(@VehiculoID,0) AS NVARCHAR(10));
PRINT 'TarifaID: ' + CAST(ISNULL(@TarifaID,0) AS NVARCHAR(10));
GO

-- fn_NombreCompletoUsuario

SELECT dbo.fn_NombreCompletoUsuario(@UsuarioID) AS NombreCompleto_Valido;
SELECT dbo.fn_NombreCompletoUsuario(999999) AS NombreCompleto_Invalido;
GO

-- Probando fn_TotalPagadoPorEstudiante

SELECT dbo.fn_TotalPagadoPorEstudiante(@EstudianteID) AS TotalPagado_Valido;
SELECT dbo.fn_TotalPagadoPorEstudiante(999999) AS TotalPagado_Invalido;  -- debería devolver 0
GO

-- Probando fn_EstadoLicencia

SELECT dbo.fn_EstadoLicencia(@ConductorID) AS Estado_Valido;
SELECT dbo.fn_EstadoLicencia(999999) AS Estado_Inexistente; -- debe ser "SIN REGISTRO"
GO

-- Probando fn_CantidadIncidenciasEstudiante

SELECT dbo.fn_CantidadIncidenciasEstudiante(@EstudianteID) AS Incidencias_Validas;
SELECT dbo.fn_CantidadIncidenciasEstudiante(999999) AS Incidencias_Invalidas; -- debería ser 0
GO

-- Probando fn_CapacidadDisponibleVehiculo

-- Ingreso de ocupación mínima para probar
INSERT INTO Ocupacion (VehiculoID, NombrePasajero)
VALUES (@VehiculoID, 'Pasajero Temporal');

SELECT dbo.fn_CapacidadDisponibleVehiculo(@VehiculoID) AS CapacidadDisponible;

-- ! -- Vehículo inexistente
SELECT dbo.fn_CapacidadDisponibleVehiculo(999999) AS CapacidadDisponible_Inexistente;
GO

-- Probando fn_TarifaConDescuento

SELECT dbo.fn_TarifaConDescuento(@TarifaID, 10) AS Tarifa_Con_10pct;
SELECT dbo.fn_TarifaConDescuento(@TarifaID, 50) AS Tarifa_Con_50pct;
SELECT dbo.fn_TarifaConDescuento(999999, 10) AS Tarifa_Inexistente; -- debería devolver 0
GO

-- Probando fn_UltimoAccesoUsuario

-- ! -- Ingresar accesos de prueba si no existen
INSERT INTO BitacoraAcceso (UsuarioID, Fecha)
VALUES (@UsuarioID, GETDATE());

SELECT dbo.fn_UltimoAccesoUsuario(@UsuarioID) AS UltimoAcceso_Valido;
SELECT dbo.fn_UltimoAccesoUsuario(999999) AS UltimoAcceso_Inexistente; -- debe ser NULL
GO


------ Validacion Vistas ------

-- Datos para pruebas
DECLARE @EstudianteID INT = (SELECT TOP 1 EstudianteID FROM Estudiantes ORDER BY EstudianteID DESC);
DECLARE @ConductorID INT = (SELECT TOP 1 ConductorID FROM Conductores ORDER BY ConductorID DESC);
DECLARE @VehiculoID INT = (SELECT TOP 1 VehiculoID FROM Vehiculos ORDER BY VehiculoID DESC);
DECLARE @RutaID INT = (SELECT TOP 1 RutaID FROM Rutas ORDER BY RutaID DESC);
GO

-- Probando Vista_Estudiantes_Usuarios ---';

SELECT TOP 20 * FROM Vista_Estudiantes_Usuarios;

-- Filtro por uno existente
IF @EstudianteID IS NOT NULL
    SELECT * FROM Vista_Estudiantes_Usuarios WHERE EstudianteID = @EstudianteID;
GO

-- Probando Vista_Pagos_Estudiantes

SELECT TOP 20 * FROM Vista_Pagos_Estudiantes ORDER BY FechaPago DESC;

-- Filtro por estudiante
IF @EstudianteID IS NOT NULL
    SELECT * FROM Vista_Pagos_Estudiantes WHERE EstudianteID = @EstudianteID;
GO

-- Probando Vista_Conductores_Licencia

SELECT TOP 20 * FROM Vista_Conductores_Licencia;

-- Filtro por conductor
IF @ConductorID IS NOT NULL
    SELECT * FROM Vista_Conductores_Licencia WHERE ConductorID = @ConductorID;
GO

-- Probando Vista_Rutas_Paradas_Tarifas

-- Crear una parada si no existen
IF NOT EXISTS (SELECT 1 FROM Paradas)
BEGIN
    INSERT INTO Paradas (Nombre) VALUES ('Parada Central');
END

-- Crear una relación Ruta-Parada
IF NOT EXISTS (
    SELECT 1 FROM ParadasRutas WHERE RutaID = @RutaID
)
BEGIN
    DECLARE @ParadaID INT = (SELECT TOP 1 ParadaID FROM Paradas ORDER BY ParadaID DESC);
    INSERT INTO ParadasRutas (RutaID, ParadaID) VALUES (@RutaID, @ParadaID);
END

-- Crear una relación Ruta-Tarifa
IF NOT EXISTS (
    SELECT 1 FROM TarifasRutas WHERE RutaID = @RutaID
)
BEGIN
    DECLARE @TarifaIDTest INT = (SELECT TOP 1 TarifaID FROM Tarifas ORDER BY TarifaID DESC);
    INSERT INTO TarifasRutas (RutaID, TarifaID) VALUES (@RutaID, @TarifaIDTest);
END

-- Consultar vista
SELECT TOP 50 * FROM Vista_Rutas_Paradas_Tarifas ORDER BY RutaID;
GO

-- Probando Vista_Incidencias_Estudiantes
SELECT TOP 20 * FROM Vista_Incidencias_Estudiantes ORDER BY Fecha DESC;

-- Filtro por estudiante
IF @EstudianteID IS NOT NULL
    SELECT * FROM Vista_Incidencias_Estudiantes WHERE EstudianteID = @EstudianteID;
GO

-- Probando Vista_Mantenimiento_Vehiculos

IF NOT EXISTS (
    SELECT 1 FROM MantenimientoVehiculo WHERE VehiculoID = @VehiculoID
)
BEGIN
    INSERT INTO MantenimientoVehiculo (VehiculoID, Fecha, Descripcion)
    VALUES (@VehiculoID, GETDATE(), 'Mantenimiento preventivo');
END

SELECT TOP 20 * FROM Vista_Mantenimiento_Vehiculos ORDER BY Fecha DESC;

-- Filtro por vehículo
IF @VehiculoID IS NOT NULL
    SELECT * FROM Vista_Mantenimiento_Vehiculos WHERE VehiculoID = @VehiculoID;
GO


------ Validacion Triggers ------


-- trg_Estudiante_Insert
SELECT TOP 10 * FROM BitacoraAcceso ORDER BY Fecha DESC;
GO

-- trg_Empleado_Insert
SELECT TOP 10 * FROM BitacoraAcceso ORDER BY Fecha DESC;
GO

--trg_Conductor_Insert
SELECT TOP 10 * FROM BitacoraAcceso ORDER BY Fecha DESC;
GO

--trg_Ocupacion_ValidarCapacidad';

BEGIN TRY
    BEGIN TRANSACTION;

        -- El sistema aceptará la primera inserción
        INSERT INTO Ocupacion (VehiculoID, UsuarioID) VALUES (1, 1);

        -- Este INSERT forzado podría superar la capacidad
        INSERT INTO Ocupacion (VehiculoID, UsuarioID) VALUES (1, 2);

    COMMIT TRANSACTION;
END TRY
BEGIN CATCH
    PRINT 'Error esperado -> Trigger de capacidad funcionó correctamente';
    ROLLBACK TRANSACTION;
END CATCH;

PRINT 'OK -> trg_Ocupacion_ValidarCapacidad probado';
GO

 -- trg_Tarifa_Update
BEGIN TRANSACTION;
    UPDATE Tarifas
    SET Monto = Monto + 100
    WHERE TarifaID = 1;
COMMIT;

SELECT * FROM BitacoraAcceso ORDER BY Fecha DESC;

PRINT 'OK -> trg_Tarifa_Update probado';
GO

--trg_Pagos_ValidarMonto

BEGIN TRY
    BEGIN TRANSACTION;
        INSERT INTO Pagos (EstudianteID, MetodoPagoID, TarifaID, Monto, FechaPago)
        VALUES (1, 1, 1, 0, SYSDATETIME()); -- Inválido, debe fallar
    COMMIT TRANSACTION;
END TRY
BEGIN CATCH
    PRINT 'Error esperado -> Monto <= 0 correctamente detectado por trigger';
    ROLLBACK TRANSACTION;
END CATCH;

PRINT 'OK -> trg_Pagos_ValidarMonto probado';
GO