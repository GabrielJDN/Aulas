#Os comandos dessa aula são usados a nível de servidor, portanto não precisamos especificar o banco de dados que estamos trabalhando.

#Cria o usuário no servidor SQL;
# CREATE USER 'usuário'@'local_de_acesso(ip)' IDENTIFIED BY senha;
#CREATE USER 'gabriel'@'200.200.190.190' IDENTIFIED BY 'gabriel123456';
#Aqui, especificamos o IP que o usuário precisa ter para acessar o banco de dados;

CREATE USER 'gabriel'@'localhost' IDENTIFIED BY 'gabriel123456';
#LocalHost é a minha própria máquina;

CREATE USER 'gabriel2'@'%' IDENTIFIED BY 'gabriel2123456';
#O símbolo '%' significa que o usuário vai poder se conectar de qualquer lugar;

GRANT ALL ON curso_sql.* TO 'gabriel'@'localhost';
# ALL -> Todas as ações possíveis, é basicamente um administrador do banco; Caso queiramos dar acesso apenas para a "leitura" dos dados, usamos o comando
#SELECT ao invés de ALL.
#ON curso_sql.* -> Todas as estruturas possíveis do banco;

GRANT SELECT ON curso_sql.funcionarios TO 'gabriel2'@'%';
#Para o usuário que está em qualquer lugar ele pode acessar apenas a tabela "funcionarios" e pode apenas lê-lá.

REVOKE SELECT ON curso_sql.funcionarios FROM 'gabriel2'@'%'; 
#Aqui, retiro a ação de leitura de dados do usuário gabriel2 que pode acessá-las de qualquer IP.

REVOKE SELECT ON curso_sql.funcionarios FROM 'gabriel'@'localhost';
# Podemos ver que esse comando gera um erro, isso é uma limitação do MySQL onde eu dou ou acesso a tudo (como feito anteriormente) e retiro todo o acesso
#ou eu dou acesso de "um em um".
REVOKE SELECT ON curso_sql.* FROM 'gabriel'@'localhost';
#Mas, eu posso retirar parte do acesso do usuário que ganhou todo tipo de acesso.
REVOKE ALL ON curso_sql.* FROM 'gabriel'@'localhost';

#Para ver todos os usuários do banco de dados;
SELECT USER FROM mysql.user;
SHOW GRANTS FOR 'gabriel'@'localhost';

DROP USER 'gabriel'@'localhost';
DROP USER 'gabriel2'@'%';