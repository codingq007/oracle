/*
    ���Ἲ ��������(constraints) - db�� ��� �ִ� �������� ��Ȯ��(�ϰ���)��
    �����ϵ��� �ϱ� ���� ���������� �ǹ���.
    
    ��, ����Ȯ�� �ڷᰡ db�� ����Ǵ� ���� �����ϵ��� �ϴ� ������ ���Ѵ�.
    ---------
    not null : �� ���� �Էµ��� ���ϰ� �ϴ� ����
    unique : �ߺ��� ���� �Էµ��� ���ϰ� �ϴ� ����(�ΰ��� ����� �� �ִ�.)
    primary key (�⺻Ű) : ���ϼ��� �����ϴ� Ű(not null + unique)
    foreign key(�ܷ�Ű) : �ٸ� ���̺��� �÷�(�ʵ�)�� �����ؼ� ���Ἲ�� �˻��ϴ� ����
    check : �־��� ���� ����ϴ� ����(��> ����: ��, �� ���� �������� ����)
    
    ���� ���Ἲ(integrity)�̶�?
    : �ܷ�Ű ���� ���� ���̺�(�����̼�)�� �⺻Ű ���� �����ؾ� �Ѵٴ� ����
      ��, ���̺��� ������ �� ���� �ܷ�Ű ���� ���� �� ����.
      ** ������ �� ���� �ܷ�Ű �� : ���� �ƴϸ鼭 ������ ���̺��� � �⺻Ű ����
        ��ġ���� �ʴ� ���� �ǹ�.
      
      ** �ܷ�Ű���� null���� �������� �ִ�.
      (���Ի��, �Ǵ� �Ƹ�����Ʈ���� �μ�ID�� ���� �� �ִ�.)
      
      �ڽ����̺�(������̺�) - �μ�ID�� �ܷ�Ű ����(�ܷ�Ű�� ���� ���̺�)
      �θ����̺�(�μ����̺�) - �μ�ID�� �⺻Ű ����      
*/
desc departments;

select * from employees
where department_id is null;

-- not null ��������
create table null_test(
    col_1 varchar2(20) not null,
    col_2 varchar2(20) null,
    col_3 varchar2(20)
);

insert into null_test(col_1, col_2) values('aa', 'bb');
select * from null_test;

-- �����߻�
insert into null_test(col_2, col_3) values('cc', 'dd');

drop table unique_test;

-- unique ��������
create table unique_test(
    col_1 varchar2(20) unique not null, -- �ζ��� ���
    col_2 varchar2(20) unique,
    col_3 varchar2(20) not null,
    col_4 varchar2(20) not null,
    -- constraint �������Ǹ� ��������
    constraint uc_unique UNIQUE (col_3, col_4) -- �ƿ����� ���
);

insert into unique_test values('aa', 'bb','cc', 'dd');
insert into unique_test values('a2', 'b2','c2', 'd2');

select * from unique_test;

-- ����
update unique_test set col_1 = 'aa'
where col_2 = 'b2';

insert into unique_test values('a3', '','c3', 'd3');
insert into unique_test values('a4', ' ','c4', 'd4');

-- unique ����
insert into unique_test values('a5', 'b5','c4', 'd4');

-- uc_unique ���������� ����
alter table unique_test
drop constraint uc_unique;

-- 3�� �÷�, 4�� �÷� �ߺ��� ���
insert into unique_test values('a5', 'b5','c4', 'd4');
select * from unique_test;

-- uc_unique ���������� �ٽ� �߰�
alter table unique_test
add constraint uc_unique unique (col_3, col_4);

select * from unique_test;
-- �ߺ��� ���� ����
delete from unique_test
where col_4 = 'd4';

-- ���߰�
insert into unique_test values('a4', '','c4','d4');
insert into unique_test values('a5', '','c4','d4');

insert into unique_test values('a5', '','c4','d5');

-- �������� �̸� ����
alter table unique_test
rename constraint uc_unique to uc_uique2;

-- P(primary), R(foreign), U(unique), C(check, not null..)

-- �������� Ȯ�ν� ������ ����(user_constraints) Ȱ��
select owner, constraint_type, constraint_name, table_name
from user_constraints
where table_name like 'UNIQUE%';

/* �⺻Ű(primary key) */
create table primary_test(
    student_id number(10) primary key,
    name varchar2(2)
);

desc primary_test;

select owner, constraint_type, constraint_name, table_name
from user_constraints
where table_name like 'PRIM%';

create table primary_test2(
    student_id number(10),
    name varchar2(20),
    constraint pk_stu primary key(student_id) -- �ƿ����� ���
);

create table primary_test3(
    student_id number(10) constraint pk_stu_id primary key,
    name varchar2(2)
);

select owner, constraint_type, constraint_name, table_name
from user_constraints
where table_name like 'PRIM%';

/* ���̺� �����Ŀ� �⺻Ű ���� */
alter table primary_test
--add constraint "�⺻Ű �̸�" primary key(�ʵ��);
add constraint pk_stu primary key(student_id);

/* �ܷ�Ű */
create table foreign_key(
    department_id constraint fk_dept
    REFERENCES departments (department_id) -- �ζ��� ���
);

select owner, constraint_type, constraint_name, table_name
from user_constraints
where table_name like 'FOR%';

drop table foreign_key;

create table foreign_key(
    department_id,
    constraint fk_dept foreign key (department_id) 
    REFERENCES departments (department_id) -- �ƿ����� ���
);

/* ���̺��� �����ϰ� ���� �ܷ�Ű�� �����ϴ� ��� */
alter table foreign_key
add constraint fk_dept foreign key (department_id) 
    REFERENCES departments (department_id);

/* check */
create table check_test(
    gender varchar2(10) not null,
        constraints check_gender check (gender in('M', 'F'))
);

insert into check_test values('Man');
select * from check_test;

create table check_test2(
    gender varchar2(10) not null,
        constraints check_gender2 check (gender in('��', '��'))
);

select * from check_test2;
insert into check_test2 values('��');

create table chk_table(
    login_id varchar2(20) constraint pk_loginID primary key,
    login_pwd varchar2(20) constraint ck_loginPWD check(length(login_pwd) > 5),
    tel varchar2(20)
);

insert into chk_table values('test', '123456', '1234555');

select * from chk_table;













