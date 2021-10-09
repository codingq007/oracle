/* 
  �������� ���߰� ��
  all, any�� �̿��ϸ� ���߰��� ���� �� ���ó�� ó���� �� �� ����.
*/
-- all�� ��� ���߰��� �����ؾ� ��
select employee_id, department_id, salary
from employees 
where salary > all ( select salary from employees where department_id = 100);

-- any �����ڴ� ��� ���߰� �߿��� �ϳ��� �����ϸ� ��.
select employee_id, department_id, salary
from employees 
where salary > any ( select salary from employees where department_id = 100);
