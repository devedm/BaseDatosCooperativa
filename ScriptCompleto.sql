---- Creacion de Tablas ----
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
    CodigoRuta INT NULL,
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


-- Inserts --

USE Cooperativa;
--Inserts de la tabla Usuario--
INSERT INTO Usuario (Cedula, Nombre, Apellido, Telefono, Correo) VALUES 
('110000001',N'ADMIN',N'ADMINISTRADOR',N'60000001',N'administrador@correo.com'),
('110000002',N'Luis',N'González',N'60000002',N'luis.gonzalez2@correo.com'),
('110000003',N'María',N'Jiménez',N'60000003',N'maria.jimenez3@correo.com'),
('110000004',N'Carlos',N'Mora',N'60000004',N'carlos.mora4@correo.com'),
('110000005',N'Sofía',N'Herrera',N'60000005',N'sofia.herrera5@correo.com'),
('110000006',N'Javier',N'Solano',N'60000006',N'javier.solano6@correo.com'),
('110000007',N'Gabriela',N'Vargas',N'60000007',N'gabriela.vargas7@correo.com'),
('110000008',N'Diego',N'Castro',N'60000008',N'diego.castro8@correo.com'),
('110000009',N'Valeria',N'Rojas',N'60000009',N'valeria.rojas9@correo.com'),
('110000010',N'Andrés',N'Soto',N'60000010',N'andres.soto10@correo.com'),
('110000011',N'Camila',N'Araya',N'60000011',N'camila.araya11@correo.com'),
('110000012',N'Fernando',N'López',N'60000012',N'fernando.lopez12@correo.com'),
('110000013',N'Paola',N'Martínez',N'60000013',N'paola.martinez13@correo.com'),
('110000014',N'Mario',N'Chacón',N'60000014',N'mario.chacon14@correo.com'),
('110000015',N'Natalia',N'Vega',N'60000015',N'natalia.vega15@correo.com'),
('110000016',N'Ricardo',N'Salas',N'60000016',N'ricardo.salas16@correo.com'),
('110000017',N'Laura',N'Camacho',N'60000017',N'laura.camacho17@correo.com'),
('110000018',N'Esteban',N'Méndez',N'60000018',N'esteban.mendez18@correo.com'),
('110000019',N'Andrea',N'Pérez',N'60000019',N'andrea.perez19@correo.com'),
('110000020',N'Daniel',N'Ruiz',N'60000020',N'daniel.ruiz20@correo.com'),
('110000021',N'Isabel',N'Murillo',N'60000021',N'isabel.murillo21@correo.com'),
('110000022',N'José',N'Cordero',N'60000022',N'jose.cordero22@correo.com'),
('110000023',N'Patricia',N'Navarro',N'60000023',N'patricia.navarro23@correo.com'),
('110000024',N'Héctor',N'Castillo',N'60000024',N'hector.castillo24@correo.com'),
('110000025',N'Monserrat',N'Leiva',N'60000025',N'monserrat.leiva25@correo.com'),
('110000026',N'Rafael',N'Pineda',N'60000026',N'rafael.pineda26@correo.com'),
('110000027',N'Carolina',N'Acosta',N'60000027',N'carolina.acosta27@correo.com'),
('110000028',N'Miguel',N'Zamora',N'60000028',N'miguel.zamora28@correo.com'),
('110000029',N'Karla',N'Sequeira',N'60000029',N'karla.sequeira29@correo.com'),
('110000030',N'Jonathan',N'Alvarado',N'60000030',N'jonathan.alvarado30@correo.com'),
('110000031',N'Lucía',N'Ramírez',N'60000031',N'lucia.ramirez31@correo.com'),
('110000032',N'Pedro',N'Quiros',N'60000032',N'pedro.quiros32@correo.com'),
('110000033',N'Fiorella',N'Vidal',N'60000033',N'fiorella.vidal33@correo.com'),
('110000034',N'Sergio',N'Aguilar',N'60000034',N'sergio.aguilar34@correo.com'),
('110000035',N'Elena',N'Calderón',N'60000035',N'elena.calderon35@correo.com'),
('110000036',N'Oscar',N'Arce',N'60000036',N'oscar.arce36@correo.com'),
('110000037',N'Marisol',N'Barrantes',N'60000037',N'marisol.barrantes37@correo.com'),
('110000038',N'Cristian',N'Alpízar',N'60000038',N'cristian.alpizar38@correo.com'),
('110000039',N'Daniela',N'Robles',N'60000039',N'daniela.robles39@correo.com'),
('110000040',N'Kevin',N'Espinoza',N'60000040',N'kevin.espinoza40@correo.com'),
('110000041',N'Brenda',N'Segura',N'60000041',N'brenda.segura41@correo.com'),
('110000042',N'Alonso',N'Valverde',N'60000042',N'alonso.valverde42@correo.com'),
('110000043',N'Rebeca',N'Mata',N'60000043',N'rebeca.mata43@correo.com'),
('110000044',N'Tomás',N'Cruz',N'60000044',N'tomas.cruz44@correo.com'),
('110000045',N'Silvia',N'Rivas',N'60000045',N'silvia.rivas45@correo.com'),
('110000046',N'Mauricio',N'Sandí',N'60000046',N'mauricio.sandi46@correo.com'),
('110000047',N'Priscila',N'Mora',N'60000047',N'priscila.mora47@correo.com'),
('110000048',N'Edgar',N'Ureña',N'60000048',N'edgar.urena48@correo.com'),
('110000049',N'Melisa',N'Méndez',N'60000049',N'melisa.mendez49@correo.com'),
('110000050',N'Rodrigo',N'Solís',N'60000050',N'rodrigo.solis50@correo.com');


