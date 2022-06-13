use curso_sql;

# Exercício 1 - Inserir dados nas tabelas (tipo_curso, instrutores, cursos, aluno, pedido, pedido_detalhes)

INSERT INTO tipo_curso (codigo_tipo_curso, tipo) VALUES 
(1, 'Banco de dados'),
(2, 'Programação'),
(3, 'Modelagem de dados');
INSERT INTO instrutores (codigo_instrutor,nome_instrutor,telefone_instrutor) VALUES 
(1,'André Milani','1111-1111'),
(2,'Carlos Tosin','1212-1212');
INSERT INTO cursos (codigo_curso,nome_curso,codigo_tipo_curso,codigo_instrutor,valor) VALUES
(1,'Java Fundamentos',2,2,270),
(2,'Java Avançado',2,2,330),
(3,'SQL Completo',1,1,170),
(4,'PHP Básico',2,1,270);
INSERT INTO aluno (codigo_aluno,nome_aluno,endereco_aluno,email_aluno) VALUES
(1,'José','RUA XV de Novembro 72', 'jose@softblue.com'),
(2,'Wagner','Av. Paulista','wagner@softblue.com'),
(3,'Emílio','Rua Lajes 103, ap:701','emilio@softblue.com'),
(4,'Cris','Rua Tauney 22','cris@softblue.com'),
(5,'Regina','Rua Salles 305','regina@softblue.com'),
(6,'Fernando','Av. centrl', 'fernando@softblue.com');
INSERT INTO pedidos (codigo_pedido,codigo_aluno,dia,hora) VALUES 
(1,2,'2010/04/15','11:23:32'),
(2,2,'2010/04/15','14:36:21'),
(3,3,'2010/04/16','11:17:45'),
(4,4,'2010/04/17','14:27:22'),
(5,5,'2010/04/18','11:18:19'),
(6,6,'2010/04/19','13:47:55'),
(7,6,'2010/04/20','18:13:44');
INSERT INTO pedidos_detalhes (codigo_pedido,codigo_curso,valor) VALUES
(1,1,270),
(1,2,330),
(2,1,270),
(2,2,330),
(2,3,170),
(3,4,270),
(4,2,330),
(4,4,270),
(5,3,170),
(6,3,170),
(7,4,270);

# Exercício 2 - Realizar as seguintes instruções
# 2.1 - Exibir todas as informações dos alunos;
SELECT * FROM aluno;
# 2.2 - Exibir somente o título de cada curso da SoftBlue;
SELECT nome_curso FROM cursos;
# 2.3 - Exibir somente o título e o valor de cada curso da SoftBlue cujo preço seja maior que 200;
SELECT nome_curso, valor FROM cursos WHERE valor>200;
# 2.4 - Exibir somente o título e o valor de cada curso da SoftBlu cujo preço seja maior que 200 e menor que 300;
SELECT nome_curso, valor FROM cursos WHERE valor BETWEEN 200 AND 300;
# 2.5 - Exibir os pedidos realizado entre 15/04/2010 e 18/04/2010;
SELECT * FROM pedidos WHERE dia BETWEEN '2010/04/15' AND '2010/04/18';

# Exercício 3 - Faça as seguintes alterações;
# 3.1 - Altere o endereço do aluno "José" para 'Av. Brasil 778';
UPDATE aluno SET endereco_aluno = 'Av. Brasil 778' WHERE codigo_aluno=1;
# 3.2 - Altere o e-mail do aluno "Cris" para 'cristiano@softblue.com';
UPDATE aluno SET email_aluno = 'cristiano@softblue.com' WHERE codigo_aluno=4;
# 3.3 - Aumente em 10% o valor dos cursos abaixo de 300;
SET SQL_SAFE_UPDATES= 0; #Permito alterações em massa na tabela;
SELECT * FROM cursos;
UPDATE cursos SET valor = round(valor*1.1,2) WHERE valor<300;
SET SQL_SAFE_UPDATES=1; #Retiro essas permissões!
# 3.4 - Altere o nome do curso PHP Básico para PHP Fundamentos;
UPDATE cursos SET nome_curso = 'PHP Fundamentos' WHERE codigo_curso=4;