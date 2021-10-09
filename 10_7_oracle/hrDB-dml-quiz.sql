-- 문제 1> employees 테이블에 employee_id, last_name, email, hire_date,salary, department_id
-- 컬럼만 복사하세요. 테이블명 emp_test
-- departments 테이블도 dept_test로 복사하세요.
create table emp_test 
as 
select employee_id, last_name, email,hire_date, salary, department_id  
from employees;

create table dept_test 
as 
select * from departments;

-- 문제 2> dept_test 테이블에 아래와 같은 부서를 등록하세요.
--300, 'mysql', null, 1800
--310, 'oracle', null, 1900
--320, 'postgreSQL', null, 3000
--330, 'mariaDB', null, 3200
insert into dept_test values(300, 'mysql', '', 1800);
insert into dept_test values(310, 'oracle', '', 1900);
insert into dept_test values(320, 'postgreSQL', '', 3000);
insert into dept_test values(330, 'mariaDB', '', 3200);

-- 문제 3> emp_test 테이블에도 아래와 같이 3명의 사원정보를 등록하세요.
--251, 'kim', 'test1@naver.com', '2021-01-02', 5000, 30
--252, 'lee', 'test2@naver.com', '2021-02-21', 2800, 50
--253, 'park', 'test3@google.com', '2021-04-11', 4400, 30
INSERT INTO emp_test
VALUES(251, 'kim', 'test@naver.com', TO_DATE('2021-01-02', 'YYYY-MM-DD'), 5000, 30); 
INSERT INTO emp_test
VALUES(252, 'lee', 'test1@naver.com', TO_DATE('2021-02-21', 'YYYY-MM-DD'), 2800, 50); 
INSERT INTO emp_test
VALUES(253, 'park', 'test2@naver.com', TO_DATE('2021-04-11', 'YYYY-MM-DD'), 4400,30);

-- 문제 4> emp_test 테이블에서 30번 부서에 근무하는 사원들의 평균 급여보다 많은 급여를
-- 받고 있는 사원들을 70번 부서로 옮기는 SQL문을 작성하세요.
UPDATE emp_test
   SET department_id = 70
 WHERE salary > (SELECT AVG(salary)
                FROM emp_test
               WHERE department_id = 30);

select * from emp_test;

-- 문제 5> emp_test 테이블에서 50번 부서의 사원 중에 입사일이 가장 빠른 사원보다 늦게 입사한
-- 사원의 급여를 10%인상하고 80번 부서로 옮기는 SQL문을 작성하세요.

UPDATE emp_test
   SET salary = salary*1.1,
       department_id = 80
 WHERE hire_date > (SELECT MIN(hire_date)
                     FROM emp_test
                    WHERE department_id = 50);
                    
-- 문제 6> 급여등급이 5인 사원을 삭제하세요.
DELETE FROM emp_test
 WHERE employee_id IN (SELECT E.employee_id
                   FROM emp_test E, SAL_GRADE S
                  WHERE E.salary BETWEEN S.low_sal AND S.high_sal
                    AND S.grade = 5);






