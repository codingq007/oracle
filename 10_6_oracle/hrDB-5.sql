/*
    �������� : ������ �ȿ� ����
*/

-- ��� �޿����� ���� ����� ���
select round(avg(salary)) from employees;

select employee_id, first_name, salary
from employees
where salary < 6462;

select employee_id, first_name, salary
from employees
where salary < round(avg(6462)); -- where�������� �����Լ� ���Ұ�

-- �������� ����
select employee_id, first_name, salary
from employees
where salary < (select round(avg(salary)) from employees);

select * from locations;

/* ����(�������� row)�� ��������� ���� ��� */
select location_id from locations
where state_province is null;

select * from departments;

-- state_province�� null�� location_id�� �μ����̺� �ִ��� Ȯ��
select * from departments
where location_id in (
    select location_id from locations
    where state_province is null
);

select * from locations;

select location_id from locations
where country_id = 'US';

-- country_id�� US�� location_id�� �μ����̺��� �˻��ϼ���.
select * from departments
where location_id in (
                        select location_id from locations
                        where country_id = 'US');
                        
-- ���� �ڵ�� ������ ����.
select * from departments
where location_id in ( 1400, 1500, 1600, 1700 );

-- ���� 1> ������ ���� ���� ����� �̸��� ��å���� ����ϼ���..
    select emp.first_name, emp.last_name, job.JOB_TITLE
    from employees emp, jobs job
    where emp.salary = (select min(salary) from employees)
    and emp.job_id = job.job_id;
    
-- ���� 2> ��� �޿����� ���� �޴� ������� ��ܰ� ��å�� ��ȸ�ϼ���.
    select emp.first_name, emp.last_name, emp.salary, job.job_title
    from employees emp, jobs job
    where emp.salary >( select avg(salary) from employees)
    and emp.job_id = job.job_id;

