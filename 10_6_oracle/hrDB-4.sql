/*
    DDL(Data Definition Language): Create��, Drop��, Alter��, Truncate��
    
    ** �ڵ����� commit�� �ȴ�.
*/

desc employees;

create table member(
    member_id number(10),
    name varchar2(20),
    age number(3)
);
desc member;

create table employees2(
    employee_id number(10),
    name varchar2(20),
    salary number(7, 2) -- 12345.12 �Ҽ��� 2�ڸ� �����ؼ� �� 7�ڸ�
);
desc employees2;
-- ORA-01438: �� ���� ���� ������ ��ü �ڸ������� ū ���� ���˴ϴ�.
insert into employees2(employee_id, name, salary)
values(1, 'ȫ�浿', 123456.78);

insert into employees2(employee_id, name, salary)
values(1, 'ȫ�浿', 12345.78);

insert into employees2(employee_id, name, salary)
values(1, 'ȫ�浿', 1234.78);

select * from employees2;

-- ���� ���̺��� �����ϰ� ���� ��(���̺� ����)
create table employees3 as select * from employees2;
select * from employees3;
select * from employees;

create table employees4
as
select * from employees
where 1 <> 1;

select * from employees4;

desc employees2;

-- alter : ����(����, ����, ������ ���)
alter table employees2 modify(
    name varchar2(10)
);

alter table employees2 add(
    manager_id varchar2(10)
);

desc employees2;
alter table employees2 drop column manager_id;

-- drop : ������ ���
drop table employees2; /* ���̺� ��ü�� ������ ���� */
select * from employees3;
truncate table employees3; -- row(���ڵ�)�� ������.

select * from employees2;

rename employees3 to employees2;







