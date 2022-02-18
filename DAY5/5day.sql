/*
[문제]
상품분류명, 상품명, 상품색상, 매입수량, 주문수량, 거래처명을 조회
단, 상품코드가 P101, P201, P301인 것들에 대해 조회
매입수량이 15개 이상
서울에 살고 있는 회원 중 생일이 1974년생인 사람들에 대해 조회
정렬은 회원아이디를 기준으로 내림차순, 매입수량을 기준으로 내림차순
*/
-- [일반방식]
Select prod_lgu 상품분류명,
        prod_name 상품명,
        prod_color 상품색상,
        buy_qty 매입수량,
        cart_qty 주문수량,
        buyer_name 거래처명
        -- ,mem_add1, mem_bir, mem_id
From prod, buyprod, cart, member, buyer
Where prod_lgu LIKE '%01'
        AND prod_id = buy_prod
        AND buy_qty >= '15'
            AND prod_id = cart_prod
                AND cart_member = mem_id
                AND mem_add1 LIKE '%서울%'
                AND TO_CHAR(mem_bir, 'YY') = '74'
                    AND prod_buyer = buyer_id
Order By mem_id DESC, buy_qty DESC;

-- [ANSI 국제표준방식]
-- ON() 에 연결해주는 관계식을 먼저 적고 일반조건을 적는 것이 좋다. 
Select prod_lgu 상품분류명,
        prod_name 상품명,
        prod_color 상품색상,
        buy_qty 매입수량,
        cart_qty 주문수량,
        buyer_name 거래처명
        , mem_add1, mem_bir, mem_id
From prod Inner join buyprod
                ON(prod_lgu LIKE '%01'
                    AND buy_qty >= '15'
                    AND prod_id = buy_prod)
                Inner join cart
                    ON(prod_id = cart_prod)
                Inner join member
                    ON(cart_member = mem_id
                         AND mem_add1 LIKE '%서울%'
                          AND TO_CHAR(mem_bir, 'YY') = '74')
                Inner join buyer
                    ON(prod_buyer = buyer_id)
Order By mem_id DESC, buy_qty DESC
;

-- OUTER JOIN
-- 같지 않은 것도 조회하고 싶을 때 사용
-- 국제표준방식을 사용해야 한다. 프로그램마다 일반방식이 다르다.
-- (+) = 조인에서 부족한 쪽에 (+) 연산자 기호를 사용한다.

-- 전체 분류의 상품자료 수를 검색 조회
-- 별칭 = 분류코드, 분류명, 상품자료수

-- 1. 분류테이블 조회
Select *
From lprod;

-- 2. 일반 join
Select lprod_gu 분류코드,
        lprod_nm 분류명,
        COUNT(prod_lgu) 상품자료수
From lprod, prod
Where lprod_gu = prod_lgu
Group by lprod_gu, lprod_nm;

-- 3. outer join 사용 확인
Select lprod_gu 분류코드,
        lprod_nm 분류명,
        COUNT(prod_lgu) 상품자료수
From lprod, prod
Where lprod_gu = prod_lgu (+)
Group by lprod_gu, lprod_nm
Order By lprod_gu;

-- 4. ANSI outer join 사용 확인
Select lprod_gu 분류코드,
        lprod_nm 분류명,
        COUNT(prod_lgu) 상품자료수
From lprod LEFT OUTER JOIN prod
                ON(lprod_gu = prod_lgu)
Group by lprod_gu, lprod_nm
Order By lprod_gu;

-- 전체상품의 2005년 1월 입고수량을 검색 조회
-- 별칭 = 상품코드, 상품명, 입고수량
--[일반 JOIN]
Select prod_id 상품코드,
        prod_name 상품명,
        SUM(buy_qty) 입고수량
From prod, buyprod
Where prod_id = buy_prod
    AND buy_date BETWEEN '2005-01-01' AND '2005-01-31'
Group By prod_id, prod_name;

-- [outer join]
-- 조건이 들어가면 일반방식으로 outer join을 사용하면 안된다.
Select prod_id 상품코드,
        prod_name 상품명,
        SUM(buy_qty) 입고수량
From prod, buyprod
Where prod_id = buy_prod (+)
    AND buy_date BETWEEN '2005-01-01' AND '2005-01-31' -- 이 조건을 만나면서 필터링되어 outer join의 의미가 사라짐. 고로 국제표준방식으로 쿼리를 구성해야함.
