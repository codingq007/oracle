/* 
  서브쿼리 다중값 비교
  all, any를 이용하면 다중값을 단일 값 결과처럼 처리를 할 수 있음.
*/
-- all은 모든 다중값이 만족해야 참
select employee_id, department_id, salary
from employees 
where salary > all ( select salary from employees where department_id = 100);

-- any 연산자는 모든 다중값 중에서 하나만 만족하면 참.
select employee_id, department_id, salary
from employees 
where salary > any ( select salary from employees where department_id = 100);
