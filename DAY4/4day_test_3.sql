/*
1. 오철희가 산 물건 중 TV 가 고장나서 교환받으려고 한다
교환받으려면 거래처 전화번호를 이용해야 한다.
구매처와 전화번호를 조회하시오.
*/
Select buyer_name 구매처,
        buyer_comtel 전화번호
From buyer
Where buyer_id IN(Select prod_buyer From prod
                            Where prod_name LIKE '%TV%'
                            AND prod_id
                                IN(Select cart_prod From cart
                                    Where cart_member
                                        IN(Select mem_id From member
                                            Where mem_name = '오철희')));

-- join 사용
-- [일반방식]
Select buyer_name 구매처, buyer_comtel 전화번호
From buyer, prod, cart, member
    Where buyer_id = prod_buyer
        AND prod_name LIKE '%TV%'
            AND prod_id = cart_prod
                AND cart_member = mem_id
                AND mem_name = '오철희';

-- [ANSI 국제표준방식]
Select buyer_name 구매처, buyer_comtel 전화번호
From buyer Inner join prod
                    ON(buyer_id = prod_buyer
                        AND prod_name LIKE '%TV%')
                Inner join cart
                    ON(prod_id = cart_prod)
                Inner join member
                    ON(cart_member = mem_id
                        AND mem_name = '오철희');
 
-- 컨트롤+F7 = 정리
-- 송재성
SELECT
    buyer_name   구매처,
    buyer_comtel 전화번호
FROM
    buyer
WHERE
    buyer_id IN (
        SELECT
            prod_buyer
        FROM
            prod
        WHERE
            prod_name LIKE '%TV%'
            AND prod_id IN (
                SELECT
                    cart_prod
                FROM
                    cart
                WHERE
                    cart_member IN (
                        SELECT
                            mem_id
                        FROM
                            member
                        WHERE
                            mem_name = '오철희'
                    )
            )
    );


/*
2. 대전에 사는 73년이후에 태어난 주부들중 2005년4월에 구매한 물품을 조회하고, 
그상품을 거래하는 각거래처의 계좌 은행명과 계좌번호를 뽑으시오.
(단, 은행명-계좌번호).
*/
Select prod_name 물품명
From prod
Where prod_id 
            IN(Select cart_prod From cart
                Where cart_no LIKE '200504%'
                    AND cart_member
                        IN(Select mem_id From member
                            Where TO_CHAR(mem_bir, 'YY') >= '73'
                                AND mem_job = '주부'
                                AND mem_add1 LIKE '%대전%'));

Select buyer_bank || ' - ' || buyer_bankno 
From buyer
Where buyer_id 
    IN(Select prod_buyer From prod
        Where prod_id 
            IN(Select cart_prod From cart
                Where cart_no LIKE '200504%'
                    AND cart_member
                        IN(Select mem_id From member
                            Where TO_CHAR(mem_bir, 'YY') >= '73'
                                AND mem_job = '주부'
                                AND mem_add1 LIKE '%대전%')));
                                
SELECT buyer_bank AS "은행명", 
           buyer_bankno AS "계좌번호"
FROM buyer            
            WHERE buyer_id IN(
                                        SELECT prod_buyer
                                        FROM prod
                                        WHERE prod_id IN(
                                                            SELECT cart_prod
                                                            FROM cart
                                                            WHERE cart_member IN(
                                                                                SELECT mem_id 
                                                                                FROM member
                                                                                WHERE mem_add1 like '%대전%' 
                                                                                AND substr(mem_regno1,1,2) >= '73'
                                                                                AND mem_job = '주부')                         
                                                             AND substr(cart_no,1,6) = '200504')
                                                       );
                                

-- 송재성
SELECT
    buyer_bank || '-' ||buyer_bankno
FROM
    buyer
WHERE
    buyer_id IN (
        SELECT
            prod_buyer
        FROM
            prod
        WHERE
            prod_id IN (
                SELECT
                    cart_prod
                FROM
                    cart
                WHERE
                    cart_member IN (
                        SELECT
                            mem_id
                        FROM
                            member
                        WHERE
                            mem_add1 LIKE '%대전%'
                            AND mem_job = '주부'
                            AND to_char(mem_bir, 'yy') > 73
                    )
                    AND substr(cart_no, 1, 6) = 200504
            )
    );

/*
3. 물건을 구매한 회원들 중 5개이상 구매한 회원과 4개이하로 구매한 회원에게 쿠폰을 할인율이 다른 쿠폰을 발행할 예정이다. 
회원들을 구매개수(qty)에 따라  오름차순으로 정렬하고  회원들의 회원id와 전화번호(HP)를 조회하라.
qty 5개 이상으로 하시면 됩니다.
*/
Select mem_id 회원ID,
        mem_hp 전화번호,
        (Select sum(cart_qty) From cart
            Where cart_member = member.mem_id) as TMP
From member
Order By TMP ASC;

