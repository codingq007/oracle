/* 현재 시스템의 날짜를 얻어 올 때 */
select sysdate from dual;


/* 형(type) 변환 함수
    to_char(): 날짜형, 숫자형을 문자형으로 변환 
    
    YYYY: 4자리 년도, MM:월, DD:일, HH24: 24시간, HH: 12시간, MI: 분, SS:초
*/
select to_char(sysdate, 'yyyy-mm-dd')from dual;
select to_char(sysdate, 'yyyy-mm-dd hh:mi:ss')from dual;

select to_char(sysdate, 'yyyy"년"mm"월"dd"일"') "date",
    to_char(sysdate, 'hh24"시"mi"분"ss"초"') "Time"
from dual;

-- 사원들의 입사일과 요일까지 출력
select first_name, to_char(hire_date, 'yyyy-mm-dd day') from employees;

-- 숫자 타입 변환
select first_name, salary, to_char(salary, '999,999') from employees;

-- 지역별 통화 표시 'L' 사용
select first_name, salary, to_char(salary, 'L999,999') from employees;

-- 자리수가 남을 때는 0으로 채우기
select to_char(12345, '00000000'), to_char(12345, '999,999,999') from dual;
select to_char(12345, '00,000,000') from dual;

/*to_date() : 날짜형으로 변환 

오라클의 기본 날짜형식은 'RR/MM/DD' -->21/10/05
*/
select to_date('20200814', 'yyyy-mm-dd') from dual;
select to_date('2020-08-14', 'yyyy-mm-dd') from dual;

select sysdate + 1 from dual; -- 내일 날짜
select sysdate - 1 from dual; -- 전일 날짜

select * from employees;

-- 특정 입사 날짜의 직원 조회
select first_name, hire_date
from employees
where hire_date = 20050921; -- 타입일치가 안되기 때문에 에러 발생

desc employees;

select first_name, hire_date
from employees
where hire_date = to_date(20050921); 

--뒷자리가 50년보다 크거나 같으면 1900년대로 인식합니다.
select to_date(601111, 'yy-mm-dd') from dual;
select to_date(601111, 'rr-mm-dd') from dual;

---------- 오라클의 환경변수 조회
select * from v$nls_parameters;
alter session set nls_date_format = 'YYYY-MM-DD';

-- months_between() : 두 날짜 사이의 개월 수를 구하는 함수
-- 소수점 표현은 달이 채워지지 않았다는 의미
select months_between(sysdate, '2021/01/01') from dual;

-- 사원들의 근무 개월 수를 파악
select * from employees;
select first_name, sysdate, hire_date, months_between(sysdate, hire_date) "근무 개월수" from employees; 
select first_name, sysdate, hire_date, trunc(months_between(sysdate, hire_date)) "근무 개월수" from employees; 

-- 50번 부서 사원들의 근무 개월 수를 파악(한달이 채워지지 않아도 개월 수 인정)
select first_name, sysdate, hire_date, ceil(months_between(sysdate, hire_date)) "근무 개월수" 
from employees
where department_id = 50;

-- last_day : 지정한 날짜의 해당 월 마지막 날짜
select last_day(sysdate) from dual;

-- 입사월의 마지막 날짜 구하기
select first_name, hire_date, last_day(hire_date) from employees;

-- add_months() : 특정 개월 수를 더한 날짜를 구하는 함수

select add_months(sysdate, 7) from dual; -- 7개월 더함.

select first_name, hire_date, add_months(hire_date, 10) from employees;

-- next_day() : 기준 날짜부터 시작해서 명시된 요일을 만나면, 해당되는 날짜를 반환하는 함수
-- next_day(기준날짜, 요일)
-- 1,2,3,4,5,6,7(일, 월, 화, 수, 목, 금, 토)
-- 현재시점에서 가장 가까운 일요일 날짜 구하기
select next_day(sysdate, '일요일') from dual;
select next_day(sysdate, 1) from dual;
select next_day(sysdate, 7) from dual;

-- 이전 일요일
select next_day(sysdate-8, '일요일') from dual;