Group By prod_id, prod_name
Order By prod_id, prod_name;

-- [국제표준방식 outer join]
-- Where 절을 사용하지 않고 원하는 조건은 ON에 적음.
Select prod_id 상품코드,
        prod_name 상품명,
        SUM(buy_qty) 입고수량
From prod LEFT OUTER JOIN buyprod
                ON(prod_id = buy_prod
                    AND buy_date BETWEEN '2005-01-01' AND '2005-01-31')
Group By prod_id, prod_name
Order By prod_id, prod_name;

-- NULL 값 제거(처리)
-- NVL() 
Select prod_id 상품코드,
        prod_name 상품명,
        SUM(NVL(buy_qty, 0)) 입고수량
From prod LEFT OUTER JOIN buyprod
                ON(prod_id = buy_prod
                    AND buy_date BETWEEN '2005-01-01' AND '2005-01-31')
Group By prod_id, prod_name
Order By prod_id, prod_name;

-- 전체 회원의 2005년도 4월의 구매현황 조회
-- 회원ID, 성명, 구매수량의 합
Select mem_id 회원ID, 
        mem_name 성명,
        SUM(NVL(cart_qty,0)) 구매수량합
From member LEFT OUTER JOIN cart
                        ON(mem_id = cart_member
                            AND SUBSTR(cart_no, 1, 6) = '200504')
Group By mem_id, mem_name
Order By mem_id, mem_name;

-- 2005년도 월별 매입 현황을 검색
-- 별칭 = 매입월, 매입수량, 매입금액(매입수량*상품테이블의 매입가)
Select TO_CHAR(buy_date , 'mm' ) 매입월,
        SUM(buy_qty) 매입수량,
        TO_CHAR(SUM(buy_qty*prod_cost), 'L9,999,999,999,999') 매입금액
From buyprod, prod 
    Where buy_prod = prod_id
        AND EXTRACT(YEAR From buy_date) = 2005 
Group By TO_CHAR(buy_date , 'mm' )
Order By 매입월 ASC;

-- 2005년도 월별 판매 현황을 검색
-- 별칭 = 판매월, 판매수량, 판매금액(판매수량*상품테이블의 판매가)
Select SUBSTR(cart_no, 5, 2) 판매월,
        SUM(cart_qty) 판매수량,
        SUM(cart_qty * prod_sale) 판매금액        
From cart, prod
Where cart_prod = prod_id
    AND SUBSTR(cart_no, 1, 4) = '2005'
Group By SUBSTR(cart_no, 5, 2)
Order By SUBSTR(cart_no, 5, 2) ;

-- 서브쿼리
-- Select 문에 Select 문이 들어간다.
-- From 절에 Select 문을 넣으면 하나의 테이블을 넣는둔것 이라고 생각하면 됨.

-- 상품분류가 컴퓨터제품(P101)인 상품의 2005년도 일자별 판매 조회
-- 별칭 = 판매일, 판매금액(5,000,000초과의 경우만), 판매수량
-- HAVING을 이용하여 해당 조회
Select SUBSTR(cart_no, 5, 4) 판매일,
        SUM(prod_sale * cart_qty) 판매금액,
        SUM(cart_qty) 판매수량
From prod, cart
Where prod_id = cart_prod
    AND prod_lgu = 'P101'
    AND SUBSTR(cart_no, 1, 4) = '2005'
Group By SUBSTR(cart_no, 5, 4)
HAVING SUM(prod_sale * cart_qty) >= '5000000'
Order By SUBSTR(cart_no, 5, 4)
;

-- 서브쿼리
-- 고급쿼리
-- 응용을 해야함..
-- Select () = 하나의 컬럼에 하나의 값이 나오게 만들어줘야한다.
-- From () = n개의 컬럼에 n개의 값이 나오게 만들어줘야한다.
-- 비교연산자 = 하나의 컬럼에 하나의 값이 나오게 만들어줘야한다.
-- IN() = 하나의 컬럼에 n개의 값(열)
-- EXIST() = n개의 컬럼에 n개의 값이 나오게 만들어줘야한다.

-- ANL는 OR의 개념, 어떤 것이라도 맞으면 TRUE
-- ALL은 AND의 개념, 모두 만족해야만 TRUE
-- 단일컬럼의 다중행
-- 서브쿼리에서만 사용이 가능










