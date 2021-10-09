select * from tabs; -- MySQL : show tables; �� ���� ����


-- ������ ���� : 
-- �����͸� �������ִ� �����͸� ��Ÿ������(metadata)��� �Ѵ�.
-- �̷��� ��Ÿ �����͸� ����/������ �� �ֵ��� ��� ���� ����


-- �� �ּ��� �ǹ�


desc emp;
describe emp;

-- [ SELECT ]
-- �⺻ ���
-- ������(selection), ��������(projection), ����(join)
  -- ������ : ����� ��ȸ(Ư���� ���� �����ؼ� ��ȸ�ϴ� ���)
  -- �������� : ������ ��ȸ(Ư���� ���� �����ؼ� ��ȸ�ϴ� ���)
  -- ���� : �� �� �̻��� ���̺��� �����Ͽ� ��ġ �ϳ��� ���̺��� ��ó�� ��ȸ�ϴ� ���
  
   -- ������ + �������� : ���ϴ� ���� Ư�� ���� ��ȸ ����

-- * ��� �Ӽ�(�׸�)
select * from emp;

select empno, job, deptno from emp;

select * from emp where ename = 'JONES';

select empno, sal from emp where ename = 'JONES';

-- �μ� ���̺��� ������ Ȯ��
desc dept;
select * from dept;

-- ����> scott�� �����ȣ�� �޿��� ��ȸ�ϼ���..
select empno, sal from emp where ename = 'SCOTT';

      --�޿��� 3000 �̻��� ������ ��� ������ ��ȸ
select * from emp where sal >= 3000;


-- as(alias)�� ��Ī
select empno as "���", ename as "�����", sal as "����" from emp where sal >= 3000; 
select empno "���", ename "�����", sal "����" from emp where sal >= 3000; 

select * from emp;
select job from emp;
-- �ߺ� �����ϱ� distinct
select distinct job from emp;

-- ��� ����, ��, ��, like ����
---- ����� ������ ���
select empno, ename, sal*12 "����" from emp;

select empno, ename, sal*12+100 "����+�μ�Ƽ��" from emp;

---- �񱳿���(>, <, >=, <=, !=(<>, ^=)
------- �޿��� 4000�̻��� ������ �̸��� �޿��� ��ȸ
select empno, ename, sal "�޿�" from emp where sal>=4000;

------ 82�� ���� �Ի��� ������ �̸��� �޿�, �Ի����� ��ȸ�Ͻÿ�.
select ename "�̸�", sal, hiredate from emp where hiredate >= '82/01/01';

---- �� ������(and, or, not)
select * from emp;
------ �μ���ȣ�� 30 �̸鼭 ��å�� clerk�� ������ �̸��� �μ���ȣ�� ��ȸ���Ͻÿ�.
select ename "�̸�", deptno "�μ���ȣ" from emp where job = 'CLERK' and deptno = 30;

------ �μ���ȣ�� 10�̸鼭 ��å�� Manager�� ������ �̸��� ��å, �μ���ȣ�� ��ȸ�ϼ���.
select ename "�̸�", deptno "�μ���ȣ",job "��å" from emp where job = 'MANAGER' and deptno = 10;

------ �μ� ��ȣ�� 30�� �ƴ� ������ �̸��� �μ� ��ȣ�� ��ȸ�ϼ���.
select ename "�̸�", deptno "�μ���ȣ" from emp where deptno != 30;
select ename "�̸�", deptno "�μ���ȣ" from emp where not(deptno = 30);
select ename "�̸�", deptno "�μ���ȣ" from emp where deptno <> 30;

------ �޿��� 1500 ~ 3000 ������ ������ �̸��� �޿��� ��ȸ�ϼ���.
select ename "�̸�", sal "�޿�" from emp where 1500<=sal and sal<=3000;
select ename "�̸�", sal "�޿�" from emp where sal between 1500 and 3000;
------ �� ������ �ݴ�
select ename "�̸�", sal "�޿�" from emp where sal not between 1500 and 3000;

------ �޿��� 3000, 5000, 1500�� ������ �̸��� �޿��� ��ȸ�ϼ���.
select ename "�̸�", sal "�޿�" from emp where sal=3000 or sal=5000 or sal=1500;
select ename "�̸�", sal "�޿�" from emp where sal in(3000, 5000, 1500);
------ �� ������ �ݴ�
select ename "�̸�", sal "�޿�" from emp where sal not in(3000, 5000, 1500);


-- like ������

---- ������� S�� ������ ����� ��ȸ
select * from emp;
select ename from emp where ename like '%S';

---- ������� S�� �����ϴ� ����� ��ȸ
select * from emp;
select ename from emp where ename like 'S%';

---- ������� �տ��� 4��° ���ڰ� T�� ����� ��ȸ
select * from emp;
select ename from emp where ename like '___T%';











