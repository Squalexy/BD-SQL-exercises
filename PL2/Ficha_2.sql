-- ex1

SELECT *
FROM dep;

-- ex2

SELECT nome, funcao, sal, ndep
FROM emp;

-- ex3

SELECT nome, ndep, sal
FROM emp
WHERE sal BETWEEN 150000 AND 300000;

-- ex4

SELECT *
FROM dep
ORDER BY ndep DESC;

-- ex5

SELECT DISTINCT funcao
FROM emp;

-- ex6

SELECT nome, funcao, premios
FROM emp
WHERE premios IS NOT null;

-- ex7

SELECT *
FROM emp
WHERE ndep IN (10,30);

-- ex8

SELECT nome
FROM emp
WHERE ndep = 20;

-- ex9

SELECT nome, funcao
FROM emp
WHERE nome LIKE '%v%' OR nome LIKE '%u%';

-- ex10

SELECT nome,funcao
FROM emp
WHERE nome LIKE 'A%' AND nome LIKE '%us%' OR nome LIKE 'R%' AND nome LIKE '%ei%';

-- ex11

SELECT nome, funcao, sal * 12 + COALESCE(premios,0) "renum_anual"
FROM emp

-- ex12

SELECT nome, CAST((sal * 12 + premios) * 0.1 as int) as "10%Sal.Anual", premios
FROM emp
WHERE premios < CAST((sal * 12 + premios) * 0.1 as int)
ORDER BY CAST((sal * 12 + premios) * 0.1 as int), nome;