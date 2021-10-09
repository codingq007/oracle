/* ������ (sequence) : �������� ��ȣ�� ����� �ִ� ���
    mysql������ auto_increment�� ����Ѵ�.
    
    �������
    create sequence ��������
    increment by n : ������ ����
    start with n : ���۰� ����(default : 1)
    maxvalue n : ������ �ִ밪
    minvalue n : ������ �ּҰ�
    cycle : �ִ밪�� ������ �ּҰ����� �ٽ� ��ȯ
    cache(nocache) : �޸𸮿� �̸� ���� �⺻�� 20
*/

create table dept_seq
as
select * from departments
where 1 <> 1;

select * from dept_seq;

create SEQUENCE seq_dept
increment by 10
start with 10
maxvalue 90
minvalue 0
nocycle;

insert into dept_seq values(seq_dept.nextval, 'database', 100, 2000);

select * from dept_seq;

alter sequence seq_dept
increment by 3
maxvalue 99
cycle;

-- ��������.nextval : ���� ������ ��ȣ�� ������.
--   ��������.currval : ���� ������ ��ȣ�� ������.

-- ���� > produc ���̺��� ������ �������� �����ϼ���.
-- product ���̺��� �÷�(prod_no, prod_name), prod_no�� �������� �����Ͽ� ����
-- ��ǰ���� �ƹ��ų�..
-- ������ 1�� ���� start with 100��, �ִ� 120, �ְ� 99, ��ȯ

create table product(
    prod_no number(3),
    prod_name varchar2(20)
);
create SEQUENCE seq_product
    INCREMENT BY 1
    START WITH 100
    MAXVALUE 120
    MINVALUE 99
    CYCLE;
insert into product values(seq_product.currval, '��ǰ1');    
insert into product values(seq_product.nextval, '��ǰ1');

select * from product;

-- ������ ���� drop sequence ��������
drop sequence seq_product;