USE Cooperativa;

--Inserts de la tabla estudiantes--
INSERT INTO Estudiantes (UsuarioID) VALUES 
(1),
(2),
(3),
(4),
(5),
(6),
(7),
(8),
(9),
(10),
(11),
(12),
(13),
(14),
(15),
(16),
(17),
(18),
(19),
(20),
(21),
(22),
(23),
(24),
(25),
(26),
(27),
(28),
(29),
(30),
(31),
(32),
(33),
(34),
(35),
(36),
(37),
(38),
(39),
(40),
(41),
(42),
(43),
(44),
(45),
(46),
(47),
(48),
(49),
(50);

GO

USE Cooperativa;

--Inserts de las tabla empleado--
INSERT INTO Empleado (UsuarioID) VALUES 
(1),
(2),
(3),
(4),
(5),
(6),
(7),
(8),
(9),
(10),
(11),
(12),
(13),
(14),
(15),
(16),
(17),
(18),
(19),
(20),
(21),
(22),
(23),
(24),
(25),
(26),
(27),
(28),
(29),
(30),
(31),
(32),
(33),
(34),
(35),
(36),
(37),
(38),
(39),
(40),
(41),
(42),
(43),
(44),
(45),
(46),
(47),
(48),
(49),
(50);

GO

USE Cooperativa;

--Inserts de la tabla conductores--
INSERT INTO Conductores (UsuarioID) VALUES 
(1),
(2),
(3),
(4),
(5),
(6),
(7),
(8),
(9),
(10),
(11),
(12),
(13),
(14),
(15),
(16),
(17),
(18),
(19),
(20),
(21),
(22),
(23),
(24),
(25),
(26),
(27),
(28),
(29),
(30),
(31),
(32),
(33),
(34),
(35),
(36),
(37),
(38),
(39),
(40),
(41),
(42),
(43),
(44),
(45),
(46),
(47),
(48),
(49),
(50);

GO

USE Cooperativa;

--Inserts de la tabla licencia--
INSERT INTO Licencia (NumeroLicencia, FechaExpiracion, ConductorID) VALUES 
('A0000001','2027-01-15',1),
('A0000002','2027-02-15',2),
('A0000003','2027-03-15',3),
('A0000004','2027-04-15',4),
('A0000005','2027-05-15',5),
('A0000006','2027-06-15',6),
('A0000007','2027-07-15',7),
('A0000008','2027-08-15',8),
('A0000009','2027-09-15',9),
('A0000010','2027-10-15',10),
('A0000011','2027-11-15',11),
('A0000012','2027-12-15',12),
('A0000013','2028-01-15',13),
('A0000014','2028-02-15',14),
('A0000015','2028-03-15',15),
('A0000016','2028-04-15',16),
('A0000017','2028-05-15',17),
('A0000018','2028-06-15',18),
('A0000019','2028-07-15',19),
('A0000020','2028-08-15',20),
('A0000021','2028-09-15',21),
('A0000022','2028-10-15',22),
('A0000023','2028-11-15',23),
('A0000024','2028-12-15',24),
('A0000025','2029-01-15',25),
('A0000026','2029-02-15',26),
('A0000027','2029-03-15',27),
('A0000028','2029-04-15',28),
('A0000029','2029-05-15',29),
('A0000030','2029-06-15',30),
('A0000031','2029-07-15',31),
('A0000032','2029-08-15',32),
('A0000033','2029-09-15',33),
('A0000034','2029-10-15',34),
('A0000035','2029-11-15',35),
('A0000036','2029-12-15',36),
('A0000037','2030-01-15',37),
('A0000038','2030-02-15',38),
('A0000039','2030-03-15',39),
('A0000040','2030-04-15',40),
('A0000041','2030-05-15',41),
('A0000042','2030-06-15',42),
('A0000043','2030-07-15',43),
('A0000044','2030-08-15',44),
('A0000045','2030-09-15',45),
('A0000046','2030-10-15',46),
('A0000047','2030-11-15',47),
('A0000048','2030-12-15',48),
('A0000049','2031-01-15',49),
('A0000050','2031-02-15',50);

