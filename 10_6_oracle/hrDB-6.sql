/*
    DML(Data Manipulation Language) : 데이터 조작어
    insert문, update문, delete문
    
    insert into 테이블명(컬럼1, 컬럼2, 컬럼3,...)
    values( 값1, 값2, 값3,...);
    -- 컬럼갯수와 값 갯수가 동일해야하고, 각 컬럼의 타입과 일치해야 한다.
    
    update 테이블명 set 컬럼1 = 값, 컬럼2 = 값, ...
    where 조건..;
    
    delete (from 생략 가능) 테이블명  where 조건;
*/

create table sample(
    deptNo number(20),
    deptName varchar2(15),
    deptLoc varchar2(15),
    deptManager varchar2(10)
);

insert into sample(deptNo, deptName, deptLoc, deptManager)
values(10, '기획실', '서울', '홍길동');

insert into sample values(20, '전산실', '부산', '김길동');

-- null 값 넣기
insert into sample values(30, '영업부', '광주', null);

update sample set deptNo = 50
where deptNo = 30;

select * from sample;

-- 20번 부서의 부서명을 마케팅으로 변경하세요.
update sample set deptName = '마케팅'
where deptNo = 20;

update sample set deptLoc = '대전'
where deptName = '영업부';

delete sample where deptName = '영업부';

-- 영업부 삽입하기 위치는 대전, 부서번호 30번, 매니저 고길동
insert into sample values(30, '영업부', '대전', '고길동');

commit; -- 대전을 삽입후에 커밋을 하면 이시점을 기억한다.

update sample set deptloc = '광주'
where deptName = '영업부';

select * from sample;

-- 테이블에 있는 모든 자료를 지움.
delete sample;

rollback; -- 광주로 영업부 위치를 바꾸고 rollback을 하면 커밋 시점으로 다시 돌아간다.




