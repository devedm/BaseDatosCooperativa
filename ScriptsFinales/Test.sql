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

-- 

------ Validacion Triggers ------