GO

USE Cooperativa;

--Inserts de la tabla veiculos--
INSERT INTO Vehiculos (Placa, Capacidad) VALUES 
('BUS-001',30),
('BUS-002',30),
('BUS-003',32),
('BUS-004',32),
('BUS-005',28),
('BUS-006',28),
('BUS-007',26),
('BUS-008',26),
('BUS-009',24),
('BUS-010',24),
('BUS-011',20),
('BUS-012',20),
('BUS-013',20),
('BUS-014',22),
('BUS-015',22),
('BUS-016',22),
('BUS-017',18),
('BUS-018',18),
('BUS-019',18),
('BUS-020',18),
('BUS-021',16),
('BUS-022',16),
('BUS-023',16),
('BUS-024',16),
('BUS-025',16),
('BUS-026',14),
('BUS-027',14),
('BUS-028',14),
('BUS-029',14),
('BUS-030',14),
('BUS-031',12),
('BUS-032',12),
('BUS-033',12),
('BUS-034',12),
('BUS-035',12),
('BUS-036',10),
('BUS-037',10),
('BUS-038',10),
('BUS-039',10),
('BUS-040',10),
('BUS-041',8),
('BUS-042',8),
('BUS-043',8),
('BUS-044',8),
('BUS-045',8),
('BUS-046',8),
('BUS-047',8),
('BUS-048',8),
('BUS-049',8),
('BUS-050',8);

GO

USE Cooperativa;

--Inserts de la tabla Ocupacion--
INSERT INTO Ocupacion (VehiculoID, NumeroAsiento, EstudianteID) VALUES
(1,1,1),
(1,2,2),
(1,3,3),
(1,4,4),
(1,5,5),
(2,1,6),
(2,2,7),
(2,3,8),
(2,4,9),
(2,5,10),
(3,1,11),
(3,2,12),
(3,3,13),
(3,4,14),
(3,5,15),
(4,1,16),
(4,2,17),
(4,3,18),
(4,4,19),
(4,5,20),
(5,1,21),
(5,2,22),
(5,3,23),
(5,4,24),
(5,5,25),
(6,1,26),
(6,2,27),
(6,3,28),
(6,4,29),
(6,5,30),
(7,1,31),
(7,2,32),
(7,3,33),
(7,4,34),
(7,5,35),
(8,1,36),
(8,2,37),
(8,3,38),
(8,4,39),
(8,5,40),
(9,1,41),
(9,2,42),
(9,3,43),
(9,4,44),
(9,5,45),
(10,1,46),
(10,2,47),
(10,3,48),
(10,4,49),
(10,5,50);

GO

USE Cooperativa;

