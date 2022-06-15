USE curso_sql;
#Descoberta dos mecanismos que oferecerem suporte a transação;
SHOW ENGINES;
#Notamos que a Engine InnoDB oferece suporte a transações;
CREATE TABLE contas_bancarias
(
	id int unsigned not null auto_increment,
    titular varchar(45) not null,
    saldo double not null,
    PRIMARY KEY(id)
) ENGINE=InnoDB;
INSERT INTO contas_bancarias (titular,saldo) VALUES ('André',1000), ('Carlos',2000);

#Queremos fazer uma transação de 100 reais da conta do André para a do Carlos.
UPDATE contas_bancarias SET saldo=saldo-100 WHERE id=1; #Uma transação bem "manual";
UPDATE contas_bancarias SET saldo=saldo+100 WHERE id=2; #Uma transação bem "manual";
#O problema dessa transação é que se cair a luz DURANTE o processo teremos um "sumiço" de 100 reais!
#Para resolvermos isso, usaremos:
SELECT * FROM contas_bancarias;
START TRANSACTION; #Começo a transação!
UPDATE contas_bancarias SET saldo=saldo-100 WHERE id=1;
UPDATE contas_bancarias SET saldo=saldo+100 WHERE id=2;
#ROLLBACK; #Desfaço os comandos!
COMMIT; #Concretizo os comandos!