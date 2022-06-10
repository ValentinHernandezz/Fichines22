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
Pass (char 64) NOT NULL,
TarjetaJuego SMALLINT UNSIGNED NOT NULL,
PRIMARY KEY (DNI)
);

create table Recarga (
idRecarga TINYINT NOT NULL,
DNI INT NOT NULL,
FechaHora DATETIME NOT NULL,
Monto DECIMAL(7.2) NOT NULL,
PRIMARY KEY (idRecarga),
CONSTRAINT fk_Recarga_DNI FOREIGN KEY (DNI)
REFERENCES Cliente (DNI)
);

create table Jugada (
idJugada TINYINT NOT NULL,
idFichin TINYINT NOT NULL,
idRecarga TINYINT NOT NULL,
Fechahora DATETIME NOT NULL,
CreditoGastados DECIMAL(7,2),
PRIMARY KEY (idJugada),
CONSTRAINT fk_jugada_Fichin FOREIGN KEY (idFichin)
REFERENCES Fichin (idFichin),
CONSTRAINT fk_Cliente_Recarga FOREIGN KEY (idRecarga)
REFERENCES Recarga (idRecarga)
);
delimiter $$
drop procedure if exists altaFichin $$
procedure altaFichin (unidFichin TINYINT, unNombre VARCHAR(45), unLanzamiento YEAR, unPrecio, unidRecarga TINYINT)
BEGIN
insert into Fichin (idFichin, Nombre, Lanzamiento, Precio, idRecarga)
             value (unidFichin, unNombre, unLanzamiento, unPrecio, unidRecarga);
              end $$
drop procedure if exists altaJugada $$
create procedure altaJugada (unidJugada TINYINT, unidFichin TINYINT, unidRecarga TINYINT, unFechaHora DATETIME, unCreditoGastado DECIMAL(7,2))
BEGIN
insert into Jugada (idJugada, idFichin, idRecarga, FechaHora, CreditosGastados)
             value (unidJugada, unidFichin, unidRecarga, unFechaHora, unCreditosGastados);
               end $$
drop procedure if exists altaRecarga $$
create procedure altaRecarga (unidRecarga TINYINT, unDNI INT, unFechaHora DATETIME, unMonto DECIMAL(7,2))
BEGIN
insert into Recarga (idRecarga, DNI, FechaHora, Monto)
              value (unidRecarga,unDNI, unFechahora, unMonto);
drop procedure if exists registrarCliente $$
procedure registrarCliente (unDNI INT, unNombre VARCHAR(45), unApellido VARCHAR(45), unMail VARCHAR(45), unTarjetaJuego SMALLINT UNSIGNED, unSaldo DECIMAL(8,2) unPass(CHAR 64))
BEGIN
insert into (DNI, Nombre, Apellido, Mail, TarjetaJuego, Saldo, Pass) 
      value (unDNI, unNombre, un Apellido, unMail, unTarjetoJuego, unSaldo, sha2(unPass 256));
      end $$