--Inserts de la tabla Rutas--
INSERT INTO Rutas (NombreRuta, Descripcion) VALUES
(N'Ruta 1', N'Servicio estudiantil en zona norte'),
(N'Ruta 2', N'Recorrido por San José'),
(N'Ruta 3', N'Ruta hacia Heredia'),
(N'Ruta 4', N'Ruta hacia Alajuela'),
(N'Ruta 5', N'Ruta hacia Cartago'),
(N'Ruta 6', N'Ruta sector oeste'),
(N'Ruta 7', N'Ruta sector este'),
(N'Ruta 8', N'Ruta regional universitaria'),
(N'Ruta 9', N'Servicio especial nocturno'),
(N'Ruta 10', N'Servicio matutino'),
(N'Ruta 11', N'Ruta extendida zona norte'),
(N'Ruta 12', N'Ruta especial fines de semana'),
(N'Ruta 13', N'Ruta internacional cercana'),
(N'Ruta 14', N'Servicio rápido Heredia'),
(N'Ruta 15', N'Ruta rápida Cartago'),
(N'Ruta 16', N'Ruta directa San José'),
(N'Ruta 17', N'Ruta circular universitaria'),
(N'Ruta 18', N'Ruta sector montañoso'),
(N'Ruta 19', N'Ruta activa temporal'),
(N'Ruta 20', N'Ruta experimental'),
(N'Ruta 21', N'Ruta interna del campus'),
(N'Ruta 22', N'Ruta larga regional'),
(N'Ruta 23', N'Ruta corta interna'),
(N'Ruta 24', N'Ruta especial de transporte'),
(N'Ruta 25', N'Ruta auxiliar estudiantil'),
(N'Ruta 26', N'Ruta microbús'),
(N'Ruta 27', N'Ruta de alta demanda'),
(N'Ruta 28', N'Ruta vespertina'),
(N'Ruta 29', N'Ruta nocturna extendida'),
(N'Ruta 30', N'Ruta interurbana'),
(N'Ruta 31', N'Ruta con paradas múltiples'),
(N'Ruta 32', N'Ruta express San José'),
(N'Ruta 33', N'Ruta con pocas paradas'),
(N'Ruta 34', N'Ruta por zonas rurales'),
(N'Ruta 35', N'Ruta hacia zonas alejadas'),
(N'Ruta 36', N'Ruta piloto nueva'),
(N'Ruta 37', N'Ruta reforzada de temporada'),
(N'Ruta 38', N'Ruta especial de emergencias'),
(N'Ruta 39', N'Ruta corta de apoyo'),
(N'Ruta 40', N'Ruta de circuito cerrado'),
(N'Ruta 41', N'Ruta semi-express'),
(N'Ruta 42', N'Ruta en expansión'),
(N'Ruta 43', N'Ruta con conexión intermodal'),
(N'Ruta 44', N'Ruta con revisión activa'),
(N'Ruta 45', N'Ruta premium'),
(N'Ruta 46', N'Ruta segmentada'),
(N'Ruta 47', N'Ruta universitaria 24/7'),
(N'Ruta 48', N'Ruta alterna regional'),
(N'Ruta 49', N'Ruta interna secundaria'),
(N'Ruta 50', N'Ruta verde ecológica');

GO

USE Cooperativa;

--Inserts de la tabla Paradas--
INSERT INTO Paradas (Nombre, Direccion) VALUES
('Parada 1', N'Frente a la entrada principal'),
('Parada 2', N'Costado norte del campus'),
('Parada 3', N'Edificio de biblioteca'),
('Parada 4', N'Cafetería universitaria'),
('Parada 5', N'Parque industrial'),
('Parada 6', N'Salida a carretera principal'),
('Parada 7', N'Centro comercial cercano'),
('Parada 8', N'Hospital regional'),
('Parada 9', N'Rotonda central'),
('Parada 10', N'Entrada sur'),
('Parada 11', N'Estación de buses'),
('Parada 12', N'Barrio del este'),
('Parada 13', N'Barrio del oeste'),
('Parada 14', N'Zona deportiva'),
('Parada 15', N'Gimnasio'),
('Parada 16', N'Edificio de ingeniería'),
('Parada 17', N'Edificio de salud'),
('Parada 18', N'Edificio de derecho'),
('Parada 19', N'Edificio de arquitectura'),
('Parada 20', N'Calle principal San José'),
('Parada 21', N'Estación central Heredia'),
('Parada 22', N'Estación central Alajuela'),
('Parada 23', N'Estación central Cartago'),
('Parada 24', N'Puente peatonal'),
('Parada 25', N'Zona agrícola'),
('Parada 26', N'Rotonda pequeña'),
('Parada 27', N'Terminal rural'),
('Parada 28', N'Urbanización nueva'),
('Parada 29', N'Hotel cercano'),
('Parada 30', N'Colegio técnico'),
('Parada 31', N'Escuela local'),
('Parada 32', N'Municipalidad'),
('Parada 33', N'Parque central'),
('Parada 34', N'Mercado regional'),
('Parada 35', N'Zona comercial'),
('Parada 36', N'Zona industrial'),
('Parada 37', N'Zona bancaria'),
('Parada 38', N'Residencial privado'),
('Parada 39', N'Urbanización familiar'),
('Parada 40', N'Urbanización exclusiva'),
('Parada 41', N'Puesto policial'),
('Parada 42', N'Terminal secundaria'),
('Parada 43', N'Parada turística'),
('Parada 44', N'Parada ecológica'),
('Parada 45', N'Ingreso rural'),
('Parada 46', N'Estación sur'),
('Parada 47', N'Estación norte'),
('Parada 48', N'Sector este'),
('Parada 49', N'Sector oeste'),
('Parada 50', N'Sector central');

