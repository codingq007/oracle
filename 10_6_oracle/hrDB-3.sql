/* 
    집합 연산 
    union : 각 쿼리의 결과 합을 반환하는 합집합(중복제거)
    union all : 각 쿼리의 모든 결과를 포함한 합집합(중복제거 안함)
    
    minus: 첫번째 결과값에서 두번째 결과값을 뺀 차집합 처리
    instersect : 첫번째 결과와 두번째 결과값이 같은 데이터만 출력하는 교집합 처리
*/

-- 주의점 : 열개수와 각열의 자료형이 순서별로 일치해야 한다.
select employee_id, first_name, salary, department_id
from employees
where department_id = 10
union
select employee_id, first_name, salary, department_id
from employees
where department_id = 20;

-- 열개수 불일치
select employee_id, first_name, salary, department_id
from employees
where department_id = 10
union
select employee_id, first_name, salary
from employees
where department_id = 20;

desc employees;
-- 열자료형의 불일치
select employee_id, first_name, salary, department_id
from employees
where department_id = 10
union
select employee_id, salary, first_name, department_id
from employees
where department_id = 20;

-- 열은 다르지만 열개수, 열자료형이 일치하면 출력됨.
select employee_id, first_name, salary, department_id
from employees
where department_id = 10
union
select department_id, email, employee_id, manager_id
from employees
where department_id = 20;

-- 중복제거
select employee_id, first_name, salary, department_id
from employees
where department_id = 10
union
select employee_id, first_name, salary, department_id
from employees
where department_id = 10;

-- 중복된 결과 출력
select employee_id, first_name, salary, department_id
from employees
where department_id = 10
union all
select employee_id, first_name, salary, department_id
from employees
where department_id = 10;

-- minus (차집합)
select employee_id, first_name, salary, department_id
from employees
minus
select employee_id, first_name, salary, department_id
from employees
where department_id = 50;

-- intersect
select employee_id, first_name, salary, department_id
from employees
intersect
select employee_id, first_name, salary, department_id
from employees
where department_id = 50;

/*
    조인(join): 두개 이상의 테이블을 연결하여 마치 하나의 테이블인 것처럼 조회하는 방식
    집합연산: 세로연결, 조인: 가로연결
    
    일반적은 조인하면 '내부조인(Equi join:등가조인)' 방식을 의미한다.
*/

select * from employees;
select * from departments;

/* 크로스 조인 = 교차조인 = 카테시안곱(Cartesian product) = 데카르트 곱 */
select *
from employees, departments
order by employee_id;

desc departments;

select count(*)
from employees, departments
order by employee_id;

/* ---- 내부조인 : EQUI JOIN ------*/
-- 두개의 테이블을 조인할 때 조인 조건을 넣어서 조인한다.
select emp.department_id, emp.first_name, dep.department_name
from employees emp, departments dep
where emp.department_id = dep.department_id;

-- John의 부서명을 출력하세요.
select emp.first_name, dep.department_name
from employees emp, departments dep
where emp.department_id = dep.department_id
and first_name = 'John';

-- Lex
select emp.first_name, dep.department_name
from employees emp, departments dep
where emp.department_id = dep.department_id
and first_name = 'Lex';

-- 세개의 테이블 조인
-- 직원의 이름, 이메일, 부서아이디, 부서명, 직급명을 조회하시오.
select * from departments;
select * from jobs;

select emp.first_name, emp.email, emp.department_id,
       dep.department_name, job.job_title
from employees emp, departments dep, jobs job
where emp.department_id = dep.department_id
and emp.job_id = job.job_id;

-- 네개의 테이블 조인(근무위치 파악)
-- 직원의 이름, 이메일, 부서아이디, 부서명, 직급명, 근무위치를 조회하세요.
select emp.first_name, emp.email, dep.department_id, dep.department_name,
    job.job_title, loc.city
from employees emp, departments dep, jobs job, locations loc
where emp.department_id = dep.department_id
and emp.job_id = job.job_id
and dep.location_id = loc.location_id;

-- Seattle에서 근무하는 직원들만 출력하세요.
select emp.first_name, emp.email, dep.department_id, dep.department_name,
    job.job_title, loc.city
from employees emp, departments dep, jobs job, locations loc
where emp.department_id = dep.department_id
and emp.job_id = job.job_id
and dep.location_id = loc.location_id
and loc.city = 'Seattle'; -- 일반 조건 포함.

/* 비등가조인 Non Equi join */
select * 
from employees e, sal_grade s
where e.salary between s.low_sal and s.high_sal;

select e.first_name, salary, grade 
from employees e, sal_grade s
where e.salary between s.low_sal and s.high_sal;

-- 문제 > 사원의 이름과 부서명, 급여 등급을 출력하세요.
select e.first_name, d.department_name, s.grade
from employees e, departments d, sal_grade s
where e.department_id = d.department_id
and e.salary between s.low_sal and s.high_sal;

/* 셀프 조인 : 자신의 테이블을 두개의 테이블 처럼 사용하는 것 */
select emp1.employee_id, emp1.first_name,
    emp2.employee_id "상사ID",
    emp2.first_name "상사이름"
from employees emp1, employees emp2
where emp1.manager_id = emp2.employee_id;

select * from employees;

/* 외부 조인(outer join)
    : 조인될 테이블의 데이터를 모두 출력하고자 할 때 사용한다.
    left outer join, right outer join
*/

-- 내부 조인을 했을 때 결과 106개
select emp.employee_id, emp.first_name, dep.department_name
from employees emp, departments dep
where emp.department_id = dep.department_id;

select * from employees;
select count(*) from employees;

select emp.employee_id, emp.first_name, dep.department_name
from employees emp, departments dep
-- 왼쪽을 기준으로 오른쪽이 늘어남 left outer join
--where emp.department_id = dep.department_id(+);
-- 오른쪽을 기준으로 왼쪽이 늘어남 right outer join
where emp.department_id(+) = dep.department_id;

-- full outer join
select emp.employee_id, emp.first_name, dep.department_name
from employees emp, departments dep
where emp.department_id = dep.department_id(+)
union
select emp.employee_id, emp.first_name, dep.department_name
from employees emp, departments dep
where emp.department_id(+) = dep.department_id;

select * from departments;
