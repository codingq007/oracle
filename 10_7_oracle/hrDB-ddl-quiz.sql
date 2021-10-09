-- ���� 1> employees ���̺��� ������, ���� ��� �����ϼ���.. ���̺��: emp_ex
create table emp_ex
as
select * from employees;

desc emp_ex;

-- ���� 2> emp_ex ���̺� address���� �߰��ϼ���.(�ڷ��� ���ڿ�, ���̴� 50)
alter table emp_ex add address VARCHAR2(50);

select * from emp_ex;
desc emp_ex;
-- ���� 3> address ���� ũ�⸦ 30���� �����ϼ���.
alter table emp_ex modify address varchar2(30);
-- ���� 4> address�� remark�� �����ϼ���.
alter table emp_ex rename column address to remark;
-- ���� 5> emp_ex ���̺� �����ϼ���.
drop table emp_ex;