GO

USE Cooperativa;

--Inserts de la tabla Tarifas--
INSERT INTO Tarifas (Monto, Descripcion) VALUES 
(350.00, N'Tarifa regular'),
(400.00, N'Tarifa extendida'),
(450.00, N'Tarifa especial'),
(300.00, N'Tarifa reducida'),
(500.00, N'Tarifa premium'),
(380.00, N'Tarifa urbana'),
(420.00, N'Tarifa rural'),
(460.00, N'Tarifa regional'),
(480.00, N'Tarifa larga'),
(250.00, N'Tarifa corta'),
(370.00, N'Tarifa estudiante 1'),
(390.00, N'Tarifa estudiante 2'),
(410.00, N'Tarifa estudiante 3'),
(430.00, N'Tarifa estudiante 4'),
(470.00, N'Tarifa estudiante 5'),
(510.00, N'Tarifa alta demanda'),
(520.00, N'Tarifa nocturna'),
(530.00, N'Tarifa fin de semana'),
(540.00, N'Tarifa feriados'),
(550.00, N'Tarifa temporada alta'),
(560.00, N'Tarifa especial 1'),
(570.00, N'Tarifa especial 2'),
(580.00, N'Tarifa especial 3'),
(590.00, N'Tarifa especial 4'),
(600.00, N'Tarifa especial 5'),
(310.00, N'Tarifa económica'),
(320.00, N'Tarifa promocional'),
(330.00, N'Tarifa básica'),
(340.00, N'Tarifa alternativa'),
(295.00, N'Tarifa micro'),
(615.00, N'Tarifa larga premium'),
(625.00, N'Tarifa interurbana'),
(635.00, N'Tarifa intermodal'),
(645.00, N'Tarifa exclusiva'),
(655.00, N'Tarifa alta categor�a'),
(665.00, N'Tarifa preferencial'),
(675.00, N'Tarifa ejecutiva'),
(685.00, N'Tarifa top'),
(695.00, N'Tarifa VIP'),
(705.00, N'Tarifa gold'),
(715.00, N'Tarifa silver'),
(725.00, N'Tarifa bronze'),
(735.00, N'Tarifa rapid transit'),
(745.00, N'Tarifa SC+'),
(755.00, N'Tarifa SC++'),
(765.00, N'Tarifa SC Pro'),
(775.00, N'Tarifa SC Ultra'),
(785.00, N'Tarifa SC Max'),
(795.00, N'Tarifa SC Elite'),
(350.00, N'Tarifa mensual');
GO


USE Cooperativa;

--Inserts de la tabla ParadasRutas--
INSERT INTO ParadasRutas (RutaID, ParadaID) VALUES
(1,1),(2,2),(3,3),(4,4),(5,5),
(6,6),(7,7),(8,8),(9,9),(10,10),
(11,11),(12,12),(13,13),(14,14),(15,15),
(16,16),(17,17),(18,18),(19,19),(20,20),
(21,21),(22,22),(23,23),(24,24),(25,25),
(26,26),(27,27),(28,28),(29,29),(30,30),
(31,31),(32,32),(33,33),(34,34),(35,35),
(36,36),(37,37),(38,38),(39,39),(40,40),
(41,41),(42,42),(43,43),(44,44),(45,45),
(46,46),(47,47),(48,48),(49,49),(50,50);

GO

USE Cooperativa;

--Inserts de la tabla TarifasRutas--
INSERT INTO TarifasRutas (RutaID, TarifaID) VALUES
(1,1),(2,2),(3,3),(4,4),(5,5),
(6,6),(7,7),(8,8),(9,9),(10,10),
(11,11),(12,12),(13,13),(14,14),(15,15),
(16,16),(17,17),(18,18),(19,19),(20,20),
(21,21),(22,22),(23,23),(24,24),(25,25),
(26,26),(27,27),(28,28),(29,29),(30,30),
(31,31),(32,32),(33,33),(34,34),(35,35),
(36,36),(37,37),(38,38),(39,39),(40,40),
(41,41),(42,42),(43,43),(44,44),(45,45),
(46,46),(47,47),(48,48),(49,49),(50,50);

GO

USE Cooperativa;

