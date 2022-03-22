-- ex1

SELECT MIN(emp.sal) AS "Salário mínimo"
FROM emp

-- ex2

SELECT nome, funcao, sal
FROM emp
WHERE sal = (SELECT min(sal)
			FROM emp)
			
-- ex3

SELECT nome, funcao, sal
FROM emp
WHERE funcao = (SELECT funcao
			   FROM emp
			   WHERE nome = 'Olga Costa')
			   
-- ex4

SELECT nome, sal, ndep
FROM emp
WHERE (sal, ndep) IN (SELECT max(sal), ndep
					  FROM emp
					  GROUP BY ndep)
					  
-- ex5

SELECT nome, sal, funcao, ndep
FROM emp
WHERE sal > ANY (SELECT sal
				 FROM emp
				 WHERE ndep = 30)
				 
-- ex6

SELECT nome, sal, funcao, ndep
FROM emp
WHERE sal > ALL (SELECT sal
				 FROM emp, dep
				 WHERE emp.ndep = dep.ndep AND dep.nome = 'Vendas')
				 
-- ex7

SELECT dep.nome, round(avg(sal), 2)
FROM dep, emp
WHERE emp.ndep = dep.ndep
GROUP BY dep.nome
HAVING avg(sal) > (SELECT avg(sal)
				   FROM emp
				   WHERE ndep = 30)
				   
-- ex9

CREATE TABLE emp2
(nemp NUMERIC(4) CONSTRAINT pk_emp PRIMARY KEY,
nome VARCHAR(20) CONSTRAINT nn_nome NOT NULL
CONSTRAINT upper_nome CHECK (nome = UPPER(nome)),
funcao VARCHAR(12),
encar NUMERIC CONSTRAINT fk_encar REFERENCES emp2(nemp),
data_entrada DATE DEFAULT CURRENT_DATE,
sal NUMERIC(7) CONSTRAINT ck_sal CHECK (sal>70000),
premios NUMERIC(7) DEFAULT NULL,
ndep NUMERIC(2) CONSTRAINT nn_dep NOT NULL
CONSTRAINT fk_ndep REFERENCES dep(ndep));

-- ex10

INSERT INTO emp2 (nemp, nome, funcao, encar, data_entrada, sal, premios, ndep)
VALUES (5555, 'CHICO FININHO', 'Cantor', null, current_date, 100000, null, 40)

-- ex11

INSERT INTO emp2 (SELECT nemp, UPPER(nome), funcao, encar, data_entrada, GREATEST(sal, 70001), premios, ndep
	              FROM emp
	              WHERE nemp NOT IN (1982, 1369))

-- ex12

DELETE FROM emp2
WHERE ndep = 10

-- ex13

DELETE FROM emp2
WHERE ndep = 20

-- ex14

DELETE FROM emp2
WHERE nemp = 1654

-- ex15

DELETE 
FROM emp2 e2
WHERE e2.sal < (SELECT AVG(e2i.sal)
				FROM emp2 e2i
			    WHERE e2i.ndep = e2.ndep)