/* 
    ���� ���� 
    union : �� ������ ��� ���� ��ȯ�ϴ� ������(�ߺ�����)
    union all : �� ������ ��� ����� ������ ������(�ߺ����� ����)
    
    minus: ù��° ��������� �ι�° ������� �� ������ ó��
    instersect : ù��° ����� �ι�° ������� ���� �����͸� ����ϴ� ������ ó��
*/

-- ������ : �������� ������ �ڷ����� �������� ��ġ�ؾ� �Ѵ�.
select employee_id, first_name, salary, department_id
from employees
where department_id = 10
union
select employee_id, first_name, salary, department_id
from employees
where department_id = 20;

-- ������ ����ġ
select employee_id, first_name, salary, department_id
from employees
where department_id = 10
union
select employee_id, first_name, salary
from employees
where department_id = 20;

desc employees;
-- ���ڷ����� ����ġ
select employee_id, first_name, salary, department_id
from employees
where department_id = 10
union
select employee_id, salary, first_name, department_id
from employees
where department_id = 20;

-- ���� �ٸ����� ������, ���ڷ����� ��ġ�ϸ� ��µ�.
select employee_id, first_name, salary, department_id
from employees
where department_id = 10
union
select department_id, email, employee_id, manager_id
from employees
where department_id = 20;

-- �ߺ�����
select employee_id, first_name, salary, department_id
from employees
where department_id = 10
union
select employee_id, first_name, salary, department_id
from employees
where department_id = 10;

-- �ߺ��� ��� ���
select employee_id, first_name, salary, department_id
from employees
where department_id = 10
union all
select employee_id, first_name, salary, department_id
from employees
where department_id = 10;

-- minus (������)
select employee_id, first_name, salary, department_id
from employees
minus
select employee_id, first_name, salary, department_id
from employees
where department_id = 50;

-- intersect
select employee_id, first_name, salary, department_id
from employees
intersect
select employee_id, first_name, salary, department_id
from employees
where department_id = 50;

/*
    ����(join): �ΰ� �̻��� ���̺��� �����Ͽ� ��ġ �ϳ��� ���̺��� ��ó�� ��ȸ�ϴ� ���
    ���տ���: ���ο���, ����: ���ο���
    
    �Ϲ����� �����ϸ� '��������(Equi join:�����)' ����� �ǹ��Ѵ�.
*/

select * from employees;
select * from departments;

/* ũ�ν� ���� = �������� = ī�׽þȰ�(Cartesian product) = ��ī��Ʈ �� */
select *
from employees, departments
order by employee_id;

desc departments;

select count(*)
from employees, departments
order by employee_id;

/* ---- �������� : EQUI JOIN ------*/
-- �ΰ��� ���̺��� ������ �� ���� ������ �־ �����Ѵ�.
select emp.department_id, emp.first_name, dep.department_name
from employees emp, departments dep
where emp.department_id = dep.department_id;

-- SQL 99
--select department_id, emp.first_name, dep.department_name
--from employees emp natural join departments dep;

select department_id, emp.first_name, dep.department_name
from employees emp join departments dep using(department_id);

select emp.department_id, emp.first_name, dep.department_name
from employees emp join departments dep on(emp.department_id = dep.department_id);


-- John�� �μ����� ����ϼ���.
select emp.first_name, dep.department_name
from employees emp, departments dep
where emp.department_id = dep.department_id
and first_name = 'John';

-- Lex
select emp.first_name, dep.department_name
from employees emp, departments dep
where emp.department_id = dep.department_id
and first_name = 'Lex';

-- ������ ���̺� ����
-- ������ �̸�, �̸���, �μ����̵�, �μ���, ���޸��� ��ȸ�Ͻÿ�.
select * from departments;
select * from jobs;

select emp.first_name, emp.email, emp.department_id,
       dep.department_name, job.job_title
from employees emp, departments dep, jobs job
where emp.department_id = dep.department_id
and emp.job_id = job.job_id;

