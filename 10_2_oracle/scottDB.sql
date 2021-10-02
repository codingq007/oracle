select ename, sal, hiredate 
from emp
where hiredate >='82/01/01';

select ename, deptno from emp 
where deptno = 30 and job = 'CLERK';

select ename, deptno from emp
where deptno = 10 and job = 'MANAGER';

select ename, deptno from emp
where deptno != 30; 


