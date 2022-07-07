delimiter $$
drop procedure if exists altaFichin $$
create procedure altaFichin (unidFichin TINYINT, unNombre VARCHAR(45), unLanzamiento YEAR, unPrecio DECIMAL(7,2))
BEGIN
insert into Fichin (idFichin, Nombre, Lanzamiento, Precio)
             values (unidFichin, unNombre, unLanzamiento, unPrecio);
end $$

drop procedure if exists altaJugada $$
create procedure altaJugada (unidJugada TINYINT, unidFichin TINYINT, unidRecarga TINYINT, unFechaHora DATETIME, unCreditoGastado DECIMAL(7,2))
BEGIN
insert into Jugada (idJugada, idFichin, idRecarga, FechaHora, CreditoGastado)
             values (unidJugada, unidFichin, unidRecarga, unFechaHora, unCreditoGastado);
end $$

drop procedure if exists altaRecarga $$
create procedure altaRecarga (unidRecarga TINYINT, unDNI INT, unFechaHora DATETIME, unMonto DECIMAL(7,2))
BEGIN
insert into Recarga (idRecarga, DNI, FechaHora, Monto)
              values (unidRecarga,unDNI, unFechahora, unMonto);
end $$

drop procedure if exists registrarCliente $$
create procedure registrarCliente (unDNI INT, unNombre VARCHAR(45), unApellido VARCHAR(45), 
                                  unMail VARCHAR(45), unTarjetaJuego SMALLINT UNSIGNED, 
                                  unSaldo DECIMAL(8,2) unPass CHAR(64))
BEGIN
insert into Cliente (DNI, Nombre, Apellido, Mail, TarjetaJuego, Saldo, Pass) 
      values (unDNI, unNombre, unApellido, unMail, unTarjetaJuego, unSaldo, SHA2(unPass, 256));
end $$

/*Se pide hacer el SP ‘clientePorDniPass’ que reciba un dni y contraseña (no encriptada), 
el SP tiene que devolver la fila correspondiente al cliente en caso de que concuerden dni 
y pass con los datos almacenados en la BD, caso contrario devuelve NULL.*/
DELIMITER $$
DROP PROCEDURE IF EXISTS clientePorDniPass $$
CREATE PROCEDURE  clientePorDniPass  (unDNI INT,unPass CHAR(64))
BEGIN 

        SELECT *
        FROM Cliente;
        WHERE unDNI = DNI AND sha2(unPass, 256) = Pass;
END $$    




--Se pide hacer el SF ‘RecaudacionPara’ que reciba por parámetro un identificador de fichin, 
--se debe devolver la ganancia que tuvo entre esas 2 fechas (inclusive).
DELIMITER $$
DROP FUNCTION IF EXISTS RecaudacionPara $$
CREATE FUNCTION RecaudacionPara (unid_Fichin TINYINT,FechaHora DATETIME)
                                 RETURNS INT READS SQL DATA
BEGIN
  DECLARE resultado FLOAT;
SELECT SUM(Credito_Gastado) INTO resultado
  FROM Jugada
  WHERE id_Jugada = unid_Jugada
  AND FechaHora BETWEEN FechaHora; 

RETURN resultado;

END $$
--Se pide hacer el SP ‘Gastos’ que reciba por parámetro una identificación de cliente. El SP tiene que devolver fecha y hora, nombre del juego y consumo ($) que el cliente haya jugado, ordenado por fecha y hora descendentemente.
DELIMITER $$
DROP PROCEDURE IF EXISTS Gastos
create procedure Gastos (DNI INT,fechaHora DATE TIME,nombre VARCHAR(45),creditosGastado DECIMAL (7,2))
BEGIN
select *
from jugada 
join Fichin using (idFichin)
where fechaHora desc;
end $$

