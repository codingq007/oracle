/*
    DDL(Data Definition Language): Create문, Drop문, Alter문, Truncate문
    
    ** 자동으로 commit이 된다.
*/

desc employees;

create table member(
    member_id number(10),
    name varchar2(20),
    age number(3)
);
desc member;

create table employees2(
    employee_id number(10),
    name varchar2(20),
    salary number(7, 2) -- 12345.12 소수점 2자리 포함해서 총 7자리
);
desc employees2;
-- ORA-01438: 이 열에 대해 지정된 전체 자릿수보다 큰 값이 허용됩니다.
insert into employees2(employee_id, name, salary)
values(1, '홍길동', 123456.78);

insert into employees2(employee_id, name, salary)
values(1, '홍길동', 12345.78);

insert into employees2(employee_id, name, salary)
values(1, '홍길동', 1234.78);

select * from employees2;

-- 같은 테이블을 동일하게 만들 때(테이블 복사)
create table employees3 as select * from employees2;
select * from employees3;
select * from employees;

create table employees4
as
select * from employees
where 1 <> 1;

select * from employees4;

desc employees2;

-- alter : 변경(수정, 삽입, 삭제시 사용)
alter table employees2 modify(
    name varchar2(10)
);

alter table employees2 add(
    manager_id varchar2(10)
);

desc employees2;
alter table employees2 drop column manager_id;

-- drop : 삭제시 사용
drop table employees2; /* 테이블 객체를 완전히 삭제 */
select * from employees3;
truncate table employees3; -- row(레코드)가 지워짐.

select * from employees2;

rename employees3 to employees2;







