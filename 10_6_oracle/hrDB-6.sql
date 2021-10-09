/*
    DML(Data Manipulation Language) : ������ ���۾�
    insert��, update��, delete��
    
    insert into ���̺��(�÷�1, �÷�2, �÷�3,...)
    values( ��1, ��2, ��3,...);
    -- �÷������� �� ������ �����ؾ��ϰ�, �� �÷��� Ÿ�԰� ��ġ�ؾ� �Ѵ�.
    
    update ���̺�� set �÷�1 = ��, �÷�2 = ��, ...
    where ����..;
    
    delete (from ���� ����) ���̺��  where ����;
*/

create table sample(
    deptNo number(20),
    deptName varchar2(15),
    deptLoc varchar2(15),
    deptManager varchar2(10)
);

insert into sample(deptNo, deptName, deptLoc, deptManager)
values(10, '��ȹ��', '����', 'ȫ�浿');

insert into sample values(20, '�����', '�λ�', '��浿');

-- null �� �ֱ�
insert into sample values(30, '������', '����', null);

update sample set deptNo = 50
where deptNo = 30;

select * from sample;

-- 20�� �μ��� �μ����� ���������� �����ϼ���.
update sample set deptName = '������'
where deptNo = 20;

update sample set deptLoc = '����'
where deptName = '������';

delete sample where deptName = '������';

-- ������ �����ϱ� ��ġ�� ����, �μ���ȣ 30��, �Ŵ��� ��浿
insert into sample values(30, '������', '����', '��浿');

commit; -- ������ �����Ŀ� Ŀ���� �ϸ� �̽����� ����Ѵ�.

update sample set deptloc = '����'
where deptName = '������';

select * from sample;

-- ���̺� �ִ� ��� �ڷḦ ����.
delete sample;

rollback; -- ���ַ� ������ ��ġ�� �ٲٰ� rollback�� �ϸ� Ŀ�� �������� �ٽ� ���ư���.




