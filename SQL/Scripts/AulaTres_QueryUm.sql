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

#Agora irei fazer um novo exercício, portanto limpo tudo relacionado ao exercício anterior!
DROP TABLE funcionarios;
DROP TABLE veiculos;

# ========================================== Final da aula 3 Teórica!
# ========================================== Começo dos exercícios da aula 3!
# Agora, começo o novo exercício!

CREATE TABLE tipo_curso 
(
	codigo_tipo_curso smallint unsigned not null auto_increment,
    tipo varchar(45) not null,
    PRIMARY KEY (codigo_tipo_curso)
);
CREATE INDEX cod_tip_curs ON tipo_curso (codigo_tipo_curso);
CREATE INDEX tipo ON tipo_curso (tipo);

CREATE TABLE instrutores 
(
	codigo_instrutor smallint unsigned not null auto_increment,
    nome_instrutor varchar(45) not null, 
    telefone_instrutor varchar(45) not null,
    PRIMARY KEY (codigo_instrutor)
);
CREATE INDEX cod_instrut ON instrutores (codigo_instrutor);
CREATE INDEX nom_instrut ON instrutores (nome_instrutor(5));

CREATE TABLE cursos
(
	codigo_curso smallint unsigned not null auto_increment, 
    nome_curso varchar(45) not null, 
    codigo_tipo_curso smallint unsigned default null, 
    codigo_instrutor smallint unsigned default null,
    valor double unsigned not null, 
    PRIMARY KEY (codigo_curso), 
    CONSTRAINT FK_codigo_tipo_curso FOREIGN KEY (codigo_tipo_curso) REFERENCES tipo_curso (codigo_tipo_curso),
    CONSTRAINT FK_codigo_instrutor FOREIGN KEY (codigo_instrutor) REFERENCES instrutores (codigo_instrutor)
);

CREATE TABLE aluno
(
	codigo_aluno int unsigned not null auto_increment,
    nome_aluno varchar(45) not null, 
    endereco_aluno varchar(100) not null,
    email_aluno varchar(100) not null,
    PRIMARY KEY (codigo_aluno)
);

CREATE TABLE pedidos
(
	codigo_pedido int unsigned not null auto_increment,
    codigo_aluno int unsigned not null, 
    dia DATE not null,
    hora TIME not null,
    PRIMARY KEY (codigo_pedido),
    CONSTRAINT FK_codigo_aluno FOREIGN KEY (codigo_aluno) REFERENCES aluno (codigo_aluno)
);

CREATE TABLE pedidos_detalhes
(
	codigo_pedido int unsigned not null,
    codigo_curso  smallint unsigned not null, 
    valor double unsigned not null,
    CONSTRAINT FK_codigo_pedido FOREIGN KEY (codigo_pedido) REFERENCES pedidos (codigo_pedido),
    CONSTRAINT FK_codigo_curso FOREIGN KEY (codigo_curso) REFERENCES cursos (codigo_curso)
);

ALTER TABLE aluno ADD data_nascimento varchar(10);
ALTER TABLE aluno CHANGE COLUMN data_nascimento nascimento DATE;
CREATE INDEX alunos ON aluno (nome_aluno);
ALTER TABLE instrutores ADD email_instrutor varchar(100);
CREATE INDEX cod_instutor ON cursos (codigo_instrutor);
ALTER TABLE instrutores DROP COLUMN email_instrutor;