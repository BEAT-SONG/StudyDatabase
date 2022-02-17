/*
[1문제]

주민등록상 1월생인 회원이 지금까지 구매한 상품의 상품분류 중  
뒤 두글자가 01이면 판매가를 10%인하하고
02면 판매가를 5%인상 나머지는 동일 판매가로 도출
(변경판매가의 범위는 500,000~1,000,000원 사이로 내림차순으로 도출하시오.)
(원화표기 및 천단위구분)
(Alias 상품분류, 판매가, 변경판매가)
*/
Select prod_lgu 상품분류, 
         prod_sale 판매가,
         CASE WHEN SUBSTR(prod_lgu, 3, 4) = '01' THEN TO_CHAR(prod_sale, 'L9,999,999')* 0.9
                 WHEN SUBSTR(prod_lgu, 3, 4) =  '02' THEN TO_CHAR(prod_sale, 'L9,999,999')* 1.05 
                 ELSE TO_CHAR(prod_sale, 'L9,999,999')
                 END new_sale
From prod
Where prod_sale BETWEEN 500000 AND 1000000
            AND prod_id 
                IN(Select cart_prod From cart
                    Where cart_member
                            IN(Select mem_id From member
                                Where TO_CHAR(mem_bir, 'MM') = '01'))
Order By new_sale DESC;

-- 원화표시랑 천단위표시가 안됨
Select prod_lgu 상품분류, 
         prod_sale 판매가,
         DECODE(SUBSTR(prod_lgu, 3, 4),
                    '01', prod_sale*0.9,
                    '02', prod_sale*0.95, prod_sale) AS new_sale
From prod
Where prod_sale BETWEEN 500000 AND 1000000
            AND prod_id 
                IN(Select cart_prod From cart
                    Where cart_member
                            IN(Select mem_id From member
                                Where TO_CHAR(mem_bir, 'MM') = '01'))
Order By new_sale DESC;

-- 이거는 안딤.. 왜??
Select prod_lgu 상품분류, 
         prod_sale 판매가,
         DECODE(SUBSTR(prod_lgu, 3, 4),
                    '01', TO_CHAR(prod_sale, 'L9,999,999')*0.9,
                    '02', TO_CHAR(prod_sale, 'L9,999,999')*1.05, prod_sale) AS new_sale
From prod
Where prod_sale BETWEEN 500000 AND 1000000
            AND prod_id 
                IN(Select cart_prod From cart
                    Where cart_member
                            IN(Select mem_id From member
                                Where TO_CHAR(mem_bir, 'MM') = '01'))
Order By new_sale DESC;
/*
[2문제]

회원중 1975년생이고 대전 주소의 회원이 구매했던 모든상품 중에 
판매가가 판매가의 전체평균보다 높은 제품만 검색해보세요.
단  
1. 판매가를 기준으로 내림차순하고, 판매가는 천단위 구분표시
2. 상품중 삼성이 들어간 제품만 필터 
3. 상품색상중 NULL값은 '검정'으로 처리
4. 색깔별 갯수는 1이상일 것만 조회
*/

/*
[3문제]

대전 지역에 거주하고 생일이 2월이고 구매일자가 4월 ~ 6월 사이인 회원 중 
구매수량이 전체회원의 평균 구매수량보다 높은 회원 조회 후 

"(mem_name) 회원님의 (Extract(month form mem_bir)) 월 생일을 진심으로 축하합니다. 
2마트 (mem_add 중 2글자) 점을 이용해 주셔서 감사합니다.
이번 2월 동안에는 VVIP회원으로 마일리지를 3배로 사용하실 수 있습니다.
앞으로도 많은 이용 바랍니다." 출력

(Alias 회원명, 성별, 주소, 이메일 주소, 생일 축하 문구)
*/