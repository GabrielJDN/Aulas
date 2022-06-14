USE curso_sql;
# Exercício 1:
# 1.1 - Selecione o nome de todos os aluno que já alguma matrícula na SoftBlue SEM REPETIÇÃO.
SELECT DISTINCT(a.nome_aluno) FROM aluno a
INNER JOIN pedidos p ON p.codigo_aluno=a.codigo_aluno;

# 1.2 - Exiba o nome do aluno mais ANTIGO da SoftBlue;
#Primeiro uno as tabelas em questão e depois eu faço o agrupamento;
SELECT p.codigo_aluno, p.dia, p.hora, a.nome_aluno, a.email_aluno FROM pedidos p INNER JOIN aluno a ON p.codigo_aluno=a.codigo_aluno
ORDER BY dia, hora LIMIT 1;

# 1.3 - Exiba o nome do aluno mais RECENTE da SoftBlue;
SELECT a.nome_aluno FROM pedidos p INNER JOIN aluno a ON p.codigo_aluno=a.codigo_aluno
ORDER BY dia DESC, hora DESC LIMIT 1;

# 1.4 - Exiba o nome do TERCEIRO aluno mais ANTIGO da SoftBlue;
SELECT a.nome_aluno FROM pedidos p INNER JOIN aluno a ON p.codigo_aluno=a.codigo_aluno
ORDER BY dia,hora LIMIT 1 OFFSET 2;

# 1.5 - Exiba a quantidade de cursos que já foram vendidos na SoftBlue; 
SELECT count(*) FROM pedidos_detalhes;

# 1.6 - Exiba o total arrecadado pelos cursos que já foram vendidos na SoftBlue;
SELECT sum(valor) FROM pedidos_detalhes;

# 1.7 - Exiba o valor total de CADA PEDIDO realizado na SoftBlue;
SELECT sum(valor) FROM pedidos_detalhes GROUP BY codigo_pedido;

# 1.8 - Exiba o nome dos instrutores da SoftBlue e a quantidade de cursos que cada um deles ministra;
SELECT i.nome_instrutor AS 'Instrutor', count(c.nome_curso) AS 'Número de Cursos' FROM instrutores i
INNER JOIN cursos c ON c.codigo_instrutor=i.codigo_instrutor
GROUP BY i.nome_instrutor;

# 1.9 - Exiba o número do pedido, o nome do aluno e quantos cursos foram comprados no pedido para todos os pedidos realizados na SoftBlue cujo
#valor seja maior que 500;
SELECT pd.codigo_pedido, a.nome_aluno, count(pd.codigo_pedido) FROM pedidos_detalhes pd 
INNER JOIN pedidos p ON pd.codigo_pedido=p.codigo_pedido
INNER JOIN aluno a ON p.codigo_aluno = a.codigo_aluno
GROUP BY nome_aluno HAVING sum(pd.valor)>500;

# 1.10 - Exiba o nome e endereço de todos os alunos que moram em Avenidas (Av.);
SELECT a.nome_aluno, a.endereco_aluno FROM aluno a
WHERE a.endereco_aluno LIKE 'Av.%';

# 1.11 - Exiba o nome de todos os cursos de JAVA da SoftBlue;
SELECT c.nome_curso FROM cursos c
WHERE c.nome_curso LIKE 'Java%';

# Exercício 2:

# 2.1 - Utilizando subquery, exiba uma lista com os nomes dos cursos disponibilizados pela SoftBlue informando o menor valor já praticado para
#cada curso;
SELECT c.nome_curso, (SELECT min(pd.valor) FROM pedidos_detalhes pd WHERE pd.codigo_curso=c.codigo_curso) AS 'Menor Valor' FROM cursos c;

# 2.2 - Utilizando subquery e o parâmetro IN, exiba o nome dos cursos disponibilizados pela SoftBlue cujo tipo de curso seja "Programação";
SELECT c.nome_curso FROM cursos c WHERE c.codigo_tipo_curso IN 
(SELECT tc.codigo_tipo_curso FROM tipo_curso tc WHERE tc.tipo='Programação');

# 2.3 - Utilizando subquery e o parâmetro EXISTS, exiba os nomes dos cursos disponibilizados pela SoftBlue cujo tipo de curso seja "Programação";
SELECT c.nome_curso FROM cursos c WHERE EXISTS 
(SELECT tp.codigo_tipo_curso FROM tipo_curso tp WHERE tp.tipo='Programação' AND tp.codigo_tipo_curso=c.codigo_tipo_curso);

# 2.4 - Exiba uma lista com os instutores da SoftBlue e o total acumulado das vendas referentes aos cursos que eles ministram;
SELECT i.nome_instrutor AS 'Nome do Instrutor', 
(SELECT sum(pd.valor) FROM pedidos_detalhes pd INNER JOIN cursos c ON pd.codigo_curso=c.codigo_curso WHERE i.codigo_instrutor = c.codigo_instrutor) 
AS 'Valor Total' FROM instrutores i;
#Importante notar que, aparentemente, em subqueries eu posso "misturar" os apelidos de o que vêm de onde para obter um resultdo!

#Uma outra maneira de resolver o problema!
SELECT i.nome_instrutor AS 'Nome do Instrutor', sum(pd.valor) AS 'Valor Total'
FROM cursos c INNER JOIN instrutores i ON i.codigo_instrutor=c.codigo_instrutor
INNER JOIN pedidos_detalhes pd ON pd.codigo_curso=c.codigo_curso
GROUP BY nome_instrutor; 

# 2.5 - Crie uma visão que exiba os nomes dos alunos e quanto cada um já comprou em cursos;
CREATE VIEW gasto_por_aluno AS
SELECT a.nome_aluno AS 'Nome do aluno', 
(SELECT sum(pd.valor) FROM pedidos_detalhes pd INNER JOIN pedidos p ON pd.codigo_pedido=p.codigo_pedido WHERE a.codigo_aluno = p.codigo_aluno) 
AS 'Total gasto pelo aluno' FROM aluno a;

SELECT * FROM gasto_por_aluno;