--Inserts de la tabla MetodoPago--
INSERT INTO MetodoPago (Nombre) VALUES
('Efectivo 1'),('Efectivo 2'),('Efectivo 3'),('Efectivo 4'),('Efectivo 5'),
('Tarjeta 1'),('Tarjeta 2'),('Tarjeta 3'),('Tarjeta 4'),('Tarjeta 5'),
('SINPE 1'),('SINPE 2'),('SINPE 3'),('SINPE 4'),('SINPE 5'),
('PayPal 1'),('PayPal 2'),('PayPal 3'),('PayPal 4'),('PayPal 5'),
('Cripto 1'),('Cripto 2'),('Cripto 3'),('Cripto 4'),('Cripto 5'),
('Mixto 1'),('Mixto 2'),('Mixto 3'),('Mixto 4'),('Mixto 5'),
('Convenio 1'),('Convenio 2'),('Convenio 3'),('Convenio 4'),('Convenio 5'),
('Especial 1'),('Especial 2'),('Especial 3'),('Especial 4'),('Especial 5'),
('Pago Movil 1'),('Pago Movil 2'),('Pago Movil 3'),('Pago Movil 4'),('Pago Movil 5');

GO

USE Cooperativa;

--Inserts de la tabla Pagos--
INSERT INTO Pagos (EstudianteID, MetodoPagoID, TarifaID, Monto, FechaPago) VALUES
(1,1,1,350,'2024-01-01'),
(2,2,2,400,'2024-01-02'),
(3,3,3,450,'2024-01-03'),
(4,4,4,300,'2024-01-04'),
(5,5,5,500,'2024-01-05'),
(6,6,6,380,'2024-01-06'),
(7,7,7,420,'2024-01-07'),
(8,8,8,460,'2024-01-08'),
(9,9,9,480,'2024-01-09'),
(10,10,10,250,'2024-01-10'),
(11,11,11,370,'2024-01-11'),
(12,12,12,390,'2024-01-12'),
(13,13,13,410,'2024-01-13'),
(14,14,14,430,'2024-01-14'),
(15,15,15,470,'2024-01-15'),
(16,16,16,510,'2024-01-16'),
(17,17,17,520,'2024-01-17'),
(18,18,18,530,'2024-01-18'),
(19,19,19,540,'2024-01-19'),
(20,20,20,550,'2024-01-20'),
(21,21,21,560,'2024-01-21'),
(22,22,22,570,'2024-01-22'),
(23,23,23,580,'2024-01-23'),
(24,24,24,590,'2024-01-24'),
(25,25,25,600,'2024-01-25'),
(26,26,26,310,'2024-01-26'),
(27,27,27,320,'2024-01-27'),
(28,28,28,330,'2024-01-28'),
(29,29,29,340,'2024-01-29'),
(30,30,30,295,'2024-01-30'),
(31,31,31,615,'2024-01-31'),
(32,32,32,625,'2024-02-01'),
(33,33,33,635,'2024-02-02'),
(34,34,34,645,'2024-02-03'),
(35,35,35,655,'2024-02-04'),
(36,36,36,665,'2024-02-05'),
(37,37,37,675,'2024-02-06'),
(38,38,38,685,'2024-02-07'),
(39,39,39,695,'2024-02-08'),
(40,40,40,705,'2024-02-09'),
(41,41,41,715,'2024-02-10'),
(42,42,42,725,'2024-02-11'),
(43,43,43,735,'2024-02-12'),
(44,44,44,745,'2024-02-13'),
(45,45,45,755,'2024-02-14'),
(46,45,46,765,'2024-02-15'),
(47,45,47,775,'2024-02-16'),
(48,45,48,785,'2024-02-17'),
(49,45,49,795,'2024-02-18'),
(50,45,50,350,'2024-02-19');

GO

USE Cooperativa;

