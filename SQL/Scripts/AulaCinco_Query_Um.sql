USE curso_sql;

# Aula 5 teórica

SELECT * FROM funcionarios INNER JOIN veiculos ON veiculos.funcionario_id = funcionarios.id;
SELECT * FROM funcionarios LEFT JOIN veiculos ON veiculos.funcionario_id = funcionarios.id;

#Colocamos mais um veículo para ver o efeito do Right Join;
INSERT INTO veiculos (funcionario_id,veiculo,placa) VALUES (null, 'Corolla', 'SB-0003');
SELECT * FROM funcionarios RIGHT JOIN veiculos ON veiculos.funcionario_id = funcionarios.id;

#O mySQL não apresenta o comando FULL JOIN, para isso devemos fazer uma "gambiarra" usando o UNION
SELECT * FROM funcionarios LEFT JOIN veiculos ON veiculos.funcionario_id = funcionarios.id UNION
SELECT * FROM funcionarios RIGHT JOIN veiculos ON veiculos.funcionario_id = funcionarios.id;

#Criamos uma nova tabela para demonstrar o Equi Join;
CREATE TABLE cpfs 
(
	id int unsigned not null,
    cpf varchar(14) not null,
    PRIMARY KEY (id),
    CONSTRAINT FK_cpf FOREIGN KEY (id) REFERENCES funcionarios (id)
);
INSERT INTO cpfs (id, cpf) VALUES 
(1,'111.111.111-11'),
(2,'222.222.222-22'),
(3,'333.333.333-33');
SELECT * FROM cpfs;
#Existem duas formas de observar o Equi Join;
SELECT * FROM funcionarios INNER JOIN cpfs ON funcionarios.id = cpfs.id;
SELECT * FROM funcionarios INNER JOIN cpfs USING (id);

#Demonstrando o SELF JOIN. Para isso crio mais uma tabela;
CREATE TABLE clientes 
(
	id int unsigned not null auto_increment,
    nome varchar(45) not null, 
    qm_indicou int unsigned, 
    PRIMARY KEY (id),
    CONSTRAINT fk_qm_indicou FOREIGN KEY (qm_indicou) REFERENCES clientes (id)
);
INSERT INTO clientes (id,nome,qm_indicou) VALUES
(1, 'André', null),
(2, 'Samuel', 1),
(3, 'Carlos', 2),
(4, 'Rafael', 1);

SELECT c1.nome AS CLIENTE, c2.nome AS 'QUEM INDICOU' FROM clientes c1 JOIN clientes c2 ON c1.qm_indicou = c2.id;

# Exemplo de um relacionamento múltiplo (triplo nesse caso);
SELECT * FROM funcionarios f 
INNER JOIN veiculos v ON v.funcionario_id = f.id 
INNER JOIN cpfs c ON c.id = f.id;

#Por fim, trabalhamos com visões;
CREATE VIEW funcionarios_salarios AS SELECT * FROM funcionarios WHERE salario>2000;
#Agora, vejo a visão criada!
SELECT * FROM funcionarios_salarios;
#Agora quero reduzir o salário do Fábio!
UPDATE funcionarios SET salario=salario = 1500 WHERE id=3;
#Vendo a visão novamente...
SELECT * FROM funcionarios_salarios;
#Podemos ver que o funcionário 'FÁBIO' não aparece mais na View.
#Por fim jogo a VIEW pra fora!
DROP VIEW funcionarios_salarios;