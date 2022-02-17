/*
[문제]
회원정보 중에 구매내역이 있는 회원에 대한 
회원아이디, 회원이름, 생일(0000-00-00 형태)를 조회해 주세요
정렬은 생일을 기준으로 오름차순
*/
Select mem_id 회원ID, mem_name 회원이름, TO_CHAR(mem_bir, 'YYYY-MM-DD') 생일
From member
Where mem_id 
    IN(Select cart_member From cart) 
Order By mem_bir ASC;

-- TO_CHAR() = 숫자, 문자, 날짜를 지정한 형식의 문자열 변환
-- 서브쿼리
-- EXISTS() = IN()이 맞는지 않맞는지 확인 = 행이 있으면 TRUE 없으면 FALSE
-- 속도는 아래 쿼리가 빠르다.
-- IN은 2번 / EXISTS는 1번 돌림.
Select prod_id, prod_name, prod_lgu
From prod
Where prod_lgu
    IN(Select lprod_gu From lprod
        Where lprod_nm ='피혁잡화')
;

Select prod_id, prod_name, prod_lgu
From prod
Where 
    EXISTS(Select lprod_gu From lprod
                    Where lprod_gu = prod.prod_lgu
                        AND lprod_gu = 'P301')
;

-- TABLE JOIN
-- RDB의 핵심
-- 관계현 DB의 가장 큰 장점은 많은 TABLE을 JOIN하여 원하는 결과응 도출하는데 있다.
-- Equi Join = 이너조인 = 일반적인 조인

-- <ANSI JOIN>
-- Cross join
-- Inner join
-- Outer join = left / right = 분석시 많이 사용함.

-- Cross join = 데이터의 형태를 알기 위해서 함 = 모든 행, 모든 컬럼이 조회됨 = 다수개의 테이블로부터 조합된 결과가 발생 (n*m)
Select *
From lprod, prod; -- cross join

Select COUNT(*) -- count
From lprod, prod; -- cross join

Select *
From lprod, prod, buyer;

Select COUNT(*)
From lprod, prod, buyer;

-- Cross join
-- [일반방식]
Select m.mem_id, c.cart_member, p.prod_id
From member m, cart c, lprod l, prod p, buyer b; -- 별칭을 붙일때 AS를 사용하면 안됨.

Select COUNT(*)
From member m, cart c, lprod l, prod p, buyer b;

-- [ANSI 국제표준방식]
-- 이름 그대로를 사용
Select *
From member Cross join cart 
                    Cross join prod 
                    Cross join lprod
                    Cross join buyer;

-- Equi - join (Simple join) (Inner join)
-- n개의 테이블을 join할때에는 최소한 n-1개 이상의 조건식이 필요하다.

-- 상품테이블에서 상품코드, 상품명, 분류명을 조회
-- 상품테이블 : prod
-- 분류테이블 : lprod
-- [일반방식]
-- 일반적으로 Select가 많은 테이블을 먼저 적는 것이 좋다
Select p.prod_id 상품코드,
        p.prod_name 상품명,
        l.lprod_nm 분류명
From prod p, lprod l -- n = 2
-- 관계조건식을 제일 먼저 작성해야함.
Where p.prod_lgu = l.lprod_gu; -- n-1 = 1 / 연결해주기

-- [ANSI 국제표준방식]
Select p.prod_id 상품코드,
        p.prod_name 상품명,
        l.lprod_nm 분류명
From prod p Inner join lprod l
                    on(p.prod_lgu = l.lprod_gu); -- 관계조건을 작성, 일반조건도 작성할 수 있다.
                    
-- 별칭을 사용하는 방법
Select A.prod_id 상품코드,
        A.prod_name 상품명,
        B.lprod_nm 분류명,
        C.buyer_name 거래처명
From prod A, lprod B, buyer C -- From 절에는 AS 를 사용하면 안된다.
Where A.prod_lgu = B.lprod_gu
    AND A.prod_buyer = C.buyer_id;

-- [ANSI 국제표준방식]
Select A.prod_id 상품코드,
        A.prod_name 상품명,
        B.lprod_nm 분류명,
        C.buyer_name 거래처명
