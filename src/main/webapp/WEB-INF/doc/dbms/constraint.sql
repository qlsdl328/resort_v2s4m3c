-- constraint.sql
1) 테이블 생성
CREATE TABLE department(
  no       NUMBER(10)      NOT NULL,
  name   VARCHAR(100)   NOT NULL,
  PRIMARY KEY(no)
);

2) 제약 조건의 확인
SELECT constraint_name, constraint_type, search_condition
FROM ALL_CONSTRAINTS
WHERE TABLE_NAME='DEPARTMENT';

CONSTRAINT_NAME                C SEARCH_CONDITION                                                                
------------------------------ - --------------------------------------------------------------------------------
SYS_C007433                    C "NO" IS NOT NULL                                                                
SYS_C007434                    C "NAME" IS NOT NULL                                                              
SYS_C007435                    P                                                                                 

2) 제약 조건의 삭제
ALTER TABLE department DROP CONSTRAINT SYS_C007435;

SELECT constraint_name, constraint_type, search_condition
FROM ALL_CONSTRAINTS
WHERE TABLE_NAME='DEPARTMENT';

CONSTRAINT_NAME                C SEARCH_CONDITION                                                                
------------------------------ - --------------------------------------------------------------------------------
SYS_C007433                    C "NO" IS NOT NULL                                                                
SYS_C007434                    C "NAME" IS NOT NULL                                                              

3) 제약 조건의 추가
ALTER TABLE department ADD CONSTRAINT department_pk PRIMARY KEY (no);

4) FK 테이블 생성
DROP TABLE employee;
CREATE TABLE employee(
  empno  NUMBER(10)      NOT NULL,  -- PK
  name    VARCHAR(100)   NOT NULL,
  no        NUMBER(10)      NOT NULL,  -- FK
  PRIMARY KEY(empno)
);

5) FK 추가
ALTER TABLE employee ADD CONSTRAINT employee_department_fk 
                                 FOREIGN KEY (no) REFERENCES department(no);
                                 
SELECT constraint_name, constraint_type, search_condition
FROM ALL_CONSTRAINTS
WHERE TABLE_NAME='EMPLOYEE';

CONSTRAINT_NAME                    C   SEARCH_CONDITION                                                                
------------------------------           -   --------------------------------------------------------------------------------
EMPLOYEE_DEPARTMENT_FK         R                                                                                 
SYS_C007441                              C   "EMPNO" IS NOT NULL                                                             
SYS_C007442                              C   "NAME" IS NOT NULL                                                              
SYS_C007443                              C   "NO" IS NOT NULL                                                                
SYS_C007444                              P           




