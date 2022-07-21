SELECT AVG(salario_hora) AS "Media Salario", estado 
FROM cap16."TB_funcionarios" JOIN cap16."TB_ENDERECO" 
ON cap16."TB_funcionarios".id_func = cap16."TB_ENDERECO".id_func
GROUP BY estado;