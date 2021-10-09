select * from employees;

-- ���ʽ��� ���� ��� ��ȸ first_name, commission_pct(null�� �ƹ����� ���ٴ� �ǹ�)
select first_name, commission_pct 
from employees
where commission_pct is null;

-- ���ʽ��� �޴� ��� ��ȸ
select first_name, commission_pct 
from employees
where commission_pct is not null;


/*
    ���� ���� ����(ascending sort)    
*/
select * from employees;

select employee_id, first_name
from employees
order by employee_id asc; --asc ���� ����

select employee_id, first_name
from employees
order by employee_id desc;

-- �Լ�
---- �ֱ� ���Ի�� ��¥
select * from employees;

select max(hire_date) "�ֱ� ���Ի�� �Ի糯¥" from employees;

-- �ְ��� ����� �Ի糯¥
select min(hire_date) "�ְ��� �Ի� ��¥" from employees;

--select ���� �ݵ�� from ���� �־�� �Ѵ�.
select 10 + 20 "�������" from employees;

-- ����Ŭ���� �ӽ÷� �������ִ� ���̺� : dual --> ������ ���� ����� �� ���
select 10 + 20 "����" from dual;

-- abs()
select abs(-222) from dual;

-- round()
select round(0.1234), round(0.5555) from dual;

select round(0.1234, 2), round(0.5555, 3) from dual;

-- trunc(n1, n2)
select trunc(1234.1234567) from dual;

select trunc(1234.1234567, 3) from dual;

-- ceil(), floor()
select ceil(32.8) ceil from dual;
select ceil(32.3) ceil from dual;

select floor(32.8) floor from dual;
select floor(32.3) floor from dual;

-- ���� power()
select power(4,3) "power" from dual;
-- mod() ������
select mod(7,4) "mod" from dual;

-- sqrt() ������
select sqrt(2) sqrt from dual;

/* ���ڿ� �Լ� */
-- concat(str1, str2) ���ڿ� ��ġ��
select concat('Hello', ' Good') from dual;

select 'Hello' || ' Good' from dual;
-- initcap(str) ù���ڸ� �빮�ڷ�
select initcap('good morning') from dual;

-- lower(), upper(): �ҹ��ڷ�, �빮�ڷ� ��ȯ
select lower('GOOD'), upper('good') from dual;

-- padding(����)�� �ִ� �Լ� : LPAD(), RPAD()
select lpad('good', 6),lpad('good', 7, '#'),lpad('good', 8, '@') lpad from dual;

--�ѱ��� 2����Ʈ ���
select lpad('ȫ�浿', 8, '#') from dual;
-- rpad
select rpad('good', 6),rpad('good', 7, '#'),rpad('good', 8, '@') rpad from dual;

-- LTRIM(), RTRIM()
-- �߰��� ���ڴ� ���� �� ����. go�� ���� ��쿡�� o�� �ִ� ��ŭ ����
select ltrim('goodbye', 'g'), ltrim('goodbye', 'go'), ltrim('goodbye', 'o') from dual;

select rtrim('goodbye', 'e') from dual;

-- trim() : ��������
select '  good   ' from dual;
select length(trim('    good   ')) from dual;
select length(trim(both from'    good   ')) from dual;

-- ���� ���� ���ֱ�
select length('    good   ') from dual;
select length(trim(leading from '    good   ')) from dual;
-- ���� ���� ���ֱ�
select length(trim(trailing from '    good   ')) from dual;

-- substr() �߶�
-- 8��° ���ں��� 4���ڸ� �߶��
select substr('good morning john', 8, 4) from dual;
-- 8��° ���ں��� ������ �߶��.
select substr('good morning john', 8) from dual;
-- �ڿ��� ���� 4���� �߶��.
select substr('good morning john', -4) from dual;

select substr('good morning john', -4, 1) from dual;
select substr('good morning john', -4, 3) from dual;

-- replace(): ���ڿ� ��ü
select replace('good morning tom', 'morning', 'evening') from dual;

-- instr() ���ڿ��� ��ġ���� ã�� �Լ�
-- instr(���ڿ�, ã�����ϴ� ����, ������ġ, n��° ����)
select instr('good morning john', 'o', 1) from dual;
select instr('good morning john', 'o', 4) from dual;
select instr('good morning john', 'o', 8) from dual;

-- ó�� ��ġ�������� ����° ������ 'o'�� �ε��� ��
select instr('good morning john', 'o', 1, 3) from dual;
select instr('good morning john', 'o', 1, 4) from dual;

-- 8��° ��ġ���� �����ؼ� ó�� ������ n�� �ε��� ��
select instr('good morning john', 'n', 8) from dual;
-- 9��° ��ġ���� �����ؼ� �ι�° ������ n�� �ε��� ��
select instr('good morning john', 'n', 9, 2) from dual;


 











