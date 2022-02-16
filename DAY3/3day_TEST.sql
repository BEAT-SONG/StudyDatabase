-- 취급상품코드가 'P1'이고 '인천'에 사는 구매 담당자의 상품을 구매한 
-- 회원의 결혼기념일이 8월달이 아니면서 
-- 평균마일리지(소수두째자리까지) 미만이면서 
-- 구매일에 첫번째로 구매한 회원의 
-- 회원ID, 회원이름, 회원마일리지를 검색하시오.  
Select mem_id 회원ID, mem_name 회원이름, ROUND(AVG(mem_mileage),2) AS "회원마일리지"
From member
Where mem_memorial = '결혼기념일'
        AND EXTRACT(MONTH FROM mem_memorialday) != '8' 
        AND mem_mileage < (Select ROUND(AVG(mem_mileage),3) From member)
            AND mem_id 
                IN (Select cart_member From cart
                    Where cart_no LIKE '%1'
                            AND cart_prod 
                             IN(Select prod_id From prod
                                  Where prod_lgu
                                        IN(Select lprod_gu From lprod
                                         Where lprod_gu
                                            IN(Select buyer_lgu From buyer
                                            Where SUBSTR(buyer_add1, 1,2) = '인천'
                                                         AND buyer_lgu LIKE 'P1%'))))
Group By mem_id, mem_name ;

Select prod_properstock, COUNT(prod_properstock)
From prod
Group By prod_properstock;

Select *
From prod;

--
Select mem_name 회원명, 
        SUBSTR(mem_regno2,1,1) 주민등록번호, 
        CASE WHEN SUBSTR(mem_regno2,1,1) = '1' THEN '남성'
                WHEN SUBSTR(mem_regno2,1,1) = '2' THEN '여성' 
                END "성별"   
From member;

Select mem_id 회원ID, mem_name 회원이름,
        CASE WHEN SUBSTR(mem_regno2,1,1) = '1' THEN '남성'
                WHEN SUBSTR(mem_regno2,1,1) = '2' THEN '여성' 
                END "성별"
From member
;

Select prod_properstock, COUNT(prod_properstock)
From prod
Group By  prod_properstock

;


Select prod_properstock, COUNT(prod_properstock)
From prod
Group By  prod_properstock
Order By  COUNT(prod_properstock) DESC;                       

Select prod_properstock, COUNT(prod_properstock)
From prod
Where prod_properstock = '9'
Group By  prod_properstock;    
                            
Where prod_properstock = '9'

select prod_properstock, 
        count(prod_properstock) 
from prod 
group by prod_properstock
HAVING count(prod_properstock) = ( select MAX(CNT) as max_cnt
    from (
        select prod_properstock, 
            count(prod_properstock) AS CNT
        from prod 
        group by prod_properstock
        order by count(prod_properstock) desc
        ))
order by count(prod_properstock) desc;


Select mem_id 회원ID, mem_name 회원명
From member
Where mem_job != '자영업'
    AND mem_id
    IN (Select cart_member From cart
        Where cart_prod
            IN (Select select prod_properstock, count(prod_properstock) 
                 from prod 
                 group by prod_properstock
                  HAVING count(prod_properstock) = ( select MAX(CNT) as max_cnt
                    from (
                        select prod_properstock, 
                            count(prod_properstock) AS CNT
                        from prod 
                        group by prod_properstock
                        order by count(prod_properstock) desc
                        ))
                order by count(prod_properstock) desc; )
;

select prod_properstock
from prod 
    group by prod_properstock
    HAVING count(prod_properstock) = ( select MAX(CNT) as max_cnt
        from (
            select prod_properstock, 
                count(prod_properstock) AS CNT
                    from prod 
                    group by prod_properstock
                            order by count(prod_properstock) desc
                            ))
                    order by count(prod_properstock) desc;



Select mem_id 회원ID, mem_name 회원명
From member
Where mem_job != '자영업'
    AND mem_id
    IN (Select cart_member From cart
        Where cart_prod
            IN (select prod_properstock
                    from prod 
                        group by prod_properstock
                        HAVING count(prod_properstock) = ( select MAX(CNT) as max_cnt
                            from (
                                select prod_properstock, 
                                    count(prod_properstock) AS CNT
                                        from prod 
                                        group by prod_properstock
                                                order by count(prod_properstock) desc
                                                ))
                                        order by count(prod_properstock) desc));
                                        
                                        
select prod_sale
from prod
Where prod_sale > (select avg(prod_sale) from prod)*3
;

 
Select mem_id 회원ID, mem_name 회원명
From member
Where mem_job != '자영업'
    AND mem_id
    IN (Select cart_member 
        From cart
        Where cart_prod
            IN (Select prod_id From prod
                Where prod_sale > (select avg(prod_sale) from prod)
                AND prod_properstock 
                    IN (select prod_properstock from prod 
                        group by prod_properstock
                            HAVING count(prod_properstock) = (select MAX(CNT) as max_cnt 
                                from (select prod_properstock, count(prod_properstock) AS CNT 
                                    from prod 
                                     group by prod_properstock)))
                    )) ; 
 
 
Select mem_id 회원ID, mem_name 회원명
From member
Where mem_job != '자영업'
    AND mem_id
    IN (Select cart_member 
        From cart
        Where cart_prod
            IN (Select prod_id 
                From prod
                Where prod_properstock IN (select prod_properstock
                                           from prod 
                                           group by prod_properstock
                                           HAVING count(prod_properstock) = (select MAX(CNT) as max_cnt
                                                                             from (select prod_properstock, count(prod_properstock) AS CNT 
                                                                                   from prod 
                                                                                   group by prod_properstock))))) ; 
 
                                        
Select mem_id 회원ID, mem_name 회원명
From member
Where mem_job != '자영업'
    AND mem_id
    IN (Select cart_member From cart
        Where cart_prod
            IN (Select prod_id From prod
                Where prod_sale > (select avg(prod_sale) from prod)*3
                    AND prod_properstock IN (select prod_properstock
                                           from prod 
                                           group by prod_properstock
                                           HAVING count(prod_properstock) = (select MAX(CNT) as max_cnt
                                                                             from (select prod_properstock, count(prod_properstock) AS CNT 
                                                                                   from prod 
                                                                                   group by prod_properstock)))))
                                                                                   ));

Select mem_id 회원ID, mem_name 회원명
From member
Where mem_job != '자영업'
    AND mem_id
    IN (Select cart_member 
        From cart
        Where cart_prod
            IN (Select prod_id 
                From prod
                Where prod_properstock IN (select prod_properstock
                                           from prod 
                                           group by prod_properstock
                                           HAVING count(prod_properstock) = (select MAX(CNT) as max_cnt
                                                                             from (select prod_properstock, count(prod_properstock) AS CNT 
                                                                                   from prod 
                                                                                   group by prod_properstock))) 

                                                    ) 
                                                    ) ;                                
                            