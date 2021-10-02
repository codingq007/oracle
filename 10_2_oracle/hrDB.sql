select * from employees;

-- 보너스가 없는 사원 조회 first_name, commission_pct(null은 아무값도 없다는 의미)
select first_name, commission_pct 
from employees
where commission_pct is null;

-- 보너스를 받는 사원 조회
select first_name, commission_pct 
from employees
where commission_pct is not null;


/*
    오름 차순 정렬(ascending sort)    
*/
select * from employees;

select employee_id, first_name
from employees
order by employee_id asc; --asc 생략 가능

select employee_id, first_name
from employees
order by employee_id desc;

-- 함수
---- 최근 신입사원 날짜
select * from employees;

select max(hire_date) "최근 신입사원 입사날짜" from employees;

-- 최고참 사원의 입사날짜
select min(hire_date) "최고참 입사 날짜" from employees;

--select 절은 반드시 from 절이 있어야 한다.
select 10 + 20 "덧셈결과" from employees;

-- 오라클에서 임시로 제공해주는 테이블 : dual --> 연산결과 등을 출력할 때 사용
select 10 + 20 "덧셈" from dual;

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

-- 제곱 power()
select power(4,3) "power" from dual;
-- mod() 나머지
select mod(7,4) "mod" from dual;

-- sqrt() 제곱근
select sqrt(2) sqrt from dual;

/* 문자열 함수 */
-- concat(str1, str2) 문자열 합치기
select concat('Hello', ' Good') from dual;

select 'Hello' || ' Good' from dual;
-- initcap(str) 첫글자를 대문자로
select initcap('good morning') from dual;

-- lower(), upper(): 소문자로, 대문자로 변환
select lower('GOOD'), upper('good') from dual;

-- padding(여백)을 주는 함수 : LPAD(), RPAD()
select lpad('good', 6),lpad('good', 7, '#'),lpad('good', 8, '@') lpad from dual;

--한글은 2바이트 계산
select lpad('홍길동', 8, '#') from dual;
-- rpad
select rpad('good', 6),rpad('good', 7, '#'),rpad('good', 8, '@') rpad from dual;

-- LTRIM(), RTRIM()
-- 중간의 문자는 지울 수 없음. go를 지울 경우에는 o가 있는 만큼 지움
select ltrim('goodbye', 'g'), ltrim('goodbye', 'go'), ltrim('goodbye', 'o') from dual;

select rtrim('goodbye', 'e') from dual;

-- trim() : 공백제거
select '  good   ' from dual;
select length(trim('    good   ')) from dual;
select length(trim(both from'    good   ')) from dual;

-- 좌측 공백 없애기
select length('    good   ') from dual;
select length(trim(leading from '    good   ')) from dual;
-- 우측 공백 없애기
select length(trim(trailing from '    good   ')) from dual;

-- substr() 잘라냄
-- 8번째 문자부터 4글자를 잘라옴
select substr('good morning john', 8, 4) from dual;
-- 8번째 문자부터 끝까지 잘라옴.
select substr('good morning john', 8) from dual;
-- 뒤에서 부터 4글자 잘라옴.
select substr('good morning john', -4) from dual;

select substr('good morning john', -4, 1) from dual;
select substr('good morning john', -4, 3) from dual;

-- replace(): 문자열 교체
select replace('good morning tom', 'morning', 'evening') from dual;

-- instr() 문자열의 위치값을 찾는 함수
-- instr(문자열, 찾고자하는 문자, 시작위치, n번째 문자)
select instr('good morning john', 'o', 1) from dual;
select instr('good morning john', 'o', 4) from dual;
select instr('good morning john', 'o', 8) from dual;

-- 처음 위치에서부터 세번째 나오는 'o'의 인덱스 값
select instr('good morning john', 'o', 1, 3) from dual;
select instr('good morning john', 'o', 1, 4) from dual;

-- 8번째 위치에서 시작해서 처음 나오는 n의 인덱스 값
select instr('good morning john', 'n', 8) from dual;
-- 9번째 위치에서 시작해서 두번째 나오는 n의 인덱스 값
select instr('good morning john', 'n', 9, 2) from dual;


 











