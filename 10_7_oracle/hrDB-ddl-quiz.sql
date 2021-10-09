-- 문제 1> employees 테이블의 각열과, 행을 모두 복사하세요.. 테이블명: emp_ex
create table emp_ex
as
select * from employees;

desc emp_ex;

-- 문제 2> emp_ex 테이블에 address열을 추가하세요.(자료형 문자열, 길이는 50)
alter table emp_ex add address VARCHAR2(50);

select * from emp_ex;
desc emp_ex;
-- 문제 3> address 열의 크기를 30으로 변경하세요.
alter table emp_ex modify address varchar2(30);
-- 문제 4> address를 remark로 변경하세요.
alter table emp_ex rename column address to remark;
-- 문제 5> emp_ex 테이블 삭제하세요.
drop table emp_ex;