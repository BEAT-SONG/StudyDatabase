/*
[1문제]
주민등록상 1월생인 회원이 지금까지 구매한 상품의 상품분류 중  
뒤 두글자가 01이면 판매가를 10%인하하고
02면 판매가를 5%인상 나머지는 동일 판매가로 도출
(변경판매가의 범위는 500,000~1,000,000원 사이로 내림차순으로 도출하시오.)
(원화표기 및 천단위구분)
(Alias 상품분류, 판매가, 변경판매가)
*/
-- 안됭,.
Select prod_lgu 상품분류, 
         prod_sale 판매가,
         CASE WHEN SUBSTR(prod_lgu, 3, 4) = '01' THEN TO_NUMBER(prod_sale, 'L9,999,999,999,999')* 0.9
                 WHEN SUBSTR(prod_lgu, 3, 4) =  '02' THEN TO_NUMBER(prod_sale, 'L9,999,999,999,999')* 1.05 
                 ELSE TO_NUMBER(prod_sale, 'L9,999,999,999,999')
                 END new_sale
From prod
Where prod_sale BETWEEN 500000 AND 1000000
            AND prod_id 
                IN(Select cart_prod From cart
                    Where cart_member
                            IN(Select mem_id From member
                                Where TO_CHAR(mem_bir, 'MM') = '01'))
Order By new_sale DESC;

-- 이거는 안딤.. 왜??
-- DECODE안에 TO_CHAR을 사용하면 안된다.
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

-- 원화표시랑 천단위표시가 됨
-- DECODE 전체에 TO_CHAR(, 'L9,999,999,999')을 적용하면 가능!!!!!
Select prod_lgu 상품분류, 
         prod_sale 판매가,
         TO_CHAR((DECODE(SUBSTR(prod_lgu, 3, 4),
                    '01', prod_sale*0.9,
                    '02', prod_sale*0.95, prod_sale)), 'L9,999,999,999') AS new_sale
From prod
Where prod_sale BETWEEN 500000 AND 1000000
            AND prod_id 
                IN(Select cart_prod From cart
                    Where cart_member
                            IN(Select mem_id From member
                                Where TO_CHAR(mem_bir, 'MM') = '01'))
Order By new_sale DESC;


-- 5조
-- 주민번호상 생일
select prod_lgu 상품분류, prod_sale 판매가,
to_char(decode(substr(prod_lgu,3,2),
    '01',prod_sale - prod_sale*0.1 ,
    '02',prod_sale*1.05, prod_sale),'L999,999,999') as 변경판매가
from prod
where prod_id in
(select cart_prod
from cart
where cart_member in
(select mem_id
from member
where substr(mem_regno1,3,2)= '01'))
and decode(substr(prod_lgu,3,1),
    '01',prod_sale - prod_sale*0.1 ,
    '02',prod_sale*1.05, prod_sale) BETWEEN 500000 and 1000000
order by 변경판매가;

/*
[2문제]
회원중 1975년생[mem_bir]이고 대전[mem_add1] 주소의 회원이 구매했던 모든상품 중에 
판매가[prod_sale]가 판매가의 전체평균[avg(prod_sale)]보다 높은 제품만 검색해보세요.
단  
1. 판매가[prod_sale]를 기준으로 내림차순[desc]하고, 판매가는 천단위 구분표시[to_char(,)]
2. 상품중 삼성이 들어간 제품만 필터 [prod_name]
3. 상품색상중 NULL값은 '검정'으로 처리 [NVL(prod_color, '검정')]
4. 색깔별 갯수는 1이상일 것만 조회[group by prod_color]
*/
Select prod_name 제품명,
        NVL(prod_color, '검정') 제품색상,
        prod_sale 제품판매가
From prod
Group By prod_name, prod_color, prod_sale
;


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