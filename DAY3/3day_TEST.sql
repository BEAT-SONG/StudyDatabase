-- ��޻�ǰ�ڵ尡 'P1'�̰� '��õ'�� ��� ���� ������� ��ǰ�� ������ 
-- ȸ���� ��ȥ������� 8������ �ƴϸ鼭 
-- ��ո��ϸ���(�Ҽ���°�ڸ�����) �̸��̸鼭 
-- �����Ͽ� ù��°�� ������ ȸ���� 
-- ȸ��ID, ȸ���̸�, ȸ�����ϸ����� �˻��Ͻÿ�.  
Select mem_id ȸ��ID, mem_name ȸ���̸�, ROUND(AVG(mem_mileage),2) AS "ȸ�����ϸ���"
From member
Where mem_memorial = '��ȥ�����'
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
                                            Where SUBSTR(buyer_add1, 1,2) = '��õ'
                                                         AND buyer_lgu LIKE 'P1%'))))
Group By mem_id, mem_name ;

Select prod_properstock, COUNT(prod_properstock)
From prod
Group By prod_properstock;

Select *
From prod;

--
Select mem_name ȸ����, 
        SUBSTR(mem_regno2,1,1) �ֹε�Ϲ�ȣ, 
        CASE WHEN SUBSTR(mem_regno2,1,1) = '1' THEN '����'
                WHEN SUBSTR(mem_regno2,1,1) = '2' THEN '����' 
                END "����"   
From member;

Select mem_id ȸ��ID, mem_name ȸ���̸�,
        CASE WHEN SUBSTR(mem_regno2,1,1) = '1' THEN '����'
                WHEN SUBSTR(mem_regno2,1,1) = '2' THEN '����' 
                END "����"
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


Select mem_id ȸ��ID, mem_name ȸ����
From member
Where mem_job != '�ڿ���'
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



Select mem_id ȸ��ID, mem_name ȸ����
From member
Where mem_job != '�ڿ���'
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

 
Select mem_id ȸ��ID, mem_name ȸ����
From member
Where mem_job != '�ڿ���'
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
 
 
Select mem_id ȸ��ID, mem_name ȸ����
From member
Where mem_job != '�ڿ���'
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
 
                                        
Select mem_id ȸ��ID, mem_name ȸ����
From member
Where mem_job != '�ڿ���'
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

Select mem_id ȸ��ID, mem_name ȸ����
From member
Where mem_job != '�ڿ���'
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
                            