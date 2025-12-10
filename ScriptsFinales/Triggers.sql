-- BitacoraAcceso --
CREATE TRIGGER trg_Usuario_Insert
ON Usuario
AFTER INSERT
AS
BEGIN
    INSERT INTO BitacoraAcceso (UsuarioID, Accion, Fecha)
    SELECT i.UsuarioID, 'Creacion de usuario', SYSDATETIME()
    FROM inserted i;
END;
GO


CREATE TRIGGER trg_Ocupacion_ValidarCapacidad
ON Ocupacion
AFTER INSERT
AS
BEGIN
    IF EXISTS (
        SELECT 1
        FROM inserted i
        JOIN Vehiculos v ON i.VehiculoID = v.VehiculoID
        GROUP BY i.VehiculoID, v.Capacidad
        HAVING COUNT(*) > v.Capacidad
    )
    BEGIN
        RAISERROR ('Este vehiculo ya alcanzo su capacidad maxima.', 16, 1);
        ROLLBACK TRANSACTION;
    END
END;
GO

CREATE TRIGGER trg_Mantenimiento_RegistroIncidencia
ON MantenimientoVehiculo
AFTER INSERT
AS
BEGIN
    INSERT INTO Incidencias (EstudianteID, Fecha, Descripcion)
    SELECT NULL, i.Fecha, CONCAT('Mantenimiento aplicado al veh�culo ID ', i.VehiculoID)
    FROM inserted i;
END;
GO

CREATE TRIGGER trg_Tarifa_Update
ON Tarifas
AFTER UPDATE
AS
BEGIN
    IF UPDATE(Monto)
    BEGIN
        INSERT INTO BitacoraAcceso (UsuarioID, Accion, Fecha)
        SELECT 
            1,  -- Usuario admin o gen�rico
            CONCAT('Actualizaci�n de tarifa ID ', i.TarifaID, ': nuevo monto ', i.Monto),
            SYSDATETIME()
        FROM inserted i;
    END
END;
GO


CREATE TRIGGER trg_Pagos_ValidarMonto
ON Pagos
FOR INSERT
AS
BEGIN
    IF EXISTS (SELECT 1 FROM inserted WHERE Monto <= 0)
    BEGIN
        RAISERROR ('El monto del pago debe ser mayor a cero.', 16, 1);
        ROLLBACK TRANSACTION;
    END
END;
GO
