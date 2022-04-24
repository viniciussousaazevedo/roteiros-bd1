-- QUESTÃO 1

---- LETRA A
CREATE VIEW vw_dptmgr 
AS SELECT Fname, dnumber 
FROM EMPLOYEE, DEPARTMENT 
WHERE ssn = mgrssn;

---- LETRA B
CREATE VIEW empl_houston 
AS SELECT ssn, fname 
FROM EMPLOYEE 
WHERE address LIKE '%Houston%';

---- LETRA C
CREATE VIEW vw_deptstats 
AS SELECT dnumber, dname, count(ssn) 
FROM EMPLOYEE, DEPARTMENT 
WHERE dnumber = dno 
GROUP BY dnumber;

---- LETRA D
CREATE VIEW vw_projstats
AS SELECT pno, count(essn)
FROM WORKS_ON
GROUP BY pno;

-- QUESTÃO 2

---- LETRA A
SELECT * FROM EMPLOYEE INNER JOIN DEPARTMENT ON ssn = mgrssn;

---- LETRA B
SELECT * FROM EMPLOYEE WHERE address LIKE '%TX';

---- LETRA C
SELECT fname, dno, dname FROM EMPLOYEE INNER JOIN DEPARTMENT ON dno = dnumber ORDER BY dno;

---- LETRA D
SELECT essn, pno FROM WORKS_ON ORDER BY pno;

-- QUESTÃO 3

DROP VIEW vw_dptmgr;
DROP VIEW empl_houston;
DROP VIEW vw_deptstats;
DROP VIEW vw_projstats;

-- QUESTÃO 4

CREATE FUNCTION check_age(essn CHAR(9))
RETURNS VARCHAR(7)
LANGUAGE plpgsql
AS
$$
DECLARE 
    idade INTEGER;
BEGIN
    SELECT extract(year from age(e.bdate)) INTO idade FROM EMPLOYEE e WHERE e.ssn = essn;
    IF idade IS NULL THEN RETURN 'UNKNOWN';
    ELSIF idade < 0 THEN RETURN 'INVALID';
    ELSIF idade  < 50 THEN RETURN 'YOUNG';
    ELSE RETURN 'SENIOR';
    END IF;
END;
$$;

-- QUESTÃO 5

CREATE FUNCTION check_mgr() RETURNS trigger AS $check_mgr$
    DECLARE 
        dep_numb INTEGER;
        manager_exists employee%rowtype;
        has_subordinates employee%rowtype;
    BEGIN

    SELECT * FROM EMPLOYEE INTO manager_exists WHERE ssn = NEW.mgrssn;

    IF NOT found THEN RAISE EXCEPTION 'manager must be a departments employee';
    END IF;

    SELECT dno INTO dep_numb FROM EMPLOYEE WHERE ssn = NEW.mgrssn LIMIT 1;

    IF (NEW.mgrssn IS NULL) OR (dep_numb <> NEW.dnumber) THEN RAISE EXCEPTION 'manager must be a departments employee';
    END IF;

    IF check_age(NEW.mgrssn) != 'SENIOR' THEN RAISE EXCEPTION 'manager must be a SENIOR employee';
    END IF;

    SELECT * FROM EMPLOYEE INTO has_subordinates WHERE superssn = NEW.mgrssn;
    IF NOT found THEN RAISE EXCEPTION 'manager must have supervisees';
    END IF;
    RETURN NEW;
    END;
$check_mgr$ LANGUAGE plpgsql;

CREATE TRIGGER check_mgr BEFORE INSERT OR UPDATE ON DEPARTMENT
    FOR EACH ROW EXECUTE PROCEDURE check_mgr();
