-- QUESTÃO 1

SELECT count(fname) FROM employee WHERE sex = 'F';

-- QUESTÃO 2

SELECT avg(salary) FROM employee WHERE address LIKE '%TX%' and sex = 'M';

-- QUESTÃO 3

SELECT s.ssn AS ssn_supervisor, count(e.fname) AS qtd_supervisionados FROM employee e LEFT OUTER JOIN employee s ON s.ssn = e.superssn GROUP BY s.ssn ORDER BY qtd_supervisionados;

-- QUESTÃO 4

SELECT s.fname AS nome_supervisor, count(e.fname) AS qtd_supervisionados FROM employee s INNER JOIN employee e on s.ssn = e.superssn GROUP BY s.ssn ORDER BY qtd_supervisionados;

-- QUESTÃO 5

SELECT s.fname AS nome_supervisor, count(e.fname) AS qtd_supervisionados FROM employee s RIGHT OUTER JOIN employee e on s.ssn = e.superssn GROUP BY s.ssn ORDER BY qtd_supervisionados;

-- QUESTÃO 6

SELECT min(qtd) AS qtd_minima FROM (SELECT count(essn) AS qtd FROM works_on GROUP BY pno) AS qtd_func_por_projeto;

-- QUESTÃO 7

SELECT pno AS num_projeto, min(qtd_func) 
FROM (     
        SELECT pno, count(essn) AS qtd_func FROM works_on GROUP BY pno 
    ) AS t 
WHERE qtd_func = (     
    SELECT min(qtd) AS qtd_minima 
    FROM (         
        SELECT count(essn) AS qtd FROM works_on GROUP BY pno     
    ) AS qtd_func_por_projeto 
    ) GROUP BY pno;

-- QUESTÃO 8

SELECT pno AS num_proj, avg(salary) AS media_sal FROM employee e INNER JOIN works_on w ON essn = ssn GROUP BY pno;

-- QUESTÃO 9

SELECT pnumber AS num_proj, pname AS proj_nome, avg(salary)
FROM employee e INNER JOIN works_on w ON essn = ssn INNER JOIN project p ON pno = pnumber
GROUP BY pnumber;

-- QUESTÃO 10

SELECT fname, salary 
FROM employee LEFT OUTER JOIN works_on ON essn = ssn 
WHERE (pno <> 92 OR pno IS NULL) AND salary > (SELECT max(salary) FROM employee INNER JOIN works_on ON essn = ssn WHERE pno = 92);

-- QUESTÃO 11

SELECT ssn, count(pno) AS qtd_proj  FROM employee LEFT OUTER JOIN works_on ON essn = ssn  GROUP BY ssn  ORDER BY count(pno);

-- QUESTÃO 12

SELECT pno as num_proj, count(ssn) as qtd_func
FROM employee LEFT OUTER JOIN works_on ON essn = ssn
GROUP BY num_proj
HAVING count(essn) < 5
ORDER BY qtd_func;

-- QUESTÃO 13

SELECT fname FROM (
    SELECT fname, ssn FROM employee WHERE ssn IN (
        SELECT essn FROM works_on WHERE pno IN (
            SELECT pnumber FROM project WHERE plocation = 'Sugarland'
        )
    )
) AS w WHERE w.ssn IN (SELECT essn FROM dependent WHERE essn IS NOT NULL);

-- QUESTÃO 14

SELECT dname FROM department EXCEPT (SELECT dname FROM department, project WHERE dnum = dnumber);

-- QUESTÃO 15

SELECT e.fname, e.lname
FROM employee e
WHERE NOT EXISTS (
    (SELECT pno FROM works_on WHERE essn = '123456789') 
    EXCEPT 
    (SELECT pno FROM works_on WHERE essn = e.ssn AND essn != '123456789')
);

-- QUESTÃO 16

