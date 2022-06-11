#O nome é, preferenialmente, em letras minúsculas.
CREATE DATABASE curso_sql;
#Indo em Schema e usando o Refresh All, vemos esse banco. 

#Esse comando é importante. Ele basicamente coloca o banco de dados curso_sql como selecionado no Workbench, assim qualquer alteração feita é realizada
#nesse banco. Por isso, sempre que quisermos alterar esse banco de dados usamos ele, ou alteramos o nosso default schema.
USE curso_sql;

#Finalmente, começo a criação de estruturas nesse banco de dados. Observe que o nome da tabela também é em minúsculo
CREATE TABLE funcionarios 
(
	id int unsigned not null auto_increment,
    nome varchar(45) not null,
    salario double not null default '0',
    departamento varchar(45) not null,
    PRIMARY KEY (id)
);
#A propriedade default faz que com que caso nenhum valor seja informado no campo, o valor será o default (0)

CREATE TABLE veiculos
(
	id int unsigned not null auto_increment,
    funcionario_id int unsigned default null, 
    veiculo varchar(45) not null default '',
    placa varchar(10) not null default '',
    PRIMARY KEY (id),
    CONSTRAINT fk_veiculos_funcionarios FOREIGN KEY (funcionario_id) REFERENCES funcionarios (id)
);
#O comando CONSTRAINT avisa o MySQL que estou criando uma chave estrangeira, além disso ele permite criar um "apelido" para chave estrangeira, 
#útil caso queiramos excluí-la no futuro.
#É importante notar que cada vez que criamos uma chave estrangeira a tabela que queremos linkar já deve existir!

CREATE TABLE salarios
(
	faixa varchar(45) not null,
    inicio double not null,
    fim double not null,
    PRIMARY KEY (faixa)
);

ALTER TABLE funcionarios CHANGE COLUMN nome nome_func varchar(45) not null;
#O Change Column permite alterar a coluna através de: CHANGE COLUMN nome NovoNome AlteraçãoTipoDeDado 
ALTER TABLE funcionarios CHANGE COLUMN nome_func nome varchar(45) not null;

DROP TABLE salarios;

CREATE INDEX departamentos ON funcionarios (departamento);
CREATE INDEX nomes ON funcionarios (nome(6));




