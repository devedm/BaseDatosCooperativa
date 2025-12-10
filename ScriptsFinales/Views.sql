---- Vistas ----

-- Vista de estudiantes con sus datos de usuario
CREATE VIEW Vista_Estudiantes_Usuarios AS
SELECT 
    E.EstudianteID,
    U.UsuarioID,
    U.Cedula,
    U.Nombre,
    U.Apellido,
    U.Telefono,
    U.Correo
FROM Estudiantes E
INNER JOIN Usuario U
    ON E.UsuarioID = U.UsuarioID;
GO

-- Vista de pagos por estudiante (incluye método y tarifa)
CREATE VIEW Vista_Pagos_Estudiantes AS
SELECT 
    P.PagoID,
    E.EstudianteID,
    dbo.fn_NombreCompletoUsuario(E.UsuarioID) AS NombreEstudiante,
    MP.Nombre AS MetodoPago,
    T.Monto AS MontoTarifaBase,
    P.Monto AS MontoPagado,
    P.FechaPago
FROM Pagos P
INNER JOIN Estudiantes E
    ON P.EstudianteID = E.EstudianteID
INNER JOIN MetodoPago MP
    ON P.MetodoPagoID = MP.MetodoPagoID
INNER JOIN Tarifas T
    ON P.TarifaID = T.TarifaID;
GO

-- Vista de conductores, su usuario y el estado de la licencia
CREATE VIEW Vista_Conductores_Licencia AS
SELECT 
    C.ConductorID,
    U.Cedula,
    U.Nombre,
    U.Apellido,
    L.NumeroLicencia,
    L.FechaExpiracion,
    dbo.fn_EstadoLicencia(C.ConductorID) AS EstadoLicencia
FROM Conductores C
INNER JOIN Usuario U
    ON C.UsuarioID = U.UsuarioID
LEFT JOIN Licencia L
    ON L.ConductorID = C.ConductorID;
GO

-- Vista de rutas con paradas y tarifas
CREATE VIEW Vista_Rutas_Paradas_Tarifas AS
SELECT 
    R.RutaID,
    R.NombreRuta,
    R.Descripcion AS DescripcionRuta,
    PA.ParadaID,
    PA.Nombre AS NombreParada,
    T.TarifaID,
    T.Monto,
    T.Descripcion AS DescripcionTarifa
FROM Rutas R
LEFT JOIN ParadasRutas PR
    ON R.RutaID = PR.RutaID
LEFT JOIN Paradas PA
    ON PR.ParadaID = PA.ParadaID
LEFT JOIN TarifasRutas TR
    ON R.RutaID = TR.RutaID
LEFT JOIN Tarifas T
    ON TR.TarifaID = T.TarifaID;
GO

-- Vista de incidencias de estudiantes con nombre
CREATE VIEW Vista_Incidencias_Estudiantes AS
SELECT 
    I.IncidenciaID,
    I.Fecha,
    I.Descripcion,
    E.EstudianteID,
    dbo.fn_NombreCompletoUsuario(E.UsuarioID) AS NombreEstudiante
FROM Incidencias I
INNER JOIN Estudiantes E
    ON I.EstudianteID = E.EstudianteID;
GO

-- Vista de mantenimiento de vehículos
CREATE VIEW Vista_Mantenimiento_Vehiculos AS
SELECT 
    M.MantenimientoID,
    V.VehiculoID,
    V.Placa,
    V.Capacidad,
    M.Fecha,
    M.Descripcion
FROM MantenimientoVehiculo M
INNER JOIN Vehiculos V
    ON M.VehiculoID = V.VehiculoID;
GO
