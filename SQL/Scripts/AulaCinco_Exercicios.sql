USE curso_sql;

# Exercício 1: Realize os seguintes comandos
# 1.1 - Exiba uma lista com os títulos dos cursos da SoftBlue e seu tipo de curso ao lado;
SELECT * FROM cursos;
SELECT c.nome_curso, tc.tipo FROM cursos c INNER JOIN tipo_curso tc ON tc.codigo_tipo_curso=c.codigo_tipo_curso;

# 1.2 - Exiba uma lista com os títulos dos cursos da SoftBlue, tipo do curso, nome do instrutor e telefone do instrutor;
SELECT c.nome_curso, tc.tipo, i.nome_instrutor, i.telefone_instrutor
FROM cursos c 
INNER JOIN tipo_curso tc ON tc.codigo_tipo_curso=c.codigo_tipo_curso
INNER JOIN instrutores i ON i.codigo_instrutor=c.codigo_instrutor;

# 1.3 - Exiba uma lista com o código, a data e a hora dos pedidos junto do código dos cursos de cada pedido;
SELECT p.codigo_pedido, p.dia, p.hora, pd.codigo_curso
FROM pedidos p
INNER JOIN pedidos_detalhes pd ON pd.codigo_pedido = p.codigo_pedido;
SELECT * FROM pedidos;
SELECT * FROM pedidos_detalhes;

# 1.4 - Exiba uma lista com o código, a data e a hora dos pedidos junto com o nome dos cursos de cada pedido;
SELECT p.codigo_pedido, p.dia, p.hora, c.nome_curso
FROM pedidos p
INNER JOIN pedidos_detalhes pd ON pd.codigo_pedido = p.codigo_pedido
INNER JOIN cursos c ON c.codigo_curso = pd.codigo_curso;

# 1.5 - Exiba uma lista com o código, a data e a hora dos pedidos junto com o nome do curso e do aluno que fez cada pedido;
SELECT p.codigo_pedido, p.dia, p.hora, a.nome_aluno, c.nome_curso
FROM pedidos p
INNER JOIN pedidos_detalhes pd ON pd.codigo_pedido = p.codigo_pedido
INNER JOIN aluno a ON a.codigo_aluno = p.codigo_aluno
INNER JOIN cursos c ON c.codigo_curso = pd.codigo_curso;

# Exercício 2: Realize as seguintes instruções:

# 2.1 - Crie uma visão que traga o título e o preço somente dos cursos de Programação da SoftBlue;
CREATE VIEW cursos_e_tipos AS 
SELECT c.nome_curso, c.valor, tc.tipo FROM cursos c 
INNER JOIN tipo_curso tc ON tc.codigo_tipo_curso = c.codigo_tipo_curso WHERE tc.tipo='Programação';

# 2.2 - Crie uma visão que traga os títulos dos cursos, tipo do curso e o nome do instrutor;
SELECT c.nome_curso, tc.tipo, i.nome_instrutor FROM cursos c 
INNER JOIN tipo_curso tc ON c.codigo_tipo_curso = tc.codigo_tipo_curso
INNER JOIN instrutores i ON c.codigo_instrutor = i.codigo_instrutor;

# 2.3 - Crie uma visão contendo os pedidos realizados, informando o nome do aluno, data e código do pedido;
SELECT p.codigo_pedido, a.nome_aluno, p.dia, p.hora 
FROM pedidos p 
INNER JOIN aluno a USING (codigo_aluno);