--Inserts de la tabla Incidencias--
INSERT INTO Incidencias (EstudianteID, Fecha, Descripcion, CodigoRuta) VALUES
(1,'2024-01-01',N'Retraso en abordaje',1),
(2,'2024-01-02',N'Silla da�ada',1),
(3,'2024-01-03',N'Discusi�n con conductor',1),
(4,'2024-01-04',N'Problema con tarjeta',1),
(5,'2024-01-05',N'Comportamiento inapropiado',1),
(6,'2024-01-06',N'Queja general',1),
(7,'2024-01-07',N'P�rdida de objeto',1),
(8,'2024-01-08',N'Incidente menor',1),
(9,'2024-01-09',N'Reporte preventivo',1),
(10,'2024-01-10',N'Mal olor en unidad',1),
(11,'2024-01-11',N'Aire acondicionado fallando',1),
(12,'2024-01-12',N'Sospecha de da�o',1),
(13,'2024-01-13',N'Reporte disciplinario',1),
(14,'2024-01-14',N'Comportamiento extra�o',1),
(15,'2024-01-15',N'Problema de pago',1),
(16,'2024-01-16',N'Asiento roto',1),
(17,'2024-01-17',N'Ventana da�ada',1),
(18,'2024-01-18',N'Exceso de ruido',1),
(19,'2024-01-19',N'Falta de espacio',1),
(20,'2024-01-20',N'Queja sobre ruta',1),
(21,'2024-01-21',N'Incidente t�cnico',1),
(22,'2024-01-22',N'Comportamiento agresivo',1),
(23,'2024-01-23',N'P�rdida de documentaci�n',1),
(24,'2024-01-24',N'Molestia f�sica',1),
(25,'2024-01-25',N'Interferencia el�ctrica',1),
(26,'2024-01-26',N'Frenado brusco',1),
(27,'2024-01-27',N'Ruido extra�o',1),
(28,'2024-01-28',N'Temperatura elevada',1),
(29,'2024-01-29',N'Olor extra�o',1),
(30,'2024-01-30',N'Asiento suelto',1),
(31,'2024-01-31',N'Carga excesiva',1),
(32,'2024-02-01',N'Reporte m�dico',1),
(33,'2024-02-02',N'Retraso significativo',1),
(34,'2024-02-03',N'Cambio de ruta',1),
(35,'2024-02-04',N'Confusi�n de parada',1),
(36,'2024-02-05',N'Piso resbaloso',1),
(37,'2024-02-06',N'Puerta defectuosa',1),
(38,'2024-02-07',N'Olor qu�mico',1),
(39,'2024-02-08',N'Queja de comodidad',1),
(40,'2024-02-09',N'Luz da�ada',1),
(41,'2024-02-10',N'Poca ventilaci�n',1),
(42,'2024-02-11',N'Vibraci�n constante',1),
(43,'2024-02-12',N'Demanda de revisi�n',1),
(44,'2024-02-13',N'Mancha en asiento',1),
(45,'2024-02-14',N'Suciedad excesiva',1),
(46,'2024-02-15',N'Conducta inapropiada',1),
(47,'2024-02-16',N'Desacato de norma',1),
(48,'2024-02-17',N'Molestia auditiva',1),
(49,'2024-02-18',N'Uso incorrecto de silla',1),
(50,'2024-02-19',N'Incidente sin gravedad',1);

GO

USE Cooperativa;

--Inserts de la tabla MantenimientoVehiculo--
INSERT INTO MantenimientoVehiculo (VehiculoID, Fecha, Descripcion) VALUES
(1,'2024-01-01',N'Cambio de aceite'),
(2,'2024-01-02',N'Revisión de frenos'),
(3,'2024-01-03',N'Cambio de llantas'),
(4,'2024-01-04',N'Ajuste de motor'),
(5,'2024-01-05',N'Cambio de batería'),
(6,'2024-01-06',N'Revisión general'),
(7,'2024-01-07',N'Cambio de filtros'),
(8,'2024-01-08',N'Ajuste de puertas'),
(9,'2024-01-09',N'Pintura general'),
(10,'2024-01-10',N'Cambio de luces'),
(11,'2024-01-11',N'Revisión de suspensión'),
(12,'2024-01-12',N'Limpieza profunda'),
(13,'2024-01-13',N'Cambio de correas'),
(14,'2024-01-14',N'Revisión de sistema eléctrico'),
(15,'2024-01-15',N'Alineamiento'),
(16,'2024-01-16',N'Balanceo'),
(17,'2024-01-17',N'Cambio de transmisión'),
(18,'2024-01-18',N'Revisión de tanque'),
(19,'2024-01-19',N'Cambio de bomba'),
(20,'2024-01-20',N'Sistema hidráulico'),
(21,'2024-01-21',N'Diagnóstico electrónico'),
(22,'2024-01-22',N'Limpieza de motor'),
(23,'2024-01-23',N'Cambio de sensores'),
(24,'2024-01-24',N'Cambio de amortiguadores'),
(25,'2024-01-25',N'Revisión de cableado'),
(26,'2024-01-26',N'Revisión de transmisión'),
(27,'2024-01-27',N'Ajuste mecánico'),
(28,'2024-01-28',N'Cambio de radiador'),
(29,'2024-01-29',N'Revisión de emisiones'),
(30,'2024-01-30',N'Purificación de tanque'),
(31,'2024-01-31',N'Cambio de combustible'),
(32,'2024-02-01',N'Cambio de empaque'),
(33,'2024-02-02',N'Revisión de válvulas'),
(34,'2024-02-03',N'Ajuste de frenos'),
(35,'2024-02-04',N'Cambio de alternador'),
(36,'2024-02-05',N'Mantenimiento profundo'),
(37,'2024-02-06',N'Limpieza de ductos'),
(38,'2024-02-07',N'Revisión de sensores'),
(39,'2024-02-08',N'Cambio de bujías'),
(40,'2024-02-09',N'Revisión de mangueras'),
(41,'2024-02-10',N'Cambio de shocks'),
(42,'2024-02-11',N'Reparación de carrocería'),
(43,'2024-02-12',N'Sustitución de partes'),
(44,'2024-02-13',N'Ajuste final'),
(45,'2024-02-14',N'Control de calidad'),
(46,'2024-02-15',N'Actualización mecánica'),
(47,'2024-02-16',N'Mantenimiento preventivo'),
(48,'2024-02-17',N'Chequear fugas'),
(49,'2024-02-18',N'Evaluación completa'),
(50,'2024-02-19',N'Mantenimiento final');

