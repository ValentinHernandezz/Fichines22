DROP DATABASE IF EXISTS fichines;

create database fichines;

USE fichines;

create table Fichin (
idFichin TINYINT NOT NULL,
Nombre VARCHAR(45) NOT NULL,
Lanzamiento Year NOT NULL, 
Precio DECIMAL(7,2) NOT NULL,
PRIMARY KEY (idFichin)
);
    

create table Cliente (
DNI INT NOT NULL, 
Nombre VARCHAR(45) NOT NULL,
Apellido VARCHAR(45) NOT NULL,
Mail VARCHAR(64) NOT NULL,
Saldo DECIMAL(8,2) NOT NULL,
Pass char (64) NOT NULL,
TarjetaJuego SMALLINT UNSIGNED NOT NULL,
PRIMARY KEY (DNI)
);

CREATE TABLE Recarga (
idRecarga TINYINT NOT NULL,
DNI INT NOT NULL,
FechaHora DATETIME NOT NULL,
Monto DECIMAL(7.2) NOT NULL,
PRIMARY KEY (idRecarga),
CONSTRAINT fk_Recarga_DNI FOREIGN KEY (DNI)
REFERENCES Cliente (DNI)
);

CREATE TABLE Jugada (
idJugada TINYINT NOT NULL,
idFichin TINYINT NOT NULL,
idRecarga TINYINT NOT NULL, -- creo 
Fechahora DATETIME NOT NULL,
CreditoGastados DECIMAL(7,2),
PRIMARY KEY (idJugada),
CONSTRAINT fk_jugada_Fichin FOREIGN KEY (idFichin)
REFERENCES Fichin (idFichin),
CONSTRAINT fk_Cliente_Recarga FOREIGN KEY (idRecarga)
REFERENCES Recarga (idRecarga)
);
