/* 시퀀스 (sequence) : 연속적인 번호를 만들어 주는 기능
    mysql에서는 auto_increment를 사용한다.
    
    사용형식
    create sequence 시퀀스명
    increment by n : 증가값 설정
    start with n : 시작값 설정(default : 1)
    maxvalue n : 시퀀스 최대값
    minvalue n : 시퀀스 최소값
    cycle : 최대값을 지나면 최소값부터 다시 순환
    cache(nocache) : 메모리에 미리 저장 기본값 20
*/

create table dept_seq
as
select * from departments
where 1 <> 1;

select * from dept_seq;

create SEQUENCE seq_dept
increment by 10
start with 10
maxvalue 90
minvalue 0
nocycle;

insert into dept_seq values(seq_dept.nextval, 'database', 100, 2000);

select * from dept_seq;

alter sequence seq_dept
increment by 3
maxvalue 99
cycle;

-- 시퀀스명.nextval : 다음 시퀀스 번호를 가져옴.
--   시퀀스명.currval : 현재 시퀀스 번호를 가져옴.

-- 문제 > produc 테이블을 만든후 시퀀스를 적용하세요.
-- product 테이블의 컬럼(prod_no, prod_name), prod_no는 시퀀스를 적용하여 삽입
-- 상품명은 아무거나..
-- 시퀀스 1씩 증가 start with 100번, 최대 120, 최고 99, 순환

create table product(
    prod_no number(3),
    prod_name varchar2(20)
);
create SEQUENCE seq_product
    INCREMENT BY 1
    START WITH 100
    MAXVALUE 120
    MINVALUE 99
    CYCLE;
insert into product values(seq_product.currval, '상품1');    
insert into product values(seq_product.nextval, '상품1');

select * from product;

-- 시퀀스 삭제 drop sequence 시퀀스명
drop sequence seq_product;





