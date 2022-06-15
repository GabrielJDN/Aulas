USE curso_sql;

CREATE TABLE pedidos_final
(
	id int unsigned not null auto_increment,
	descricao varchar(100) not null, 
    valor double not null default '0',
    pago varchar(3) not null default 'Não',
    PRIMARY KEY (id)
);
INSERT INTO pedidos_final (descricao,valor) VALUES
('TV',3000),('Geladeira',1400),('DVD Player',300);
SELECT * FROM pedidos_final;
#Criação de uma Stored Procedure;
# O cenário é o seguinte: Queremos, de tempos em tempos, deletar pedidos que não foram pagos ainda.
#Para isso iremos em SCHEMAS, Stored Procedures (Com o botão esquero) selecionamos Create Stored procedure
CALL limpa_pedidos();

#Criação de Triggers;
# Digamos que temos uma tabela estoque e toda vez que essa tabela recebe um novo produto, nós queremos que nesse momento seja feita uma nova chamada para
#limpar os pedidos na tabela pedidos_final;
CREATE TABLE estoque
(
	id int unsigned not null auto_increment,
    descricao varchar(50) not null,
    quantidade int not null,
    PRIMARY KEY (id)
);
CREATE TRIGGER gatilho_limpa_pedidos
BEFORE INSERT
ON estoque
FOR EACH ROW 
CALL limpa_pedidos();

INSERT INTO estoque (descricao, quantidade) VALUES ('Fogão',5);
SELECT * FROM pedidos_final;
UPDATE pedidos_final SET pago='Sim' WHERE  id=11;
INSERT INTO estoque (descricao, quantidade) VALUES ('Forno',3);