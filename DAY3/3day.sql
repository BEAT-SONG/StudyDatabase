-- AVG() = 조회 범위 내 해당 컬럼들의 평균값
-- DISTINCT() = 중복된 값으 제외
-- 컬럼명 = NULL값은 제외
-- * = NULL값도 포함(COUNT 함수만 사용), 행의 유무를 확이
-- NULL과 연산을 하면 결과값이 NULL이 나옴

Select COUNT(prod_cost)
From prod;

Select COUNT(DISTINCT(prod_cost))
From prod;

/*
[문제]
구매내역(장바구니) 정보에서 회원아이디별로 주문(수량)에 대한 평균을 조회
회원아이디를 기준으로 내림차순
*/
Select cart_member 회원ID, ROUND(AVG(cart_qty) , 2)
From cart
Group By cart_member
Order By cart_member DESC
;

Select cart_member 회원ID, AVG(cart_qty) as avg_qty
From cart
Group By cart_member
Order By cart_member DESC
;

/*
[문제]
상품정보에서 판매가격의 평균값을 구해주세요.
평균값은 소수점 2째자리까지 표현해 주세요.
*/
Select ROUND(AVG(prod_sale), 2) as avg_sale
From prod;

Select prod_name 상품명, ROUND(AVG(prod_sale), 2) as avg_sale
From prod
Group By prod_name;

/*
[문제]
상품정보에서 상품분류별 판매가격의 평균값을 구하시오,
조회컬럼은 상품분류코드, 상품분류변 판매가격의 평균
평균값은 소수점 둘째자리까지 표현
*/
Select prod_lgu 상품분류코드, ROUND(AVG(prod_sale), 2) AS "상품분류별 판매가격"
From prod
Group By prod_lgu;

-- 회원테이블의 취미 종류수를 COUNT 집계하시오
Select COUNT(DISTINCT mem_like)
From member;

-- 회원테이블의 취미별 COUNT 집계하시오.
-- 별칭 = 취미, 자료수, 자료수(*)
Select mem_like 취미, COUNT(mem_like) 자료수, COUNT(*) "자료수(*)"
From member
Group By mem_like;

Select mem_like 취미, COUNT(mem_like) 자료수
From member
Group By mem_like;

-- 회원테이블의 직업종류수를 COUNT 하시오
-- 직업종류수
Select COUNT(DISTINCT(mem_job))
From member;

Select mem_job, COUNT(mem_job) as cnt_job
From member
Group By mem_job
Order By cnt_job DESC
;

/*
[문제]
회원 전체의 마일리지 평균보다 큰 회원에 대한 -- 일반조건
아이디, 이름, 마일리지를 조회
정렬은 마일리지가 높은 순으로
*/
Select mem_id 회원ID, mem_name 회원명, mem_mileage 마일리지
From member
Where mem_mileage >= (Select AVG(mem_mileage) From member) -- 괄호 안의 값이 하나가 되어야 한다.
Order By mem_mileage DESC;

Select mem_id 회원ID, mem_name 회원명, mem_mileage 마일리지
From member
Order By mem_mileage DESC;

-- MAX()
-- MIN()

-- 오늘이 2000년도 7월 11일이라고 가정하고 장바구니테이블에 발생할 추가주문번호를 검색하시오
-- 별칭 = 현재년월일 기준으로 가장 높은 주문번호, 추가주문번호)
-- 여러가지 방법이 존재한다! 단, 쿼리가 단순해야 속도도 빠르고 좋다!!!!
Select ('200507110000' || MAX((SUBSTR(cart_no,9)))) AS "현재년월일 기준으로 가장 높은 주문번호" , 
        ('200507110000' || MAX((SUBSTR(cart_no,9))) + 1) AS "추가주문번호"
From cart
Where SUBSTR(cart_no,1, 8) = 20050711
;

-- 귀영 언니꺼, 강사님
SELECT MAX(cart_no), MAX(cart_no)+1 
FROM cart
Where cart_no LIKE '20050711%';

Select *
From cart
;

/*
[문제]
구매정보에서 년도별로 판매된 상품의 개수, 평균구매수량을 조회
정렬은 년도를 기준으로 내림차순
*/
-- 데이터를 조회할때 1건이 나오든 하나도 안 나오든 논리적으로 쿼리를 구성하면 된다. (쫄지말기)
Select SUBSTR(cart_no, 1,4) 년도, SUM(cart_qty) 판매된상품개수, AVG(cart_qty) 평균구매수량
From cart
Group By SUBSTR(cart_no, 1,4)
Order By SUBSTR(cart_no, 1,4) DESC
;

-- 달별 기준
Select SUBSTR(cart_no, 1,6) 년도월, SUM(cart_qty) 판매된상품개수, ROUND(AVG(cart_qty), 2) AS 평균구매수량
From cart
Group By SUBSTR(cart_no, 1,6)
Order By SUBSTR(cart_no, 1,6) DESC
;

Select SUBSTR(cart_no, 1,6)
From cart;


