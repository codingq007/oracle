/*
    무결성 제약조건(constraints) - db에 들어 있는 데이터의 정확성(일관성)을
    보장하도록 하기 위한 제약조건을 의미함.
    
    즉, 부정확한 자료가 db에 저장되는 것을 방지하도록 하는 조건을 말한다.
    ---------
    not null : 널 값이 입력되지 못하게 하는 조건
    unique : 중복된 값이 입력되지 못하게 하는 조건(널값은 허용할 수 있다.)
    primary key (기본키) : 유일성을 보장하는 키(not null + unique)
    foreign key(외래키) : 다른 테이블의 컬럼(필드)을 참조해서 무결성을 검사하는 조건
    check : 주어진 값만 허용하는 조건(예> 성별: 남, 여 값만 들어오도록 제약)
    
    참조 무결성(integrity)이란?
    : 외래키 값은 참조 테이블(릴레이션)의 기본키 값과 동일해야 한다는 규정
      즉, 테이블은 참조할 수 없는 외래키 값을 가질 수 없다.
      ** 참조할 수 없는 외래키 값 : 널이 아니면서 참조된 테이블의 어떤 기본키 값도
        일치하지 않는 것을 의미.
      
      ** 외래키값은 null값을 가질수도 있다.
      (신입사원, 또는 아르바이트생은 부서ID가 없을 수 있다.)
      
      자식테이블(사원테이블) - 부서ID가 외래키 설정(외래키를 갖는 테이블)
      부모테이블(부서테이블) - 부서ID가 기본키 설정      
*/
desc departments;

select * from employees
where department_id is null;

-- not null 제약조건
create table null_test(
    col_1 varchar2(20) not null,
    col_2 varchar2(20) null,
    col_3 varchar2(20)
);

insert into null_test(col_1, col_2) values('aa', 'bb');
select * from null_test;

-- 오류발생
insert into null_test(col_2, col_3) values('cc', 'dd');

drop table unique_test;

-- unique 제약조건
create table unique_test(
    col_1 varchar2(20) unique not null, -- 인라인 방식
    col_2 varchar2(20) unique,
    col_3 varchar2(20) not null,
    col_4 varchar2(20) not null,
    -- constraint 제약조건명 제약조건
    constraint uc_unique UNIQUE (col_3, col_4) -- 아웃라인 방식
);

insert into unique_test values('aa', 'bb','cc', 'dd');
insert into unique_test values('a2', 'b2','c2', 'd2');

select * from unique_test;

-- 오류
update unique_test set col_1 = 'aa'
where col_2 = 'b2';

insert into unique_test values('a3', '','c3', 'd3');
insert into unique_test values('a4', ' ','c4', 'd4');

-- unique 위배
insert into unique_test values('a5', 'b5','c4', 'd4');

-- uc_unique 제약조건을 삭제
alter table unique_test
drop constraint uc_unique;

-- 3번 컬럼, 4번 컬럼 중복이 허용
insert into unique_test values('a5', 'b5','c4', 'd4');
select * from unique_test;

-- uc_unique 제약조건을 다시 추가
alter table unique_test
add constraint uc_unique unique (col_3, col_4);

select * from unique_test;
-- 중복된 행을 삭제
delete from unique_test
where col_4 = 'd4';

-- 행추가
insert into unique_test values('a4', '','c4','d4');
insert into unique_test values('a5', '','c4','d4');

insert into unique_test values('a5', '','c4','d5');

-- 제약조건 이름 수정
alter table unique_test
rename constraint uc_unique to uc_uique2;

-- P(primary), R(foreign), U(unique), C(check, not null..)

-- 제약조건 확인시 데이터 사전(user_constraints) 활용
select owner, constraint_type, constraint_name, table_name
from user_constraints
where table_name like 'UNIQUE%';

/* 기본키(primary key) */
create table primary_test(
    student_id number(10) primary key,
    name varchar2(2)
);

desc primary_test;

select owner, constraint_type, constraint_name, table_name
from user_constraints
where table_name like 'PRIM%';

create table primary_test2(
    student_id number(10),
    name varchar2(20),
    constraint pk_stu primary key(student_id) -- 아웃라인 방식
);

create table primary_test3(
    student_id number(10) constraint pk_stu_id primary key,
    name varchar2(2)
);

select owner, constraint_type, constraint_name, table_name
from user_constraints
where table_name like 'PRIM%';

/* 테이블 생성후에 기본키 지정 */
alter table primary_test
--add constraint "기본키 이름" primary key(필드명);
add constraint pk_stu primary key(student_id);

/* 외래키 */
create table foreign_key(
    department_id constraint fk_dept
    REFERENCES departments (department_id) -- 인라인 방식
);

select owner, constraint_type, constraint_name, table_name
from user_constraints
where table_name like 'FOR%';

drop table foreign_key;

create table foreign_key(
    department_id,
    constraint fk_dept foreign key (department_id) 
    REFERENCES departments (department_id) -- 아웃라인 방식
);

/* 테이블을 생성하고 나서 외래키를 지정하는 방법 */
alter table foreign_key
add constraint fk_dept foreign key (department_id) 
    REFERENCES departments (department_id);

/* check */
create table check_test(
    gender varchar2(10) not null,
        constraints check_gender check (gender in('M', 'F'))
);

insert into check_test values('Man');
select * from check_test;

create table check_test2(
    gender varchar2(10) not null,
        constraints check_gender2 check (gender in('남', '여'))
);

select * from check_test2;
insert into check_test2 values('여');

create table chk_table(
    login_id varchar2(20) constraint pk_loginID primary key,
    login_pwd varchar2(20) constraint ck_loginPWD check(length(login_pwd) > 5),
    tel varchar2(20)
);

insert into chk_table values('test', '123456', '1234555');

select * from chk_table;













