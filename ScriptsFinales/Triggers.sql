---- Triggers ----
-- Registrar insercion de estudiante --

USE Cooperativa;
GO

CREATE TRIGGER trg_Estudiante_Insert
ON Estudiantes
AFTER INSERT
AS
BEGIN
    INSERT INTO BitacoraAcceso (UsuarioID, Accion, Fecha)
    SELECT 
        i.UsuarioID, 
        'Creación de estudiante', 
        SYSDATETIME()
    FROM inserted i;
END;
GO

-- Registrar insercion de empleado  --

CREATE TRIGGER trg_Empleado_Insert
ON Empleado
AFTER INSERT
AS
BEGIN
    INSERT INTO BitacoraAcceso (UsuarioID, Accion, Fecha)
    SELECT 
        i.UsuarioID, 
        'Creación de empleado', 
        SYSDATETIME()
    FROM inserted i;
END;
GO

-- Registrar insercion de estudiante --

USE Cooperativa;
GO

CREATE TRIGGER trg_Conductor_Insert
ON Conductores
AFTER INSERT
AS
BEGIN
    INSERT INTO BitacoraAcceso (UsuarioID, Accion, Fecha)
    SELECT 
        i.UsuarioID, 
        'Creación de conductor', 
        SYSDATETIME()
    FROM inserted i;
END;
GO

-- Validar ocupacion vehiculo --

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

-- Registrar cambio de tarifa --

CREATE TRIGGER trg_Tarifa_Update
ON Tarifas
AFTER UPDATE
AS
BEGIN
    IF UPDATE(Monto)
    BEGIN
        INSERT INTO BitacoraAcceso (UsuarioID, Accion, Fecha)
        SELECT 
            1,  -- Usuario admin o generico
            CONCAT('Actualizacion de tarifa ID ', i.TarifaID, ': nuevo monto ', i.Monto),
            SYSDATETIME()
        FROM inserted i;
    END
END;
GO

-- Validar monto de pago --

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