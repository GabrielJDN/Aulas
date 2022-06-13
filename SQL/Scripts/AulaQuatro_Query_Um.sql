## Me conecto ao banco de dados da aula anterior
USE curso_sql;
CREATE TABLE funcionarios 
(
	id int unsigned not null auto_increment,
    nome varchar(45) not null,
    salario double not null default '0',
    departamento varchar(45) not null,
    PRIMARY KEY (id)
);
CREATE TABLE veiculos
(
	id int unsigned not null auto_increment,
    funcionario_id int unsigned default null, 
    veiculo varchar(45) not null default '',
    placa varchar(10) not null default '',
    PRIMARY KEY (id),
    CONSTRAINT fk_veiculos_funcionarios FOREIGN KEY (funcionario_id) REFERENCES funcionarios (id)
);
CREATE TABLE salarios
(
	faixa varchar(45) not null,
    inicio double not null,
    fim double not null,
    PRIMARY KEY (faixa)
);
CREATE INDEX departamentos ON funcionarios (departamento);
CREATE INDEX nomes ON funcionarios (nome(6));

INSERT INTO funcionarios (id, nome, salario, departamento) VALUES (1, 'Fernando', 1400, 'TI');
INSERT INTO funcionarios (id, nome, salario, departamento) VALUES (2, 'Guilherme', 2500, 'Jurídico');
INSERT INTO funcionarios (nome, salario, departamento) VALUES ('Fábio', 1700, 'TI');
INSERT INTO funcionarios (nome, salario, departamento) VALUES ('José', 1800, 'Marketing');

SELECT * FROM funcionarios;
SELECT * FROM funcionarios WHERE salario>2000;
SELECT * FROM funcionarios WHERE nome='José'; #Iguais
SELECT * FROM funcionarios WHERE id=4; #Iguais

UPDATE funcionarios SET salario=salario*1.1 WHERE nome='Fernando'; #Aumenta o salário do Fernando em 10%
UPDATE funcionarios SET salario=salario*1.1; #Multiplica TODOS os salários por 1.1, ou seja aumentamos ele em 10%
#O comando antrior deu ERRO devido ao fato do SQL_SAFE_UPDATE ser verdadeiro. Para ele funcionar devemos desativá-lo primeiro.
SET SQL_SAFE_UPDATES=0; #Isso é algo padrão, libera a atualização de uma tabela sem precisar mencionar o ID (AKA usar o WHERE).
# SET SQL_SAFE_UPDATE=1; #Retorno a forma padrão do safe update.
UPDATE funcionarios SET salario=salario*1.1; #Multiplica TODOS os salários por 1.1, ou seja aumentamos ele em 10%

#Agora o comando anterior funcionou! Vejamos:
SELECT * FROM funcionarios;
#Podemos ver que o float dos números ficou aparecendo em alguns resultados. Para evitarmos isso, usamos a instrução ROUND.
UPDATE funcionarios SET salario=ROUND(salario*1.1,2); # Damos mais um gás pros funcionários Aqui arrendodamos para duas casas decimais.
SELECT * FROM funcionarios;

DELETE FROM funcionarios WHERE id=4; # Não gostamos do josé, logo eliminamos ele!
SELECT * FROM funcionarios;

# ----------- Trabalhando com a tabela veículos!
INSERT INTO veiculos (funcionario_id, veiculo, placa) VALUES (1, 'Camaro', 'SB-0001'); #Fernando ganha pouco mas tem bons carros!
INSERT INTO veiculos (funcionario_id, veiculo, placa) VALUES (1, 'Chevete', 'SB-0002'); #Um Camaro e um Chevete pra ele!
UPDATE veiculos SET funcionario_id = 2 WHERE id=2; #Mas infelizmente o Camaro é caro e ele teve que vender para o Guilherme.
SELECT * FROM veiculos;

# ----------- Trabalhando com a tabela salários!
INSERT INTO salarios (faixa, inicio, fim) VALUES ('Analista Júnior', 1000, 2000);
INSERT INTO salarios (faixa, inicio, fim) VALUES ('Analista Pleno', 2000, 4000);
SELECT * FROM salarios;

# ----------- Trabalhando com apelidos!
SELECT * FROM funcionarios f WHERE f.salario>2000; #Isso é útil caso tenhamos duas tabelas sendo selecionadas.
SELECT nome, salario FROM funcionarios f WHERE f.salario>2000; #Isso é útil caso tenhamos duas tabelas sendo selecionadas.
SELECT nome AS 'Funcionário', salario FROM funcionarios f WHERE f.salario>2000; #Isso é útil caso tenhamos duas tabelas sendo selecionadas.

# ----------- Trabalhando com o comando UNION!
SELECT * FROM funcionarios WHERE nome='Guilherme' UNION 
SELECT * FROM funcionarios WHERE nome='Guilherme' UNION 
SELECT * FROM funcionarios WHERE id=1; #Union puro exclui registros duplicados!

SELECT * FROM funcionarios WHERE nome='Guilherme' UNION ALL
SELECT * FROM funcionarios WHERE nome='Guilherme'; #Union All conta registros duplicados!