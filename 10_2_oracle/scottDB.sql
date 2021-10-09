select * from tabs; -- MySQL : show tables; 와 같은 명렁어


-- 데이터 사전 : 
-- 데이터를 설명해주는 데이터를 메타데이터(metadata)라고 한다.
-- 이러한 메타 데이터를 관리/유지할 수 있도록 모아 놓은 개념


-- 는 주석을 의미


desc emp;
describe emp;

-- [ SELECT ]
-- 기본 용어
-- 셀렉션(selection), 프로젝션(projection), 조인(join)
  -- 셀렉션 : 행단위 조회(특정한 행을 선별해서 조회하는 방식)
  -- 프로젝션 : 열단위 조회(특정한 열을 선별해서 조회하는 방식)
  -- 조인 : 두 개 이상의 테이블을 연결하여 마치 하나의 테이블인 것처럼 조회하는 방식
  
   -- 셀렉션 + 프로젝션 : 원하는 행의 특정 열만 조회 가능

-- * 모든 속성(항목)
select * from emp;

select empno, job, deptno from emp;

select * from emp where ename = 'JONES';

select empno, sal from emp where ename = 'JONES';

-- 부서 테이블의 구조를 확인
desc dept;
select * from dept;

-- 문제> scott의 사원번호와 급여를 조회하세요..
select empno, sal from emp where ename = 'SCOTT';

      --급여가 3000 이상인 직원의 모든 정보를 조회
select * from emp where sal >= 3000;


-- as(alias)는 별칭
select empno as "사번", ename as "사원명", sal as "월급" from emp where sal >= 3000; 
select empno "사번", ename "사원명", sal "월급" from emp where sal >= 3000; 

select * from emp;
select job from emp;
-- 중복 제거하기 distinct
select distinct job from emp;

-- 산술 연산, 비교, 논리, like 연산
---- 사원의 연봉을 출력
select empno, ename, sal*12 "연봉" from emp;

select empno, ename, sal*12+100 "연봉+인센티브" from emp;

---- 비교연산(>, <, >=, <=, !=(<>, ^=)
------- 급여가 4000이상인 직원의 이름과 급여를 조회
select empno, ename, sal "급여" from emp where sal>=4000;

------ 82년 이후 입사한 직원의 이름과 급여, 입사일을 조회하시오.
select ename "이름", sal, hiredate from emp where hiredate >= '82/01/01';

---- 논리 연산자(and, or, not)
select * from emp;
------ 부서번호가 30 이면서 직책이 clerk인 직원의 이름과 부서번호를 조회하하시오.
select ename "이름", deptno "부서번호" from emp where job = 'CLERK' and deptno = 30;

------ 부서번호가 10이면서 직책이 Manager인 직원의 이름과 직책, 부서번호를 조회하세요.
select ename "이름", deptno "부서번호",job "직책" from emp where job = 'MANAGER' and deptno = 10;

------ 부서 번호가 30이 아닌 직원의 이름과 부서 번호를 조회하세요.
select ename "이름", deptno "부서번호" from emp where deptno != 30;
select ename "이름", deptno "부서번호" from emp where not(deptno = 30);
select ename "이름", deptno "부서번호" from emp where deptno <> 30;

------ 급여가 1500 ~ 3000 사이의 직원의 이름과 급여를 조회하세요.
select ename "이름", sal "급여" from emp where 1500<=sal and sal<=3000;
select ename "이름", sal "급여" from emp where sal between 1500 and 3000;
------ 위 문제와 반대
select ename "이름", sal "급여" from emp where sal not between 1500 and 3000;

------ 급여가 3000, 5000, 1500인 직원의 이름과 급여를 조회하세요.
select ename "이름", sal "급여" from emp where sal=3000 or sal=5000 or sal=1500;
select ename "이름", sal "급여" from emp where sal in(3000, 5000, 1500);
------ 위 문제와 반대
select ename "이름", sal "급여" from emp where sal not in(3000, 5000, 1500);


-- like 연산자

---- 사원명이 S로 끝나는 사원을 조회
select * from emp;
select ename from emp where ename like '%S';

---- 사원명이 S로 시작하는 사원을 조회
select * from emp;
select ename from emp where ename like 'S%';

---- 사원명의 앞에서 4번째 글자가 T인 사원을 조회
select * from emp;
select ename from emp where ename like '___T%';











