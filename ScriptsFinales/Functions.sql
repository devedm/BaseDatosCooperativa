---- Funciones ----

-- Nombre completo del usuario
CREATE FUNCTION fn_NombreCompletoUsuario (@UsuarioID INT)
RETURNS NVARCHAR(120)
AS
BEGIN
    DECLARE @NombreCompleto NVARCHAR(120);

    SELECT @NombreCompleto = CONCAT(Nombre, N' ', Apellido)
    FROM Usuario
    WHERE UsuarioID = @UsuarioID;

    RETURN @NombreCompleto;
END;
GO

-- Total pagado por un estudiante
CREATE FUNCTION fn_TotalPagadoPorEstudiante (@EstudianteID INT)
RETURNS DECIMAL(10,2)
AS
BEGIN
    DECLARE @Total DECIMAL(10,2);

    SELECT @Total = ISNULL(SUM(Monto),0)
    FROM Pagos
    WHERE EstudianteID = @EstudianteID;

    RETURN @Total;
END;
GO

-- Estado de la licencia (VIGENTE / VENCIDA)
CREATE FUNCTION fn_EstadoLicencia (@ConductorID INT)
RETURNS NVARCHAR(20)
AS
BEGIN
    DECLARE @Estado NVARCHAR(20);

    SELECT @Estado =
        CASE 
            WHEN FechaExpiracion IS NULL THEN N'SIN LICENCIA'
            WHEN FechaExpiracion < CAST(GETDATE() AS DATE) THEN N'VENCIDA'
            ELSE N'VIGENTE'
        END
    FROM Licencia
    WHERE ConductorID = @ConductorID;

    IF (@Estado IS NULL)
        SET @Estado = N'SIN REGISTRO';

    RETURN @Estado;
END;
GO

-- Cantidad de incidencias de un estudiante
CREATE FUNCTION fn_CantidadIncidenciasEstudiante (@EstudianteID INT)
RETURNS INT
AS
BEGIN
    DECLARE @Cantidad INT;

    SELECT @Cantidad = COUNT(*)
    FROM Incidencias
    WHERE EstudianteID = @EstudianteID;

    RETURN @Cantidad;
END;
GO

-- Capacidad disponible de un vehículo
CREATE FUNCTION fn_CapacidadDisponibleVehiculo (@VehiculoID INT)
RETURNS INT
AS
BEGIN
    DECLARE @Capacidad INT;
    DECLARE @Ocupados INT;

    SELECT @Capacidad = Capacidad
    FROM Vehiculos
    WHERE VehiculoID = @VehiculoID;

    SELECT @Ocupados = COUNT(*)
    FROM Ocupacion
    WHERE VehiculoID = @VehiculoID;

    IF (@Capacidad IS NULL) SET @Capacidad = 0;
    IF (@Ocupados IS NULL)  SET @Ocupados = 0;

    RETURN @Capacidad - @Ocupados;
END;
GO

-- Monto de tarifa con descuento (%)
CREATE FUNCTION fn_TarifaConDescuento (
    @TarifaID INT,
    @PorcentajeDescuento DECIMAL(5,2)
)
RETURNS DECIMAL(10,2)
AS
BEGIN
    DECLARE @Monto DECIMAL(10,2);

    SELECT @Monto = Monto
    FROM Tarifas
    WHERE TarifaID = @TarifaID;

    IF (@Monto IS NULL)
        SET @Monto = 0;

    RETURN @Monto - (@Monto * @PorcentajeDescuento / 100);
END;
GO

-- Último acceso registrado para un usuario
CREATE FUNCTION fn_UltimoAccesoUsuario (@UsuarioID INT)
RETURNS DATETIME2(0)
AS
BEGIN
    DECLARE @Fecha DATETIME2(0);

    SELECT @Fecha = MAX(Fecha)
    FROM BitacoraAcceso
    WHERE UsuarioID = @UsuarioID;

    RETURN @Fecha;
END;
GO