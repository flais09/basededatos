-- Código elaborado con erwin


CREATE TABLE Carril
(
	idCarril             INTEGER NOT NULL AUTO_INCREMENT,
	numeroCarril         INTEGER NULL,
	totemQR              varchar(200) NULL,
	idCaseta             INTEGER NULL
);

ALTER TABLE Carril
ADD CONSTRAINT XPKCarril PRIMARY KEY (idCarril);

CREATE TABLE Caseta
(
	idCaseta             INTEGER NOT NULL AUTO_INCREMENT,
	autopista            varchar(100) NULL,
	concesionario        varchar(200) NULL,
	operador             varchar(100) NULL,
	nombreCaseta         varchar(100) NULL,
	IAVE                 varchar(10) NULL,
	ubicacionKM          varchar(20) NULL,
	geolocalizacionA     varchar(200) NULL,
	geolocalizacionB     varchar(200) NULL,
	tramo                varchar(100) NULL,
	longitudKM           varchar(200) NULL,
	costoAuto            float NULL,
	costoEjeAdicional    float NULL,
	costoMoto            float NULL,
	costoAutobus2ejes    float NULL,
	costoCamion2ejes     float NULL
);

ALTER TABLE Caseta
ADD CONSTRAINT XPKCaseta PRIMARY KEY (idCaseta);

CREATE TABLE CasetaCerrada
(
	casetaCerrada        varchar(60) NOT NULL,
	puntoAcceso          varchar(60) NULL,
	idCaseta             INTEGER NOT NULL
);

ALTER TABLE CasetaCerrada
ADD CONSTRAINT XPKCasetaCerrada PRIMARY KEY (casetaCerrada,idCaseta);

CREATE TABLE CobroCaseta
(
	idCobroCaseta        INTEGER NOT NULL AUTO_INCREMENT,
	fecha                TIMESTAMP NULL,
	hora                 Time NULL,
	monto                float NULL,
	convenio             VARCHAR(20) NULL,
	lecturaPlaca         varchar(8) NULL,
	lecturaSensorMovimiento VARCHAR(20) NULL,
	foto                 VARBINARY NULL,
	indicadorCasetaCerrada varchar(2) NULL,
	lecturaPuntoDeAcceso VARCHAR(20) NULL,
	idSistemaCobroPeaje  INTEGER NULL,
	idCaseta             INTEGER NULL
);

ALTER TABLE CobroCaseta
ADD CONSTRAINT XPKCobroCaseta PRIMARY KEY (idCobroCaseta);

CREATE TABLE PermiteAcceso
(
	placa                varchar(8) NOT NULL,
	idSistemaCobroPeaje  INTEGER NOT NULL
);

ALTER TABLE PermiteAcceso
ADD CONSTRAINT XPKPermiteAcceso PRIMARY KEY (placa,idSistemaCobroPeaje);

CREATE TABLE Repuve
(
	idRepuve             INTEGER NOT NULL,
	marca                VARCHAR(20) NULL,
	modelo               VARCHAR(20) NULL,
	añoModelo            INTEGER NULL,
	clase                VARCHAR(20) NULL,
	tipo                 VARCHAR(20) NULL,
	NIV                  VARCHAR(20) NULL,
	NCI                  VARCHAR(20) NULL,
	placa                varchar(8) NULL,
	numeroPuertas        INTEGER NULL,
	paisOrigen           VARCHAR(20) NULL,
	version              VARCHAR(20) NULL,
	desplazamiento       VARCHAR(20) NULL,
	numeroEjes           INTEGER NULL,
	numeroCilindros      INTEGER NULL,
	plantaEnsamble       VARCHAR(20) NULL,
	datosComplementarios varchar(50) NULL,
	insitucionInscripcion VARCHAR(20) NULL,
	fechaInscripcion     TIMESTAMP NULL,
	horaInscripcion      Time NULL,
	entidadEmplaque      VARCHAR(20) NULL,
	fechaEmplacado       TIMESTAMP NULL,
	fechaUltimaActualizacion TIMESTAMP NULL,
	folioConstanciaInscripcion VARCHAR(20) NULL,
	observaciones        varchar(100) NULL,
	reporteDeRobo        VARCHAR(20) NULL
);