From prod A Inner join lprod B
                    ON (A.prod_lgu = B.lprod_gu)
                Inner join buyer C
                    ON (A.prod_buyer = C.buyer_id) ;
                    
/*
[문제]
회원이 구매한 거러처 정보를 조회
회원아이디, 회원이름, 상품거래처명, 상품분류명을 조회
*/
/*
<순서>
1. 사용할 테이블 = member, cart, prod buyer, lprod
2. 조회할 컬럼 = mem_id, mem_name, buyer_name, lprod_nm
3. 관계조건
mem_id = cart_member
cart_prod = prod_id
prod_buyer = buyer_id
prod_lgu = lprod_gu
4. 일반조건 = 없음
*/
-- [일반방식]
Select M.mem_id 회원ID,
        M.mem_name 회원이름,
        B.buyer_name 상품거래처명,
        L.lprod_nm 상품분류명
From member M, cart C, prod P, buyer B, lprod L
    Where M.mem_id = C.cart_member
        AND C.cart_prod = P.prod_id
        AND P.prod_buyer = B.buyer_id
        AND P.prod_lgu = L.lprod_gu;

-- 다른 연결        
Select M.mem_id 회원ID,
        M.mem_name 회원이름,
        B.buyer_name 상품거래처명,
        L.lprod_nm 상품분류명
From member M, cart C, prod P, buyer B, lprod L
    Where M.mem_id = C.cart_member
        AND C.cart_prod = P.prod_id
        AND P.prod_buyer = B.buyer_id
        AND B.buyer_lgu = L.lprod_gu;

-- 다른 연결        
Select M.mem_id 회원ID,
        M.mem_name 회원이름,
        B.buyer_name 상품거래처명,
        L.lprod_nm 상품분류명
From member M, cart C, prod P, buyer B, lprod L
    Where M.mem_id = C.cart_member
        AND C.cart_prod = P.prod_id
        AND P.prod_lgu = L.lprod_gu
        AND P.prod_buyer = B.buyer_id;

-- [ANSI 국제표준방식]
Select M.mem_id 회원ID,
        M.mem_name 회원이름,
        B.buyer_name 상품거래처명,
        L.lprod_nm 상품분류명
From member M Inner join cart C
                    ON(M.mem_id = C.cart_member)
                        Inner join prod P
                    ON(C.cart_prod = P.prod_id)
                        Inner join buyer B
                    ON(P.prod_buyer = B.buyer_id)
                        Inner join lprod L
                    ON(P.prod_lgu = L.lprod_gu);

-- 다른 연결
Select M.mem_id 회원ID,
        M.mem_name 회원이름,
        B.buyer_name 상품거래처명,
        L.lprod_nm 상품분류명
From member M Inner join cart C
                    ON(M.mem_id = C.cart_member)
                        Inner join prod P
                    ON(C.cart_prod = P.prod_id)
                        Inner join lprod L
                    ON(P.prod_lgu = L.lprod_gu)
                        Inner join buyer B
                    ON(L.lprod_gu = B.buyer_lgu)
;

-- 귀영언니
SELECT A.mem_id "회원ID", 
            A.mem_name "회원이름",
            B.buyer_name "상품거래처명",
            C.lprod_nm "상품분류명"
FROM member A, buyer B, lprod C, prod D, CART E
WHERE  B.buyer_lgu = C.lprod_gu
AND C.lprod_gu = D.prod_lgu
AND D.prod_id = E.cart_prod
AND E.cart_member = A.mem_id;

SELECT  A.mem_id "회원ID", 
            A.mem_name "회원이름",
            B.buyer_name "상품거래처명",
            C.lprod_nm "상품분류명"
FROM member A INNER JOIN cart E
                On(A.mem_id = E.cart_member)
                INNER JOIN prod D
                On(E.cart_prod = D.prod_id)
                INNER JOIN buyer B
                On(D.prod_buyer = B.buyer_id)
                INNER JOIN lprod C
                On(B.buyer_lgu = C.lprod_gu);

/*
[문제]
거래처가 '삼성전자'인 자료에 대한
상품코드, 상품명, 거래처명을 조회하려고 합니다.
*/
-- [일반방식]
Select P.prod_id 상품코드,
        P.prod_name 상품명,
        B.buyer_name 거래처