-- �װ��� ���̺� ����(�ٹ���ġ �ľ�)
-- ������ �̸�, �̸���, �μ����̵�, �μ���, ���޸�, �ٹ���ġ�� ��ȸ�ϼ���.
select emp.first_name, emp.email, dep.department_id, dep.department_name,
    job.job_title, loc.city
from employees emp, departments dep, jobs job, locations loc
where emp.department_id = dep.department_id
and emp.job_id = job.job_id
and dep.location_id = loc.location_id;

-- Seattle���� �ٹ��ϴ� �����鸸 ����ϼ���.
select emp.first_name, emp.email, dep.department_id, dep.department_name,
    job.job_title, loc.city
from employees emp, departments dep, jobs job, locations loc
where emp.department_id = dep.department_id
and emp.job_id = job.job_id
and dep.location_id = loc.location_id
and loc.city = 'Seattle'; -- �Ϲ� ���� ����.

/* ������ Non Equi join */
select * 
from employees e, sal_grade s
where e.salary between s.low_sal and s.high_sal;

select e.first_name, salary, grade 
from employees e, sal_grade s
where e.salary between s.low_sal and s.high_sal;



-- ���� > ����� �̸��� �μ���, �޿� ����� ����ϼ���.
select e.first_name, d.department_name, s.grade
from employees e, departments d, sal_grade s
where e.department_id = d.department_id
and e.salary between s.low_sal and s.high_sal;

/* ���� ���� : �ڽ��� ���̺��� �ΰ��� ���̺� ó�� ����ϴ� �� */
select emp1.employee_id, emp1.first_name,
    emp2.employee_id "���ID",
    emp2.first_name "����̸�"
from employees emp1, employees emp2
where emp1.manager_id = emp2.employee_id;

select * from employees;

/* �ܺ� ����(outer join)
    : ���ε� ���̺��� �����͸� ��� ����ϰ��� �� �� ����Ѵ�.
    left outer join, right outer join
*/

-- ���� ������ ���� �� ��� 106��
select emp.employee_id, emp.first_name, dep.department_name
from employees emp, departments dep
where emp.department_id = dep.department_id;

select * from employees;
select count(*) from employees;
-- left outer join
select emp.employee_id, emp.first_name, dep.department_name
from employees emp, departments dep
-- ������ �������� �������� �þ left outer join
where emp.department_id = dep.department_id(+);

-- SQL 99 ǥ���
select emp.employee_id, emp.first_name, dep.department_name
from employees emp left outer join departments dep
on(emp.department_id = dep.department_id);

-- right outer join
select emp.employee_id, emp.first_name, dep.department_name
from employees emp, departments dep
-- �������� �������� ������ �þ right outer join
where emp.department_id(+) = dep.department_id;

-- SQL 99 ǥ���
select emp.employee_id, emp.first_name, dep.department_name
from employees emp right outer join departments dep
on(emp.department_id = dep.department_id);

-- full outer join
select emp.employee_id, emp.first_name, dep.department_name
from employees emp, departments dep
where emp.department_id = dep.department_id(+)
union
select emp.employee_id, emp.first_name, dep.department_name
from employees emp, departments dep
where emp.department_id(+) = dep.department_id;

-- SQL 99 ǥ���
select emp.employee_id, emp.first_name, dep.department_name
from employees emp full outer join departments dep
on(emp.department_id = dep.department_id);

select * from departments;

-- ���� 1> ��� ����� ���ID�� firstName, �μ���, �ٹ� ���ø� ����ϼ���.


-- ���� 2> ��� ����� ���ID�� firstName, ���ID�� ����̸��� ����ϼ���.

-- ���� 3> �޿��� 2000 �̻��� ������� �μ���ȣ, �μ���, �����ȣ, �����, �޿��� ���
-- �ϼ���.

-- ���� 4> ��� �μ���ȣ, �μ���, �����ȣ, �����, �޿�, �޿����, ���� �����ȣ, ���ӻ����,
-- �μ���ȣ, �����ȣ ������ ����ϼ���.

