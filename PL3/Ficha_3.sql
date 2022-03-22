-- ex1

SELECT emp.nome, emp.funcao, dep.nome
FROM dep, emp
WHERE dep.ndep = emp.ndep
ORDER BY dep.nome, emp.nome;

-- ex2

SELECT emp.nome, sal, emp.ndep, dep.nome
FROM dep, emp
WHERE dep.ndep = emp.ndep and emp.nome like 'A% R%';

-- ex3

SELECT emp.nome, sal, dep.nome, dep.local
FROM dep, emp
WHERE dep.ndep = emp.ndep and sal > 150000;

-- ex5

SELECT DISTINCT escalao, funcao
FROM emp, descontos
WHERE sal BETWEEN salinf AND salsup 
ORDER by escalao, funcao

-- ex6

SELECT emp.nome, emp.funcao, emp.sal
FROM emp, descontos
WHERE descontos.escalao = 4 AND sal BETWEEN salinf AND salsup
ORDER BY emp.nome

-- ex7

SELECT emp.nome, emp.funcao, emp.sal
FROM emp, descontos
WHERE descontos.escalao = 4 AND sal BETWEEN salinf AND salsup
ORDER BY emp.nome

-- ex8

SELECT emp.nome, emp.funcao, dep.local
FROM emp, dep
WHERE dep.ndep = emp.ndep AND dep.local = 'Coimbra' AND sal > 150000

-- ex9

SELECT emp.nome, emp.funcao, descontos.escalao, dep.nome
FROM emp, descontos, dep
WHERE emp.ndep = dep.ndep AND emp.funcao <> 'Continuo' AND sal BETWEEN salinf AND salsup
ORDER BY descontos.escalao DESC

-- ex10

SELECT e1.nome AS nome , e2.nome AS subordinado
FROM emp AS e1, emp AS e2
WHERE e1.nemp = e2.encar
ORDER BY e1.nome, e2.nome

-- ex11

SELECT dep.ndep, dep.nome, dep.local
FROM dep
EXCEPT
SELECT dep.ndep, dep.nome, dep.local
FROM dep, emp
WHERE dep.ndep = emp.ndep