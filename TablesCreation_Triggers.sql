-- Creacion de Tablas
CREATE DATABASE Cooperativa;
GO
USE Cooperativa;
GO

-- Usuario --
CREATE TABLE Usuario (
    UsuarioID INT PRIMARY KEY IDENTITY(1,1),
    Cedula CHAR(9) NOT NULL CHECK (Cedula NOT LIKE '%[^0-9]%'),
    Nombre NVARCHAR(50),
    Apellido NVARCHAR(50),
    Telefono NVARCHAR(8),
    Correo NVARCHAR(50)
);

-- Estudiantes --
CREATE TABLE Estudiantes (
    EstudianteID INT PRIMARY KEY IDENTITY(1,1),
    UsuarioID INT NOT NULL,
    FOREIGN KEY (UsuarioID) REFERENCES Usuario(UsuarioID)
);

-- Empleado --
CREATE TABLE Empleado (
    EmpleadoID INT PRIMARY KEY IDENTITY(1,1),
    UsuarioID INT UNIQUE NOT NULL,
    FOREIGN KEY (UsuarioID) REFERENCES Usuario(UsuarioID)
);

-- Conductores --
CREATE TABLE Conductores (
    ConductorID INT PRIMARY KEY IDENTITY(1,1),
    UsuarioID INT NOT NULL,
    FOREIGN KEY (UsuarioID) REFERENCES Usuario(UsuarioID)
);

-- Licencia --
CREATE TABLE Licencia (
    LicenciaID INT PRIMARY KEY IDENTITY(1,1),
    NumeroLicencia NVARCHAR(20) UNIQUE,
    FechaExpiracion DATE,
    ConductorID INT UNIQUE,
    FOREIGN KEY (ConductorID) REFERENCES Conductores(ConductorID)
);

-- Vehiculos --
CREATE TABLE Vehiculos (
    VehiculoID INT PRIMARY KEY IDENTITY(1,1),
    Placa NVARCHAR(20) UNIQUE,
    Capacidad INT
);

-- Ocupacion --
CREATE TABLE Ocupacion (
    OcupacionID INT PRIMARY KEY IDENTITY(1,1),
    VehiculoID INT NOT NULL,
    NumeroAsiento INT NOT NULL,
    EstudianteID INT NULL,
    FOREIGN KEY (VehiculoID) REFERENCES Vehiculos(VehiculoID),
    FOREIGN KEY (EstudianteID) REFERENCES Estudiantes(EstudianteID)
);

-- Rutas --
CREATE TABLE Rutas (
    RutaID INT PRIMARY KEY IDENTITY(1,1),
    NombreRuta NVARCHAR(50),
    Descripcion NVARCHAR(200)
);

-- Paradas --
CREATE TABLE Paradas (
    ParadaID INT PRIMARY KEY IDENTITY(1,1),
    Nombre NVARCHAR(50),
    Direccion NVARCHAR(200)
);

-- Tarifas --
CREATE TABLE Tarifas (
    TarifaID INT PRIMARY KEY IDENTITY(1,1),
    Monto DECIMAL(10,2),
    Descripcion NVARCHAR(100)
);

-- Paradas<->Rutas --
CREATE TABLE ParadasRutas (
    RutaID INT,
    ParadaID INT,
    PRIMARY KEY (RutaID, ParadaID),
    FOREIGN KEY (RutaID) REFERENCES Rutas(RutaID),
    FOREIGN KEY (ParadaID) REFERENCES Paradas(ParadaID)
);

-- Tarifas<->Rutas --
CREATE TABLE TarifasRutas (
    RutaID INT,
    TarifaID INT,
    PRIMARY KEY (RutaID, TarifaID),
    FOREIGN KEY (RutaID) REFERENCES Rutas(RutaID),
    FOREIGN KEY (TarifaID) REFERENCES Tarifas(TarifaID)
);

-- MetodoPago --
CREATE TABLE MetodoPago (
    MetodoPagoID INT PRIMARY KEY IDENTITY(1,1),
    Nombre NVARCHAR(50)
);

-- Pagos --
CREATE TABLE Pagos (
    PagoID INT PRIMARY KEY IDENTITY(1,1),
    EstudianteID INT NOT NULL,
    MetodoPagoID INT NOT NULL,
    TarifaID INT NOT NULL,
    Monto DECIMAL(10,2),
    FechaPago DATE,
    FOREIGN KEY (EstudianteID) REFERENCES Estudiantes(EstudianteID),
    FOREIGN KEY (MetodoPagoID) REFERENCES MetodoPago(MetodoPagoID),
    FOREIGN KEY (TarifaID) REFERENCES Tarifas(TarifaID)
);

-- Incidencias --
CREATE TABLE Incidencias (
    IncidenciaID INT PRIMARY KEY IDENTITY(1,1),
    EstudianteID INT NOT NULL,
    Fecha DATE,
    Descripcion NVARCHAR(200),
    FOREIGN KEY (EstudianteID) REFERENCES Estudiantes(EstudianteID)
);

-- MantenimientoVehiculo --
CREATE TABLE MantenimientoVehiculo (
    MantenimientoID INT PRIMARY KEY IDENTITY(1,1),
    VehiculoID INT NOT NULL,
    Fecha DATE,
    Descripcion NVARCHAR(200),
    FOREIGN KEY (VehiculoID) REFERENCES Vehiculos(VehiculoID)
);

-- BitacoraAcceso --
CREATE TABLE BitacoraAcceso (
    BitacoraID INT PRIMARY KEY IDENTITY(1,1),
    UsuarioID INT NOT NULL,
    Accion NVARCHAR(200),
    Fecha DATETIME2(0),
    FOREIGN KEY (UsuarioID) REFERENCES Usuario(UsuarioID)
);



