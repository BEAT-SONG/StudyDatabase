/*
[문제]
1. 
'여성캐주얼'[lprod_nm]이면서 제품 이름에 '여름'[prod_name]이 들어가는 상품이고, 
매입수량[buy_qty]이 30개이상이면서 6월에 입고한 제품[buy_date]의
마일리지[mem_mileage]와 판매가[prod_sale]를 합한 값을 조회하시오
Alias 이름,판매가격, 판매가격+마일리지
*/
-- 계속 안 풀림 다른 날에 보는게 나을듯
Select prod_name 상품명,
        prod_sale 판매가격,
        prod_sale + NVL(mem_mileage, 0) 마일리지New
From prod, member
    Where prod_name LIKE '%여름%'
        AND prod_id = lprod_gu
        AND lprod_nm = '여성캐주얼'
        AND prod_id = buy_prod
        AND buy_qty >= '30'
        AND EXTRACT(month FROM buy_date) = 06
        ;

-- 2조 답
SELECT prod_name 상품명,
             prod_sale 판매가격,
             prod_sale + NVL(prod_mileage,0) 마일리지New
   FROM prod
 WHERE prod_lgu IN (SELECT lprod_gu
                                 FROM lprod
                                WHERE lprod_nm = '여성캐주얼')
      AND prod_name like '%여름%'
      AND prod_id IN (SELECT buy_prod
                                FROM buyprod
                              WHERE buy_qty >= 30
                                   AND EXTRACT(month FROM buy_date) = 6);

-- 내꺼 안되..
Select prod_name 상품명,
        prod_sale 판매가격,
        prod_sale + NVL(prod_mileage, 0)
From prod
Where prod_name LIKE '%여름%'
    AND prod_lgu 
        IN(Select lprod_gu From lprod
            Where lprod_nm = '여성캐주얼')
    AND prod_id 
        IN(Select buy_prod From buyer
            Where EXTRACT(month FROM buy_date)
                AND buy_qty >= 30);
    
/*
2. 
거래처 코드[buyer_id]가 'P20' 으로 시작하는 거래처가 공급하는 상품에서 
제품 등록일[prod_insdate]이 2005년 1월 31일(2월달) 이후에 이루어졌고 
매입단가[buy_cost]가 20만원이 넘는 상품을
구매한 고객의 마일리지[mem_mileage]가 2500이상이면 우수회원 
아니면 일반회원으로 출력하라
컬럼 회원이름과 마일리지, 우수 또는 일반회원을 나타내는 컬럼
*/
Select mem_name 회원이름,
        mem_mileage 마일리지,
        CASE WHEN mem_mileage >= 2500
                THEN '우수회원'
                ELSE '일빈회원'
                    END 회원등급                
From member
Where mem_id IN(Select cart_member From cart
                            Where cart_prod
                                IN(Select prod_id From prod
                                    Where TO_CHAR(prod_insdate, 'YYYY-MM-DD') > '2005-01-31'
                                        AND prod_id IN(Select buy_prod From buyprod
                                                                Where buy_cost >= 200000)
                                        AND prod_buyer IN(Select buyer_id From buyer
                                                                    Where buyer_lgu LIKE 'P20%')));
-- 2조
SELECT  mem_name as 회원명,
            mem_mileage as 마일리지,
            CASE 
            WHEN mem_mileage > = 2500 THEN '우수회원'
            ELSE '일반회원' 
            END as 변경컬럼
FROM member
WHERE mem_id IN (SELECT cart_member
                            FROM cart
                            WHERE cart_prod IN (SELECT prod_id 
                                                            FROM prod
                                                            WHERE prod_buyer IN (SELECT buyer_id
                                                                                            FROM buyer 
                                                                                            WHERE buyer_id LIKE 'P20%' ) 
                                                           AND prod_insdate > = '05/01/31'
                                                           AND prod_cost > 200000)
                                                );              

/*
3. 
6월달 이전(5월달까지)에 입고된 상품[buy_date] 중에 
배달특기사항[prod_delivery]이 '세탁 주의'이면서 색상[prod_color]이 null값인 제품들 중에 
판매량[cart_qty]이 제품 판매량의 평균[avg(cart_qty)]보다 많이 팔린걸 구매한
김씨 성[mem_name]을 가진 손님의 이름과 
보유 마일리지[mem_mileage]를 구하고 성별[mem_regno2]을 출력하시오
Alias 이름, 보유 마일리지, 성별
*/
-- NULL을 조회할 때는 IS NULL을 사용해야한다!!
Select mem_name 이름,
        mem_mileage 보유마일리지,
        CASE WHEN SUBSTR(mem_regno2, 1,1) = '1'
                THEN '남성'
                ELSE '여성'
                    END 성별
From member
Where mem_name LIKE '김%'
    AND mem_id 
        IN(Select cart_member From cart
            Where cart_qty >= (Select AVG(cart_qty) From cart)
                AND cart_prod 
                    IN(Select prod_id From prod
                        Where prod_color is NULL
                            AND prod_delivery LIKE '세탁 주의'
                            AND prod_id 
                                IN(Select buy_prod From buyprod
                                    Where TO_CHAR(buy_date, 'MM-DD') <= '05-31')))
;

-- 2조
SELECT mem_name as 이름,
            mem_mileage as 보유마일리지,
            DECODE(substr(mem_regno2,1,1),1,'남','여') as 성별
FROM member 
WHERE mem_id IN(SELECT cart_member 
                            FROM cart
                            WHERE cart_prod IN(
                                                    SELECT prod_id
                                                    FROM prod 
                                                    WHERE  prod_id IN(
                                                                                SELECT buy_prod
                                                                                FROM buyprod
                                                                                WHERE extract(month from buy_date) < 6)
                                                                                AND prod_delivery = '세탁 주의'
                                                                                AND prod_color is NULL )
                                                                                                                                                             
AND cart_qty >= (select AVG(cart_qty) FROM cart))
AND mem_name like '김%';




-- 예은 언니
select mem_name 회원명, 
        mem_mileage 보유마일리지, 
        decode(substr(mem_regno2, 1,1),
                  1, '남성',
                  2, '여성') as 성별
from member 
where mem_name like '김%'
   and mem_id In (
                         select cart_member
                         from cart
                         where cart_prod In ( select cart_prod
                                                    from cart
                                                    group by cart_prod
                                                    having sum(cart_qty) >=  (select avg_s from (select avg(sum(cart_qty)) as avg_s
                                                                                                                from cart
                                                                                                                group by cart_prod
                                                                                                                )
                                                                                        )
                                                    )
                            and cart_prod in (
                                                    select prod_id 
                                                    from prod
                                                    where to_char(prod_insdate, 'mm') <= 05
                                                       and prod_delivery = '세탁 주의'
                                                       and prod_color is null
                                                    )
                        );

