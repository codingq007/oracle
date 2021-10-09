/* ���� �ý����� ��¥�� ��� �� �� */
select sysdate from dual;


/* ��(type) ��ȯ �Լ�
    to_char(): ��¥��, �������� ���������� ��ȯ 
    
    YYYY: 4�ڸ� �⵵, MM:��, DD:��, HH24: 24�ð�, HH: 12�ð�, MI: ��, SS:��
*/
select to_char(sysdate, 'yyyy-mm-dd')from dual;
select to_char(sysdate, 'yyyy-mm-dd hh:mi:ss')from dual;

select to_char(sysdate, 'yyyy"��"mm"��"dd"��"') "date",
    to_char(sysdate, 'hh24"��"mi"��"ss"��"') "Time"
from dual;

-- ������� �Ի��ϰ� ���ϱ��� ���
select first_name, to_char(hire_date, 'yyyy-mm-dd day') from employees;

-- ���� Ÿ�� ��ȯ
select first_name, salary, to_char(salary, '999,999') from employees;

-- ������ ��ȭ ǥ�� 'L' ���
select first_name, salary, to_char(salary, 'L999,999') from employees;

-- �ڸ����� ���� ���� 0���� ä���
select to_char(12345, '00000000'), to_char(12345, '999,999,999') from dual;
select to_char(12345, '00,000,000') from dual;

/*to_date() : ��¥������ ��ȯ 

����Ŭ�� �⺻ ��¥������ 'RR/MM/DD' -->21/10/05
*/
select to_date('20200814', 'yyyy-mm-dd') from dual;
select to_date('2020-08-14', 'yyyy-mm-dd') from dual;

select sysdate + 1 from dual; -- ���� ��¥
select sysdate - 1 from dual; -- ���� ��¥

select * from employees;

-- Ư�� �Ի� ��¥�� ���� ��ȸ
select first_name, hire_date
from employees
where hire_date = 20050921; -- Ÿ����ġ�� �ȵǱ� ������ ���� �߻�

desc employees;

select first_name, hire_date
from employees
where hire_date = to_date(20050921); 

--���ڸ��� 50�⺸�� ũ�ų� ������ 1900���� �ν��մϴ�.
select to_date(601111, 'yy-mm-dd') from dual;
select to_date(601111, 'rr-mm-dd') from dual;

---------- ����Ŭ�� ȯ�溯�� ��ȸ
select * from v$nls_parameters;
alter session set nls_date_format = 'YYYY-MM-DD';

-- months_between() : �� ��¥ ������ ���� ���� ���ϴ� �Լ�
-- �Ҽ��� ǥ���� ���� ä������ �ʾҴٴ� �ǹ�
select months_between(sysdate, '2021/01/01') from dual;

-- ������� �ٹ� ���� ���� �ľ�
select * from employees;
select first_name, sysdate, hire_date, months_between(sysdate, hire_date) "�ٹ� ������" from employees; 
select first_name, sysdate, hire_date, trunc(months_between(sysdate, hire_date)) "�ٹ� ������" from employees; 

-- 50�� �μ� ������� �ٹ� ���� ���� �ľ�(�Ѵ��� ä������ �ʾƵ� ���� �� ����)
select first_name, sysdate, hire_date, ceil(months_between(sysdate, hire_date)) "�ٹ� ������" 
from employees
where department_id = 50;

-- last_day : ������ ��¥�� �ش� �� ������ ��¥
select last_day(sysdate) from dual;

-- �Ի���� ������ ��¥ ���ϱ�
select first_name, hire_date, last_day(hire_date) from employees;

-- add_months() : Ư�� ���� ���� ���� ��¥�� ���ϴ� �Լ�

select add_months(sysdate, 7) from dual; -- 7���� ����.

select first_name, hire_date, add_months(hire_date, 10) from employees;

-- next_day() : ���� ��¥���� �����ؼ� ��õ� ������ ������, �ش�Ǵ� ��¥�� ��ȯ�ϴ� �Լ�
-- next_day(���س�¥, ����)
-- 1,2,3,4,5,6,7(��, ��, ȭ, ��, ��, ��, ��)
-- ����������� ���� ����� �Ͽ��� ��¥ ���ϱ�
select next_day(sysdate, '�Ͽ���') from dual;
select next_day(sysdate, 1) from dual;
select next_day(sysdate, 7) from dual;

-- ���� �Ͽ���
select next_day(sysdate-8, '�Ͽ���') from dual;

-- to_number() : ���������� ��ȯ
select '2,000' - '1,000' from dual;
-- ������� ����
select to_number('2,000') - to_number('1,000') from dual;
-- ��� ���� ����
select to_number('2,000', '99,999') - to_number('1,000','99,999') from dual;

