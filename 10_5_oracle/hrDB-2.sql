/*
    집계함수 : sum(), count(), max(), min(), avg()
    여러 행의 값을 집계하여 하나의 행으로 결과 출력
*/

-- sum(): 합계 구하는 함수
-- 사원들의 총급여
select to_char(sum(salary), '999,999,999') from employees;

--ORA-00937: 단일 그룹의 그룹 함수가 아닙니다
select first_name, sum(salary) from employees;

-- all은 default값
select sum(salary), sum(distinct salary), sum(all salary) from employees;
select salary from employees;

-- count() : 데이터 개수 출력, *을 사용하면 select절의 결과값으로 나온 행의 수를 리턴
select count(*) from employees;
select count(salary) , count(distinct salary), count(all salary) from employees;

select * from employees;

-- 인센티브(commission)를 받는 사원수를 출력하세요.
select count(commission_pct)
from employees
where commission_pct is not null;

-- count함수는 null데이터를 카운트 하지 않는다.
select count(commission_pct)
from employees;

-- 인센티브 없는 사원수
select count(job_id)
from employees
where commission_pct is null;

-- max() , min() : 최대, 최소값
select max(salary), min(salary)
from employees
where department_id = 30;

/* group by 절 */
select department_id from employees;
select distinct department_id from employees;

select department_id from employees
group by department_id;

select department_id, sum(salary) 
from employees
group by department_id;

 -- 부서별 및 직책별 평균 급여를 출력하세요.
 select department_id, job_id, avg(salary)
 from employees
 group by department_id, job_id
 order by department_id, job_id; -- 부서별, 직책별 정렬

-- 부서별 사원수, 부서별 총급여, 부서별 평균급여 조회하세요
select department_id, count(salary), sum(salary), avg(salary)
from employees
group by department_id;

-- 부서별 직급별 사원수와 평균 급여 조회하세요.
 select department_id, job_id, count(salary), avg(salary)
 from employees
 group by department_id, job_id
 order by department_id, job_id; -- 부서별, 직책별 정렬

-- 80번 부서의 직급별 총급여와 평균 급여를 구하세요.
select department_id, job_id,
    to_char(sum(salary), '999,999') "총급여",
    to_char(avg(salary), '999,999') "평균급여"
from employees
where department_id = 80
group by department_id, job_id
order by department_id, job_id; -- 부서별, 직책별 정렬

-- group by 사용시 주의 사항
-- group by 절에 명시되지 않는 column을 select절에 사용했을 경우에는 
-- 오류 발생 : ORA-00979: GROUP BY 표현식이 아닙니다.
select employee_id, department_id, job_id, avg(salary) 
from employees
group by deparment_id, job_id;

/* having 절 : group by 절에 조건을 줄 때 사용 
   조건에 맞는 그룹 선택할 때 사용 
*/

-- 현재 부서별 사원수 조회하기
select department_id, count(*)
from employees
group by department_id;

-- null값이 있는 부서는 제외하고 부서별 사원수 조회하기
-- 집계함수는 null 데이터를 제외하고 통계를 낸다.
select department_id, count(*)
--select department_id, count(department_id)
from employees
--where department_id is not null
group by department_id
order by department_id;

-- 사원수가 10명 이상인 부서만 조회하기
select department_id, count(*)
from employees
--where department_id is not null
--and count(*) >= 10 -- 집계 함수는 where절에서 사용 불가
group by department_id
having count(*) >=10; -- 그룹의 조건을 적용할 때 사용하는 절(Clause)

/* 집계 함수 에러들 */
select first_name 
from employees
where avg(salary) >=3000;

select first_name 
from employees
where salary = max(salary); --ORA-00934: 그룹 함수는 허가되지 않습니다

-------- 서브쿼리를 이용한 해결
select first_name 
from employees
where (select avg(salary) from employees) >= 3000;

select first_name 
from employees
where salary = (select max(salary) from employees);

---------------------------------
-- where절은 From절에 정의된 테이블의 개별 행에 where절의 조건이 먼저 적용되고,
-- where절의 조건에 맞는 행이 Group by 절의 대상이 된다.
-- 그런 다음 having절이 적용

-- where절과 havig절의 차이
-- where절은 집계되지 않은 자료에 대한 조건
-- having절은 집계된 자료에 대한 조건

-- 근본적으로 집계함수는 select절에서만 사용한다.

select department_id, job_id, avg(salary)
from employees
group by department_id, job_id
having avg(salary) >= 3000
order by department_id, job_id;

select department_id, job_id, avg(salary)
from employees
where salary >=8000
group by department_id, job_id
having avg(salary) >= 3000
order by department_id, job_id;

/*
    select 절의 실행순서
    1. from 절
    2. where 절
    3. group by 절
    4. having 절
    5. select 절
    6. order by 절
*/

-- 문제 1> 각 부서별 평균급여, 최대급여, 최소급여, 사원수를 출력하세요.
--        평균급여는 소수점을 제외하시오.
SELECT DEPARTMENT_ID,
       TRUNC(AVG(SALARY)) AS "평균급여",
       MAX(SALARY) AS "최대급여",
       MIN(SALARY) AS "최소급여",
       COUNT(*) AS "사원수"
  FROM EMPLOYEES
GROUP BY DEPARTMENT_ID; 

-- 문제 2> 같은 직책(job_id)에 종사하는 사원이 3명 이상인 직책과 인원수를 출력하세요.
SELECT JOB_ID,
       COUNT(*)
  FROM EMPLOYEES
GROUP BY JOB_ID
HAVING COUNT(*) >= 3; 

-- 문제 3> 사원들의 입사연도를 기준으로 부서별로 몇명이 입사했는지 출력하세요.
SELECT TO_CHAR(HIRE_DATE, 'YYYY') AS 입사연도,
       DEPARTMENT_ID 부서번호,
       COUNT(*) AS 사원수
  FROM EMPLOYEES
GROUP BY TO_CHAR(HIRE_DATE, 'YYYY'), DEPARTMENT_ID
ORDER BY TO_CHAR(HIRE_DATE, 'YYYY'), DEPARTMENT_ID;

















