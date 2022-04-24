-- Questão 1

SELECT * FROM department;

-- Questão 2

SELECT * FROM dependent;

-- Questão 3

SELECT * FROM dept_locations;

-- Questão 4

SELECT * FROM employee;

-- Questão 5

SELECT * FROM project;

-- Questão 6

SELECT * FROM works_on;

-- Questão 7

SELECT fname, lname FROM employee WHERE sex = 'M';

-- Questão 8

SELECT fname FROM employee WHERE superssn IS NULL;

-- Questão 9

SELECT emp.fname, sup.fname FROM employee emp, employee sup WHERE sup.ssn = emp.superssn;

-- Questão 10

SELECT emp.fname FROM employee emp, employee sup WHERE sup.fname = 'Franklin' AND sup.ssn = emp.superssn;

-- Questão 11

SELECT dname, dlocation FROM department, dept_locations WHERE department.dnumber = dept_locations.dnumber;

-- Questão 12

SELECT dname FROM department, dept_locations WHERE department.dnumber = dept_locations.dnumber AND dept_locations.dlocation LIKE'S%';

-- Questão 13

SELECT fname, lname, dependent_name FROM employee E, dependent D WHERE E.ssn = D.essn;

-- Questão 14

SELECT fname || ' ' || minit || ' ' || lname AS full_name, salary FROM employee WHERE salary > 50000;

-- Questão 15

SELECT pname, dname FROM project, department WHERE dnum = dnumber;

-- Questão 16

SELECT p.pname, e.fname FROM project p, department d, employee e WHERE p.dnum = d.dnumber AND d.mgrssn = e.ssn;

-- Questão 17

SELECT pname, fname FROM project p, employee e, works_on w WHERE w.pno = p.pnumber AND w.essn = e.ssn;

-- Questão 18

SELECT fname, dependent_name, relationship FROM works_on w, employee e, dependent d WHERE w.pno = 91 AND w.essn = e.ssn AND d.essn = e.ssn ORDER BY relationship;