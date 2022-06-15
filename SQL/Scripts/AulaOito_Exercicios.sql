USE curso_sql;
SHOW ENGINES;
CREATE TABLE contas_bancarias
(
	id int unsigned not null auto_increment,
    titular varchar(32) not null,
    saldo double not null,
    PRIMARY KEY (id)
) ENGINE=InnoDB;
INSERT INTO contas_bancarias (titular,saldo) VALUES ('André',123),('Diogo',489),('Rafael',568),('Carlos',712),('Peter',-38);
SELECT * FROM contas_bancarias;
SET SQL_SAFE_UPDATES=0;
START TRANSACTION;
	UPDATE contas_bancarias SET saldo=saldo+abs(saldo*0.03);
COMMIT;