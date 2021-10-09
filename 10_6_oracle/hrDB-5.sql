/*
    서브쿼리 : 쿼리문 안에 쿼리
*/

-- 평균 급여보다 적은 사원을 출력
select round(avg(salary)) from employees;

select employee_id, first_name, salary
from employees
where salary < 6462;

select employee_id, first_name, salary
from employees
where salary < round(avg(6462)); -- where절에서는 집계함수 사용불가

-- 서브쿼리 적용
select employee_id, first_name, salary
from employees
where salary < (select round(avg(salary)) from employees);

select * from locations;

/* 다중(여러개의 row)행 결과값으로 나올 경우 */
select location_id from locations
where state_province is null;

select * from departments;

-- state_province가 null인 location_id가 부서테이블에 있는지 확인
select * from departments
where location_id in (
    select location_id from locations
    where state_province is null
);

select * from locations;

select location_id from locations
where country_id = 'US';

-- country_id가 US인 location_id를 부서테이블에서 검색하세요.
select * from departments
where location_id in (
                        select location_id from locations
                        where country_id = 'US');
                        
-- 위의 코드는 다음과 같다.
select * from departments
where location_id in ( 1400, 1500, 1600, 1700 );

-- 문제 1> 월급이 가장 적은 사원의 이름과 직책명을 출력하세요..
    select emp.first_name, emp.last_name, job.JOB_TITLE
    from employees emp, jobs job
    where emp.salary = (select min(salary) from employees)
    and emp.job_id = job.job_id;
    
-- 문제 2> 평균 급여보다 많이 받는 사원들의 명단과 직책을 조회하세요.
    select emp.first_name, emp.last_name, emp.salary, job.job_title
    from employees emp, jobs job
    where emp.salary >( select avg(salary) from employees)
    and emp.job_id = job.job_id;