From prod P, buyer B
    Where P.prod_buyer = B.buyer_id
    AND B.buyer_name = '삼성전자';

-- [ANSI 국제표준방식]
Select P.prod_id 상품코드,
        P.prod_name 상품명,
        B.buyer_name 거래처
From prod P Inner join buyer B
                    ON(P.prod_buyer = B.buyer_id)
Where B.buyer_name ='삼성전자';

Select P.prod_id 상품코드,
        P.prod_name 상품명,
        B.buyer_name 거래처
From prod P Inner join buyer B
                    ON(P.prod_buyer = B.buyer_id
                        AND B.buyer_name ='삼성전자');

/*
[문제]
상품테이블에서 상품코드, 상품명, 분류명, 거러처명, 거래주소를 조회
판매가격이 10만원이하
거래처 주소가 부산인 경우만 조회
*/
-- [일반방식]
Select P.prod_id '상품코드',
        P.prod_name '상품명',
        L.lprod_id '상품분류명',
        B.buyer_name '거래처명',
        B.buyer_add1 '거래주소'
From prod P, lprod L, buyer B
    Where P.prod_lgu = L.lprod_gu
        AND B.buyer_id = P.prod_buyer
        AND P.prod_sale <= '100000'
        AND B.buyer_add1 LIKE '%부산%'
;

Select P.prod_id 상품코드,
        P.prod_name 상품명,
        L.lprod_id 상품분류명,
        B.buyer_name 거래처명,
        B.buyer_add1 거래주소,
        P.prod_sale 판매가
From prod P , lprod L , buyer B 
    Where prod_lgu = lprod_gu
        AND prod_buyer = buyer_id
        AND prod_sale <= '100000'
        AND buyer_add1 LIKE '%부산%'
;

-- [ANSI 국제표준방식]
Select P.prod_id 상품코드,
        P.prod_name 상품명,
        L.lprod_id 상품분류명,
        B.buyer_name 거래처명,
        B.buyer_add1 거래주소,
        P.prod_sale 판매가        
From prod P Inner join lprod L
                    ON(P.prod_lgu = L.lprod_gu)
                Inner join buyer B
                    ON(P.prod_buyer = B.buyer_id
                        AND P.prod_sale <= '100000'
                        AND B.buyer_add1 LIKE '%부산%');

/*
[문제]
상품분류코드(lprod_gu)가 P101인것에 대한
상품분류명, 상품아이디(상품코드), 판매가, 거러채당담자, 회원아이디, 주문수량 조회
상품분류명을 기준으로 내림차순 DESC
상품아이디를 기준으로 오름차순 ASC
일반, 표준
*/
-- [일반방식]
Select lprod_nm 상품분류명, 
            prod_id 상품분류코드, 
            prod_sale 판매가, 
            buyer_charger 거러채담당자, 
            mem_id 회원ID, 
            cart_qty 주문수량
From member, cart, prod, buyer, lprod
    Where mem_id = cart_member
        AND cart_prod = prod_id
        AND prod_buyer = buyer_id
        AND prod_lgu = lprod_gu
        AND lprod_gu = 'P101'
Order By lprod_nm DESC, prod_id ASC;

-- 강사님
Select lprod_nm 상품분류명, 
            prod_id 상품분류코드, 
            prod_sale 판매가, 
            buyer_charger 거러채담당자, 
            cart_member 회원ID, 
            cart_qty 주문수량
From cart, prod, buyer, lprod
    Where cart_prod = prod_id
        AND prod_buyer = buyer_id
        AND prod_lgu = lprod_gu
        AND lprod_gu = 'P101'
Order By lprod_nm DESC, prod_id ASC;

-- [ANSI 국제표준방식]
Select lprod_nm 상품분류명, 
            prod_id 상품분류코드, 
            prod_sale 판매가, 
            buyer_charger 거러채담당자, 
            mem_id 회원ID, 
            cart_qty 주문수량
From member Inner join cart
                        ON(mem_id = cart_member)
                    Inner join prod
                        ON(cart_prod = prod_id)
                    Inner join buyer
                        ON(prod_buyer = buyer_id)                        
                    Inner join lprod
                        ON(prod_lgu = lprod_gu
                            AND lprod_gu = 'P101')
Order By lprod_nm DESC, prod_id ASC;


