USE curso_sql;
# Utilizando a função COUNT;
SELECT * FROM funcionarios;
SELECT COUNT(*) FROM funcionarios;
SELECT COUNT(*) FROM funcionarios WHERE salario>1600;
SELECT COUNT(*) FROM funcionarios WHERE salario>1600 AND departamento='Jurídico';

# Utilizando a função SUM;
SELECT SUM(salario) FROM funcionarios;
SELECT SUM(salario) FROM funcionarios WHERE departamento='TI';

# Utilizando a função AVG;
SELECT round(AVG(salario),2) FROM funcionarios;
SELECT round(AVG(salario),2) FROM funcionarios WHERE departamento='TI';

# Utilizando a função MAX;
SELECT MAX(salario) FROM funcionarios;
SELECT MAX(salario) FROM funcionarios WHERE departamento='TI';

# Utilizando a função MIN;
SELECT MIN(salario) FROM funcionarios;
SELECT MIN(salario) FROM funcionarios WHERE departamento='TI';

# Utilizando a função DISTINCT;
SELECT DISTINCT(departamento) FROM funcionarios;

# Ordenação de registros;
SELECT * FROM funcionarios ORDER BY salario;
SELECT * FROM funcionarios ORDER BY salario ASC;
SELECT * FROM funcionarios ORDER BY salario DESC;
SELECT * FROM funcionarios ORDER BY nome;
SELECT * FROM funcionarios ORDER BY departamento;
SELECT * FROM funcionarios ORDER BY departamento DESC, salario DESC;

#Comandos de paginação!
SELECT * FROM funcionarios LIMIT 2;
SELECT * FROM funcionarios LIMIT 1 OFFSET 1;
SELECT * FROM funcionarios LIMIT 1,1; #Outra forma de fazer o OFFSET.

#Função de agrupamento!
SELECT departamento, AVG(salario) FROM funcionarios WHERE departamento='TI' UNION
SELECT departamento, AVG(salario) FROM funcionarios WHERE departamento='Jurídico'; #Uma maneira de fazer!

SELECT departamento, AVG(salario) FROM funcionarios GROUP BY departamento;
SELECT departamento, AVG(salario) FROM funcionarios GROUP BY departamento HAVING AVG(salario)>2000;

#Para fechar, estudemos as subqueries!
SELECT nome FROM funcionarios WHERE departamento = 'TI' OR departamento = 'Jurídico';
SELECT nome FROM funcionarios WHERE departamento IN ('TI','Jurídico');

## Basicamente, pegamos o nome dos funcionários que façam parte do departamento dos quais eles fazem parte apresenta uma
##média salarial acima de dois mil.
SELECT nome FROM funcionarios WHERE departamento IN 
(SELECT departamento FROM funcionarios GROUP BY departamento HAVING AVG(salario)>1500);
## Vemos que temos apenas dois funcionários agora, um para cada departamento. Isso mostra a diferença entre o uso das subqueries e uma tentativa
##de fazer a mesma coisa usando o groupby.
SELECT nome FROM funcionarios GROUP BY departamento HAVING AVG(salario)>1500;