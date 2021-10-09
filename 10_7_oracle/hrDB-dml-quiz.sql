-- ���� 1> employees ���̺� employee_id, last_name, email, hire_date,salary, department_id
-- �÷��� �����ϼ���. ���̺�� emp_test
-- departments ���̺� dept_test�� �����ϼ���.
create table emp_test 
as 
select employee_id, last_name, email,hire_date, salary, department_id  
from employees;

create table dept_test 
as 
select * from departments;

-- ���� 2> dept_test ���̺� �Ʒ��� ���� �μ��� ����ϼ���.
--300, 'mysql', null, 1800
--310, 'oracle', null, 1900
--320, 'postgreSQL', null, 3000
--330, 'mariaDB', null, 3200
insert into dept_test values(300, 'mysql', '', 1800);
insert into dept_test values(310, 'oracle', '', 1900);
insert into dept_test values(320, 'postgreSQL', '', 3000);
insert into dept_test values(330, 'mariaDB', '', 3200);

-- ���� 3> emp_test ���̺��� �Ʒ��� ���� 3���� ��������� ����ϼ���.
--251, 'kim', 'test1@naver.com', '2021-01-02', 5000, 30
--252, 'lee', 'test2@naver.com', '2021-02-21', 2800, 50
--253, 'park', 'test3@google.com', '2021-04-11', 4400, 30
INSERT INTO emp_test
VALUES(251, 'kim', 'test@naver.com', TO_DATE('2021-01-02', 'YYYY-MM-DD'), 5000, 30); 
INSERT INTO emp_test
VALUES(252, 'lee', 'test1@naver.com', TO_DATE('2021-02-21', 'YYYY-MM-DD'), 2800, 50); 
INSERT INTO emp_test
VALUES(253, 'park', 'test2@naver.com', TO_DATE('2021-04-11', 'YYYY-MM-DD'), 4400,30);

-- ���� 4> emp_test ���̺��� 30�� �μ��� �ٹ��ϴ� ������� ��� �޿����� ���� �޿���
-- �ް� �ִ� ������� 70�� �μ��� �ű�� SQL���� �ۼ��ϼ���.
UPDATE emp_test
   SET department_id = 70
 WHERE salary > (SELECT AVG(salary)
                FROM emp_test
               WHERE department_id = 30);

select * from emp_test;

-- ���� 5> emp_test ���̺��� 50�� �μ��� ��� �߿� �Ի����� ���� ���� ������� �ʰ� �Ի���
-- ����� �޿��� 10%�λ��ϰ� 80�� �μ��� �ű�� SQL���� �ۼ��ϼ���.

UPDATE emp_test
   SET salary = salary*1.1,
       department_id = 80
 WHERE hire_date > (SELECT MIN(hire_date)
                     FROM emp_test
                    WHERE department_id = 50);
                    
-- ���� 6> �޿������ 5�� ����� �����ϼ���.
DELETE FROM emp_test
 WHERE employee_id IN (SELECT E.employee_id
                   FROM emp_test E, SAL_GRADE S
                  WHERE E.salary BETWEEN S.low_sal AND S.high_sal
                    AND S.grade = 5);






