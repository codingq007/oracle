/*
    �����Լ� : sum(), count(), max(), min(), avg()
    ���� ���� ���� �����Ͽ� �ϳ��� ������ ��� ���
*/

-- sum(): �հ� ���ϴ� �Լ�
-- ������� �ѱ޿�
select to_char(sum(salary), '999,999,999') from employees;

--ORA-00937: ���� �׷��� �׷� �Լ��� �ƴմϴ�
select first_name, sum(salary) from employees;

-- all�� default��
select sum(salary), sum(distinct salary), sum(all salary) from employees;
select salary from employees;

-- count() : ������ ���� ���, *�� ����ϸ� select���� ��������� ���� ���� ���� ����
select count(*) from employees;
select count(salary) , count(distinct salary), count(all salary) from employees;

select * from employees;

-- �μ�Ƽ��(commission)�� �޴� ������� ����ϼ���.
select count(commission_pct)
from employees
where commission_pct is not null;

-- count�Լ��� null�����͸� ī��Ʈ ���� �ʴ´�.
select count(commission_pct)
from employees;

-- �μ�Ƽ�� ���� �����
select count(job_id)
from employees
where commission_pct is null;

-- max() , min() : �ִ�, �ּҰ�
select max(salary), min(salary)
from employees
where department_id = 30;

/* group by �� */
select department_id from employees;
select distinct department_id from employees;

select department_id from employees
group by department_id;

select department_id, sum(salary) 
from employees
group by department_id;

 -- �μ��� �� ��å�� ��� �޿��� ����ϼ���.
 select department_id, job_id, avg(salary)
 from employees
 group by department_id, job_id
 order by department_id, job_id; -- �μ���, ��å�� ����

-- �μ��� �����, �μ��� �ѱ޿�, �μ��� ��ձ޿� ��ȸ�ϼ���
select department_id, count(salary), sum(salary), avg(salary)
from employees
group by department_id;

-- �μ��� ���޺� ������� ��� �޿� ��ȸ�ϼ���.
 select department_id, job_id, count(salary), avg(salary)
 from employees
 group by department_id, job_id
 order by department_id, job_id; -- �μ���, ��å�� ����

-- 80�� �μ��� ���޺� �ѱ޿��� ��� �޿��� ���ϼ���.
select department_id, job_id,
    to_char(sum(salary), '999,999') "�ѱ޿�",
    to_char(avg(salary), '999,999') "��ձ޿�"
from employees
where department_id = 80
group by department_id, job_id
order by department_id, job_id; -- �μ���, ��å�� ����

-- group by ���� ���� ����
-- group by ���� ��õ��� �ʴ� column�� select���� ������� ��쿡�� 
-- ���� �߻� : ORA-00979: GROUP BY ǥ������ �ƴմϴ�.
select employee_id, department_id, job_id, avg(salary) 
from employees
group by deparment_id, job_id;

/* having �� : group by ���� ������ �� �� ��� 
   ���ǿ� �´� �׷� ������ �� ��� 
*/

-- ���� �μ��� ����� ��ȸ�ϱ�
select department_id, count(*)
from employees
group by department_id;

-- null���� �ִ� �μ��� �����ϰ� �μ��� ����� ��ȸ�ϱ�
-- �����Լ��� null �����͸� �����ϰ� ��踦 ����.
select department_id, count(*)
--select department_id, count(department_id)
from employees
--where department_id is not null
group by department_id
order by department_id;

-- ������� 10�� �̻��� �μ��� ��ȸ�ϱ�
select department_id, count(*)
from employees
--where department_id is not null
--and count(*) >= 10 -- ���� �Լ��� where������ ��� �Ұ�
group by department_id
having count(*) >=10; -- �׷��� ������ ������ �� ����ϴ� ��(Clause)

/* ���� �Լ� ������ */
select first_name 
from employees
where avg(salary) >=3000;

select first_name 
from employees
where salary = max(salary); --ORA-00934: �׷� �Լ��� �㰡���� �ʽ��ϴ�

-------- ���������� �̿��� �ذ�
select first_name 
from employees
where (select avg(salary) from employees) >= 3000;

select first_name 
from employees
where salary = (select max(salary) from employees);

---------------------------------
-- where���� From���� ���ǵ� ���̺��� ���� �࿡ where���� ������ ���� ����ǰ�,
-- where���� ���ǿ� �´� ���� Group by ���� ����� �ȴ�.
-- �׷� ���� having���� ����

-- where���� havig���� ����
-- where���� ������� ���� �ڷῡ ���� ����
-- having���� ����� �ڷῡ ���� ����

-- �ٺ������� �����Լ��� select�������� ����Ѵ�.

select department_id, job_id, avg(salary)
from employees
group by department_id, job_id
having avg(salary) >= 3000
order by department_id, job_id;

select department_id, job_id, avg(salary)
from employees
where salary >=8000
group by department_id, job_id
having avg(salary) >= 3000
order by department_id, job_id;

/*
    select ���� �������
    1. from ��
    2. where ��
    3. group by ��
    4. having ��
    5. select ��
    6. order by ��
*/

-- ���� 1> �� �μ��� ��ձ޿�, �ִ�޿�, �ּұ޿�, ������� ����ϼ���.
--        ��ձ޿��� �Ҽ����� �����Ͻÿ�.
SELECT DEPARTMENT_ID,
       TRUNC(AVG(SALARY)) AS "��ձ޿�",
       MAX(SALARY) AS "�ִ�޿�",
       MIN(SALARY) AS "�ּұ޿�",
       COUNT(*) AS "�����"
  FROM EMPLOYEES
GROUP BY DEPARTMENT_ID; 

-- ���� 2> ���� ��å(job_id)�� �����ϴ� ����� 3�� �̻��� ��å�� �ο����� ����ϼ���.
SELECT JOB_ID,
       COUNT(*)
  FROM EMPLOYEES
GROUP BY JOB_ID
HAVING COUNT(*) >= 3; 

-- ���� 3> ������� �Ի翬���� �������� �μ����� ����� �Ի��ߴ��� ����ϼ���.
SELECT TO_CHAR(HIRE_DATE, 'YYYY') AS �Ի翬��,
       DEPARTMENT_ID �μ���ȣ,
       COUNT(*) AS �����
  FROM EMPLOYEES
GROUP BY TO_CHAR(HIRE_DATE, 'YYYY'), DEPARTMENT_ID
ORDER BY TO_CHAR(HIRE_DATE, 'YYYY'), DEPARTMENT_ID;

