GO

USE Cooperativa;

--Inserts de la tabla BitacoraAcceso--
INSERT INTO BitacoraAcceso (UsuarioID, Accion, Fecha) VALUES
(1,'Inicio de sesión','2024-01-01 08:00'),
(2,'Cierre de sesión','2024-01-02 09:00'),
(3,'Actualización de cuenta','2024-01-03 10:00'),
(4,'Consulta de rutas','2024-01-04 11:00'),
(5,'Pago realizado','2024-01-05 12:00'),
(6,'Actualización de datos','2024-01-06 13:00'),
(7,'Reporte de incidencia','2024-01-07 14:00'),
(8,'Cambio de contraseña','2024-01-08 15:00'),
(9,'Inicio de sesión','2024-01-09 16:00'),
(10,'Cierre de sesión','2024-01-10 17:00'),
(11,'Inicio de sesión','2024-01-11 08:00'),
(12,'Cierre de sesión','2024-01-12 09:00'),
(13,'Actualización de cuenta','2024-01-13 10:00'),
(14,'Consulta de rutas','2024-01-14 11:00'),
(15,'Pago realizado','2024-01-15 12:00'),
(16,'Actualización de datos','2024-01-16 13:00'),
(17,'Reporte de incidencia','2024-01-17 14:00'),
(18,'Cambio de contraseña','2024-01-18 15:00'),
(19,'Inicio de sesión','2024-01-19 16:00'),
(20,'Cierre de sesión','2024-01-20 17:00'),
(21,'Inicio de sesión','2024-01-21 08:00'),
(22,'Cierre de sesión','2024-01-22 09:00'),
(23,'Actualización de cuenta','2024-01-23 10:00'),
(24,'Consulta de rutas','2024-01-24 11:00'),
(25,'Pago realizado','2024-01-25 12:00'),
(26,'Actualización de datos','2024-01-26 13:00'),
(27,'Reporte de incidencia','2024-01-27 14:00'),
(28,'Cambio de contraseña','2024-01-28 15:00'),
(29,'Inicio de sesión','2024-01-29 16:00'),
(30,'Cierre de sesión','2024-01-30 17:00'),
(31,'Inicio de sesión','2024-01-31 08:00'),
(32,'Cierre de sesión','2024-02-01 09:00'),
(33,'Actualización de cuenta','2024-02-02 10:00'),
(34,'Consulta de rutas','2024-02-03 11:00'),
(35,'Pago realizado','2024-02-04 12:00'),
(36,'Actualización de datos','2024-02-05 13:00'),
(37,'Reporte de incidencia','2024-02-06 14:00'),
(38,'Cambio de contraseña','2024-02-07 15:00'),
(39,'Inicio de sesión','2024-02-08 16:00'),
(40,'Cierre de sesión','2024-02-09 17:00'),
(41,'Inicio de sesión','2024-02-10 08:00'),
(42,'Cierre de sesión','2024-02-11 09:00'),
(43,'Consulta de rutas','2024-02-12 10:00'),
(44,'Actualización de datos','2024-02-13 11:00'),
(45,'Reporte de incidencia','2024-02-14 12:00'),
(46,'Cambio de contraseña','2024-02-15 13:00'),
(47,'Consulta de rutas','2024-02-16 14:00'),
(48,'Pago realizado','2024-02-17 15:00'),
(49,'Cierre de sesión','2024-02-18 16:00'),
(50,'Inicio de sesión','2024-02-19 17:00');

GO

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