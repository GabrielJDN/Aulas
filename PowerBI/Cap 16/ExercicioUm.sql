SELECT round(AVG(idade),2) AS "média idade", numero_filhos, grau_instrucao
FROM cap16."TB_funcionarios"
WHERE reg_procedencia = 'capital' 
  AND estado_civil = 'casado'
  AND salario_hora > (SELECT AVG(salario_hora) FROM cap16."TB_funcionarios")
GROUP BY grau_instrucao, numero_filhos
order by round(AVG(idade)) DESC;