-- to_number() : 숫자형으로 변환
select '2,000' - '1,000' from dual;
-- 산술연산 에러
select to_number('2,000') - to_number('1,000') from dual;
-- 산술 연산 가능
select to_number('2,000', '99,999') - to_number('1,000','99,999') from dual;

/* null 처리함수 */
-- nvl() : 널값이 다른 데이터로 변경하는 함수, 입력값이 null이면 지정된값으로 반환
--          null이 아니면 그대로 반환
select * from employees;
select first_name, salary, job_id, commission_pct
from employees
order by job_id;

select first_name, salary, job_id, nvl(commission_pct, 0)
from employees;

-- 인센티브를 포함한 연봉 계산
-- 연봉계산시에 commission_pct가 null이면 null 출력
select first_name, salary, commission_pct, salary*12 + commission_pct*(salary*12)
from employees;

-- commission_pct가 0으로 계산처리되면서 인센티브가 없어도 연봉 출력
select first_name, salary, commission_pct, salary*12 + nvl(commission_pct, 0)*(salary*12)
from employees;

/* if 조건문과 비슷한 CASE문
-- case : elseif문과 같은 역할 함수
-- case when 조건 then 조건이 참일 때 값 else 조건이 거짓일 때 값 end 컬럼명
*/
select DISTINCT department_id from employees;

select first_name, department_id,
    case when department_id = 20 then '마케팅부'
         when department_id = 50 then '전산실'
         when department_id = 100 then '전략기획실'
         else '아르바이트'
         end "부서명"
from employees;         

-- 문제 1> 조회 테이블 : employees
--        조회 내용 : first_name(5 ~ 6글자 사원만), 
--                   phone_number(앞 네자리 외 나머진 *로 출력)
SELECT first_name,
       phone_number,       
       RPAD(SUBSTR(phone_number, 1, 4), 12, '*') AS "전화번호마스킹"       
 FROM  employees
 WHERE LENGTH(first_name) >= 5
   AND LENGTH(first_name) < 7; 
   
-- 문제 2> 조회 테이블 : employees
--        조회 내용 : employee_id
--                   first_name, hire_date
--        정직원 일자(정직원 조건: 수습기간 3개월 후 첫 월요일이 정직원 되는날, 년도 4자리출력)
--        commission_pct(commission_pct가 없는 사원은 N/A로 출력, 주의: 'N/A'는 문자)
SELECT employee_id,first_name, hire_date,
       TO_CHAR(NEXT_DAY(ADD_MONTHS(HIRE_DATE, 3), '월요일'), 'YYYY-MM-DD') AS "정직원 일자",
--       nvl(commission_pct, 'N/A') "인센티브" -- 에러
       nvl(to_char(commission_pct), 'N/A') "인센티브"
FROM EMPloyees;

desc employees;

-- 문제 3-1> 조회 테이블 : employees
--        조회 내용 : employee_id, first_name, job_id, 부서명
--        부서명은 job_id 앞 두자리에 따라 다음과 같이 출력하세요. 이외에는 job_id 출력
--          IT --> 전산실
--          FI --> 경리부
--          SA --> 영업부
--          SH --> 판매부
--          HR --> 인사부

select * from employees;
SELECT employee_id,first_name, job_id,
       CASE
          WHEN SUBSTR(job_id, 1, 2) = 'IT' THEN '전산실'
          WHEN SUBSTR(job_id, 1, 2) = 'FI' THEN '경리부'
          WHEN SUBSTR(job_id, 1, 2) = 'SA' THEN '영업부'
          WHEN SUBSTR(job_id, 1, 2) = 'SH' THEN '판매부'
          WHEN SUBSTR(job_id, 1, 2) = 'HR' THEN '인사부'
          ELSE TO_CHAR(job_id)
       END AS 부서명
FROM EMPloyees;
-- 문제 3-2>조회 테이블 : employees
--         조회 내용 : employee_id, first_name, manager_id
--         manager_id에 따라 다음과 같이 출력하세요.. 그이외의 값은 manager_id로 출력
--         manager_id가 존재하지 않으면 BOSS로 출력
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
       END AS "매니저"
FROM EMPloyees;

         