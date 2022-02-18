/*
<태영>
김성욱씨는 주문했던 제품의 배송이 지연되어 불만이다.
구매처에 문의한 결과, 제품 공급에 차질이 생겨 배송이 늦어진다는 답변을 받았다.
김성욱씨는 해당 제품의 공급 담당자에게 직접 전화하여 항의하고 싶다.
어떤 번호로 전화해야 하는가?
*/
-- [서브쿼리]
Select DISTINCT(buyer_comtel) 전화번호
From buyer
Where buyer_id IN(Select prod_buyer From prod
                            Where prod_id
                                IN(Select cart_prod From cart
                                    Where cart_member
                                        IN(Select mem_id From member
                                            Where mem_name = '김성욱')));

-- [일반방식]
Select DISTINCT(buyer_comtel) 전화번호
From buyer, prod, cart, member
Where buyer_id = prod_buyer
    AND prod_id = cart_prod
        AND cart_member = mem_id
            AND mem_name = '김성욱';

/*
<태경>
서울 외 타지역에 살며 외환은행을 사용하는 거래처 담당자가 담당하는 상품을 
구매한 회원들의 이름, 생일을 조회 하며 
이름이 '이'로 시작하는 회원명을을 '리' 로 치환해서 출력해라 
*/
-- [서브쿼리]
Select CONCAT(REPLACE(SUBSTR(mem_name, 1, 1), '이', '리'), SUBSTR(mem_name, 2)) 회원명,
        mem_bir 생일
From member
Where mem_add1 NOT LIKE '%서울%'
    AND mem_id IN(Select cart_member From cart
                            Where cart_prod
                                IN(Select prod_id From prod
                                    Where prod_buyer
                                        IN(Select buyer_id From buyer
                                            Where buyer_bank = '외환은행')))
;

/*
<덕현>
짝수 달에 구매된 상품들 중 
세탁 주의가 필요 없는 상품들의 ID, 이름, 판매 마진을 출력하시오.
마진 출력 시 마진이 가장 높은 값은 10퍼센트 인하된 값으로, 
가장 낮은 값은 10퍼센트 추가된 값으로 출력하시오.
정렬은 ID, 이름 순으로 정렬하시오.
(단, 마진은 소비자가 - 매입가로 계산한다.)
*/
-- DECODE를 사용하면 최대가 조건에 포함되서 나오지만, 최소는 포함되지 않아 적용되지 않아 결과가 나오지 않는다. 다른 방법을 찾아야 함.
Select prod_id 상품코드,
        prod_name 상품명,
        DECODE((prod_price - prod_cost),
                    (SELECT MIN(prod_price - prod_cost) FROM PROD), (prod_price - prod_cost)*1.10,
                    (SELECT MAX(prod_price - prod_cost) FROM PROD), (prod_price - prod_cost)*0.9, (prod_price - prod_cost)) AS re
From prod
Where prod_delivery != '세탁 주의'
    AND prod_id IN(Select cart_prod From cart
                            Where MOD(TO_NUMBER(SUBSTR(cart_no, 5, 2)), 2) = 0);

-- 3조에서 나온 답                    
SELECT
    p.prod_id,
    p.prod_name,
    p.prod_price - p.prod_sale 판매마진,
    CASE WHEN p.prod_price - p.prod_sale 
                        = (SELECT MAX(pp.prod_price - pp.prod_sale) FROM prod pp, cart cc
                           WHERE pp.prod_id = cc.cart_prod
                           AND mod(cc.cart_no, 2) = 0
                           AND pp.prod_delivery != '세탁 주의') 
            THEN ( p.prod_price - p.prod_sale ) * 0.9
            ELSE p.prod_price - p.prod_sale
            END AS max판매마진,
    CASE
        WHEN p.prod_price - p.prod_sale = (
            SELECT
                MIN(pp.prod_price - pp.prod_sale)
            FROM
                prod pp,
                cart cc
            WHERE
                    pp.prod_id = cc.cart_prod
                AND mod(cc.cart_no, 2) = 0
                AND pp.prod_delivery != '세탁 주의'
        ) THEN
            ( p.prod_price - p.prod_sale ) * 1.1
        ELSE
            p.prod_price - p.prod_sale
    END                        AS min판매마진
FROM
    prod p,
    cart c
WHERE
        p.prod_id = c.cart_prod
    AND mod(c.cart_no, 2) = 0
    AND p.prod_delivery != '세탁 주의';
    
-- 송재성
Select prod_id,
       prod_name,
       prod_price - prod_cost,
       case prod_price - prod_cost
       when (Select max(prod_price - prod_cost) From prod 
                Where prod_delivery != '세탁 주의'
                And prod_id 
                    In(Select cart_prod From cart
                        Where MOD(TO_NUMBER(SUBSTR(cart_no, 5, 2)), 2) = 0))
       then (prod_price - prod_cost) * 0.9
       when (Select min(prod_price - prod_cost) From prod 
                Where prod_delivery != '세탁 주의'
                And prod_id 
                    In(Select cart_prod From cart
                        Where MOD(TO_NUMBER(SUBSTR(cart_no, 5, 2)), 2) = 0))
       then (prod_price - prod_cost) * 1.1
       else prod_price - prod_cost end as 판매마진
From prod
Where prod_delivery != '세탁 주의'
   And prod_id In(Select cart_prod From cart
                        Where MOD(TO_NUMBER(SUBSTR(cart_no, 5, 2)), 2) = 0)
Group By prod_id, prod_name, prod_price - prod_cost;


         
