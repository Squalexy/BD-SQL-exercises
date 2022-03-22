-- ex1

SELECT UPPER(emp.nome) AS Nome, LOWER(emp.funcao) AS Funcao, dep.nome AS Departamento
FROM emp, dep
WHERE emp.ndep = dep.ndep AND emp.funcao = 'Vendedor'
ORDER BY emp.nome

-- ex2

SELECT COUNT(emp.nome) AS "Lista de empregados"
FROM emp

-- ex3

SELECT COUNT(*) AS "Empregados sem premio"
FROM emp
WHERE emp.premios IS NULL

-- ex4

SELECT COUNT(emp.nome) AS "Total de empregados", ROUND(AVG(emp.sal),2) AS "Salário médio mensal", SUM(emp.sal * 12 + COALESCE(emp.premios, 0)) AS "Renumeração total anual"
FROM emp

-- ex5

SELECT emp.nome as "NOME", emp.funcao AS "FUNCAO", emp.sal AS "SAL", ROUND(emp.sal*1.1355, 1) as "Salário com aumento"
FROM emp 
WHERE emp.funcao = 'Continuo' 

-- ex6

SELECT emp.nome as "NOME", emp.funcao AS "FUNCAO", emp.sal AS "SAL", CEIL(emp.sal*1.1355) as "Salário com aumento"
FROM emp 
WHERE emp.funcao = 'Continuo' 

-- ex7

SELECT RPAD(CONCAT('>>>> ',emp.nome, ' '), 25, '<') AS "Strings"
FROM emp
ORDER BY emp.nome ASC

-- ex8

SELECT MIN(sal), MAX(sal), ROUND(AVG(sal),2)
FROM emp

-- ex9

SELECT emp.ndep, MAX(emp.sal) - MIN(emp.sal) AS "Diferença"
FROM emp
GROUP BY emp.ndep 
ORDER BY emp.ndep ASC

-- ex10

SELECT emp.funcao as "FUNCAO", COUNT(emp.funcao) AS "Quantidade"
FROM emp
GROUP BY emp.funcao

-- ex11

SELECT emp.funcao as "FUNCAO", COUNT(emp.funcao) AS "Quantidade"
FROM emp
WHERE emp.funcao LIKE 'Analista' OR emp.funcao LIKE '%o'
GROUP BY emp.funcao
ORDER BY emp.funcao ASC

-- ex12

SELECT COALESCE(emp.encar, 0) AS "Encarregado", MIN(emp.sal) AS "Salário mínimo"
FROM emp
GROUP BY emp.encar HAVING MIN(emp.sal) > 200000
ORDER BY MIN(emp.sal)

-- ex13

SELECT emp.funcao, CEIL(AVG(emp.sal))
FROM emp
GROUP BY emp.funcao
HAVING COUNT(emp.funcao) > 1
ORDER BY AVG(CEIL(emp.sal))

-- ex14

SELECT ndep, funcao, MAX(sal) "Salário máximo", MIN(sal) "Salário mínimo", ROUND(AVG(sal),0) "Salário médio", COUNT(emp.funcao) "Número de empregados"
FROM emp
WHERE nome <> 'Jorge Sampaio'
GROUP BY ndep, funcao
HAVING MAX(sal) > 200000
ORDER BY ndep, MAX(sal)																				 
																								 
																								 