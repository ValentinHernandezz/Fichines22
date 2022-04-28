DROP DATABASE IF EXISTS fichines;
create database fichines;
USE fichines;
create table Fichin (
 idFichin TINYINT(200) NOT NULL,
Nombre VARCHAR(25) NOT NULL,
Lanzamiento Year NOT NULL, 
Precio DECIMAL(7,2) NOT NULL,
idRecarga  TINYINT(200) NOT NULL, 
PRIMARY KEY (idFicihin),
FOREIGN KEY (idRecarga)
REFERENCES ficihines.Recarga (idRecarga)
);
create table Jugada (
idJugada TINYINT(200) NOT NULL,
idFichin BIGINT NOT NULL,
idRecarga TINYINT(200) NOT NULL,
Fechahora DATETIME NOT NULL,
CreditoGastados DECIMAL(7,2),
PRIMARY KEY (idJugada),
CONSTRAINT fk_jugada_Fichin FOREIGN KEY (idFichin)
REFERENCES fichines (idFichin)
CONSTRAINT fk_jugada_Recarga FOREIGN KEY (idRecarga)
REFERENCES Recarga (idRecarga)
);

create table Recarga (
idRecarga TINYINT(200) NOT NULL,
DNI INT NOT NULL,
FechaHora DATETIME NOT NULL,
Monto DECIMAL(7.2) NOT NULL,
PRIMARY KEY (idRecarga),
CONSTRAINT fk_DNI_Recarga FOREIGN KEY (DNI)
REFERENCES Recarga (DNI)
);

create table Cliente (
DNI INT NOT NULL, 
Nombre CHAR NOT NULL,
Apellido CHAR NOT NULL,
Mail VARCHAR(64) NOT NULL,
TarjetaJuego SMALLINT NOT NULL,
PRIMARY KEY (DNI)
);