/* null ó���Լ� */
-- nvl() : �ΰ��� �ٸ� �����ͷ� �����ϴ� �Լ�, �Է°��� null�̸� �����Ȱ����� ��ȯ
--          null�� �ƴϸ� �״�� ��ȯ
select * from employees;
select first_name, salary, job_id, commission_pct
from employees
order by job_id;

select first_name, salary, job_id, nvl(commission_pct, 0)
from employees;

-- �μ�Ƽ�긦 ������ ���� ���
-- �������ÿ� commission_pct�� null�̸� null ���
select first_name, salary, commission_pct, salary*12 + commission_pct*(salary*12)
from employees;

-- commission_pct�� 0���� ���ó���Ǹ鼭 �μ�Ƽ�갡 ��� ���� ���
select first_name, salary, commission_pct, salary*12 + nvl(commission_pct, 0)*(salary*12)
from employees;

/* if ���ǹ��� ����� CASE��
-- case : elseif���� ���� ���� �Լ�
-- case when ���� then ������ ���� �� �� else ������ ������ �� �� end �÷���
*/
select DISTINCT department_id from employees;

select first_name, department_id,
    case when department_id = 20 then '�����ú�'
         when department_id = 50 then '�����'
         when department_id = 100 then '������ȹ��'
         else '�Ƹ�����Ʈ'
         end "�μ���"
from employees;         

-- ���� 1> ��ȸ ���̺� : employees
--        ��ȸ ���� : first_name(5 ~ 6���� �����), 
--                   phone_number(�� ���ڸ� �� ������ *�� ���)
SELECT first_name,
       phone_number,       
       RPAD(SUBSTR(phone_number, 1, 4), 12, '*') AS "��ȭ��ȣ����ŷ"       
 FROM  employees
 WHERE LENGTH(first_name) >= 5
   AND LENGTH(first_name) < 7; 
   
-- ���� 2> ��ȸ ���̺� : employees
--        ��ȸ ���� : employee_id
--                   first_name, hire_date
--        ������ ����(������ ����: �����Ⱓ 3���� �� ù �������� ������ �Ǵ³�, �⵵ 4�ڸ����)
--        commission_pct(commission_pct�� ���� ����� N/A�� ���, ����: 'N/A'�� ����)
SELECT employee_id,first_name, hire_date,
       TO_CHAR(NEXT_DAY(ADD_MONTHS(HIRE_DATE, 3), '������'), 'YYYY-MM-DD') AS "������ ����",
--       nvl(commission_pct, 'N/A') "�μ�Ƽ��" -- ����
       nvl(to_char(commission_pct), 'N/A') "�μ�Ƽ��"
FROM EMPloyees;

desc employees;

-- ���� 3-1> ��ȸ ���̺� : employees
--        ��ȸ ���� : employee_id, first_name, job_id, �μ���
--        �μ����� job_id �� ���ڸ��� ���� ������ ���� ����ϼ���. �̿ܿ��� job_id ���
--          IT --> �����
--          FI --> �渮��
--          SA --> ������
--          SH --> �Ǹź�
--          HR --> �λ��

select * from employees;
SELECT employee_id,first_name, job_id,
       CASE
          WHEN SUBSTR(job_id, 1, 2) = 'IT' THEN '�����'
          WHEN SUBSTR(job_id, 1, 2) = 'FI' THEN '�渮��'
          WHEN SUBSTR(job_id, 1, 2) = 'SA' THEN '������'
          WHEN SUBSTR(job_id, 1, 2) = 'SH' THEN '�Ǹź�'
          WHEN SUBSTR(job_id, 1, 2) = 'HR' THEN '�λ��'
          ELSE TO_CHAR(job_id)
       END AS �μ���
FROM EMPloyees;
-- ���� 3-2>��ȸ ���̺� : employees
--         ��ȸ ���� : employee_id, first_name, manager_id
--         manager_id�� ���� ������ ���� ����ϼ���.. ���̿��� ���� manager_id�� ���
--         manager_id�� �������� ������ BOSS�� ���
--          100 --> steven
--          101 --> neena
--          102 --> lex
--          103 --> alexander
SELECT employee_id,first_name, manager_id,
       CASE
          WHEN manager_id IS NULL THEN 'BOSS'
          WHEN manager_id = '100' then 'steven'
          WHEN manager_id = '101' then 'neena'
          WHEN manager_id = '102' then 'lex'
          WHEN manager_id = '103' then 'alexander'
          ELSE TO_CHAR(manager_id)
       END AS "�Ŵ���"
FROM EMPloyees;

         