ALTER TABLE Repuve
ADD CONSTRAINT XPKRepuve PRIMARY KEY (idRepuve);

CREATE TABLE ServicioCobroPeaje
(
	idSistemaCobroPeaje  INTEGER NOT NULL AUTO_INCREMENT,
	fechaRegistro        TIMESTAMP NULL,
	convenio             VARCHAR(20) NULL
);

ALTER TABLE ServicioCobroPeaje
ADD CONSTRAINT XPKServicioCobroPeaje PRIMARY KEY (idSistemaCobroPeaje);

CREATE TABLE TarjetasBancarias
(
	idTarjeta            INTEGER NOT NULL AUTO_INCREMENT,
	vencimiento          varchar(5) NULL,
	codigo               varchar(3) NULL,
	nombreTitular        varchar(80) NULL,
	idUsuario            INTEGER NULL
);

ALTER TABLE TarjetasBancarias
ADD CONSTRAINT XPKTarjetasBancarias PRIMARY KEY (idTarjeta);

CREATE TABLE Usuario
(
	idUsuario            INTEGER NOT NULL AUTO_INCREMENT,
	nombre               varchar(50) NULL,
	apellido             varchar(50) NULL,
	correoElectronico    varchar(40) NULL,
	cvePais              INTEGER NULL,
	telefono             INTEGER NULL,
	contraseña           VARCHAR(20) NULL,
	metodoPagoPredeterminado VARCHAR(20) NULL,
	vehiculoPredeterminado VARCHAR(20) NULL,
	pestañaInicial       VARCHAR(20) NULL,
	idSistemaCobroPeaje  INTEGER NULL
);

ALTER TABLE Usuario
ADD CONSTRAINT XPKUsuario PRIMARY KEY (idUsuario);

CREATE TABLE Vehiculo
(
	placa                varchar(8) NOT NULL,
	pais                 VARCHAR(20) NULL,
	estado               VARCHAR(20) NULL,
	marca                VARCHAR(20) NULL,
	modelo               INTEGER NULL,
	color                varchar(10) NULL,
	idRepuve             INTEGER NULL,
	idSistemaCobroPeaje  INTEGER NULL
);

ALTER TABLE Vehiculo
ADD CONSTRAINT XPKVehiculo PRIMARY KEY (placa);

ALTER TABLE Carril
ADD CONSTRAINT R_10 FOREIGN KEY (idCaseta) REFERENCES Caseta (idCaseta);

ALTER TABLE CasetaCerrada
ADD CONSTRAINT R_13 FOREIGN KEY (idCaseta) REFERENCES Caseta (idCaseta)
		ON DELETE CASCADE;

ALTER TABLE CobroCaseta
ADD CONSTRAINT R_8 FOREIGN KEY (idSistemaCobroPeaje) REFERENCES ServicioCobroPeaje (idSistemaCobroPeaje);

ALTER TABLE CobroCaseta
ADD CONSTRAINT R_9 FOREIGN KEY (idCaseta) REFERENCES Caseta (idCaseta);

ALTER TABLE PermiteAcceso
ADD CONSTRAINT R_3 FOREIGN KEY (placa) REFERENCES Vehiculo (placa);

ALTER TABLE PermiteAcceso
ADD CONSTRAINT R_4 FOREIGN KEY (idSistemaCobroPeaje) REFERENCES ServicioCobroPeaje (idSistemaCobroPeaje);

ALTER TABLE TarjetasBancarias
ADD CONSTRAINT R_7 FOREIGN KEY (idUsuario) REFERENCES Usuario (idUsuario);

ALTER TABLE Usuario
ADD CONSTRAINT R_6 FOREIGN KEY (idSistemaCobroPeaje) REFERENCES ServicioCobroPeaje (idSistemaCobroPeaje);

ALTER TABLE Vehiculo
ADD CONSTRAINT R_1 FOREIGN KEY (idRepuve) REFERENCES Repuve (idRepuve);

ALTER TABLE Vehiculo
ADD CONSTRAINT R_5 FOREIGN KEY (idSistemaCobroPeaje) REFERENCES ServicioCobroPeaje (idSistemaCobroPeaje);
