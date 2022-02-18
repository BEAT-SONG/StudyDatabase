/*
[����]
1. 
'����ĳ�־�'[lprod_nm]�̸鼭 ��ǰ �̸��� '����'[prod_name]�� ���� ��ǰ�̰�, 
���Լ���[buy_qty]�� 30���̻��̸鼭 6���� �԰��� ��ǰ[buy_date]��
���ϸ���[mem_mileage]�� �ǸŰ�[prod_sale]�� ���� ���� ��ȸ�Ͻÿ�
Alias �̸�,�ǸŰ���, �ǸŰ���+���ϸ���
*/
-- ��� �� Ǯ�� �ٸ� ���� ���°� ������
Select prod_name ��ǰ��,
        prod_sale �ǸŰ���,
        prod_sale + NVL(mem_mileage, 0) ���ϸ���New
From prod, member
    Where prod_name LIKE '%����%'
        AND prod_id = lprod_gu
        AND lprod_nm = '����ĳ�־�'
        AND prod_id = buy_prod
        AND buy_qty >= '30'
        AND EXTRACT(month FROM buy_date) = 06
        ;

-- 2�� ��
SELECT prod_name ��ǰ��,
             prod_sale �ǸŰ���,
             prod_sale + NVL(prod_mileage,0) ���ϸ���New
   FROM prod
 WHERE prod_lgu IN (SELECT lprod_gu
                                 FROM lprod
                                WHERE lprod_nm = '����ĳ�־�')
      AND prod_name like '%����%'
      AND prod_id IN (SELECT buy_prod
                                FROM buyprod
                              WHERE buy_qty >= 30
                                   AND EXTRACT(month FROM buy_date) = 6);

-- ���� �ȵ�..
Select prod_name ��ǰ��,
        prod_sale �ǸŰ���,
        prod_sale + NVL(prod_mileage, 0)
From prod
Where prod_name LIKE '%����%'
    AND prod_lgu 
        IN(Select lprod_gu From lprod
            Where lprod_nm = '����ĳ�־�')
    AND prod_id 
        IN(Select buy_prod From buyer
            Where EXTRACT(month FROM buy_date)
                AND buy_qty >= 30);
    
/*
2. 
�ŷ�ó �ڵ�[buyer_id]�� 'P20' ���� �����ϴ� �ŷ�ó�� �����ϴ� ��ǰ���� 
��ǰ �����[prod_insdate]�� 2005�� 1�� 31��(2����) ���Ŀ� �̷������ 
���Դܰ�[buy_cost]�� 20������ �Ѵ� ��ǰ��
������ ���� ���ϸ���[mem_mileage]�� 2500�̻��̸� ���ȸ�� 
�ƴϸ� �Ϲ�ȸ������ ����϶�
�÷� ȸ���̸��� ���ϸ���, ��� �Ǵ� �Ϲ�ȸ���� ��Ÿ���� �÷�
*/
Select mem_name ȸ���̸�,
        mem_mileage ���ϸ���,
        CASE WHEN mem_mileage >= 2500
                THEN '���ȸ��'
                ELSE '�Ϻ�ȸ��'
                    END ȸ�����                
From member
Where mem_id IN(Select cart_member From cart
                            Where cart_prod
                                IN(Select prod_id From prod
                                    Where TO_CHAR(prod_insdate, 'YYYY-MM-DD') > '2005-01-31'
                                        AND prod_id IN(Select buy_prod From buyprod
                                                                Where buy_cost >= 200000)
                                        AND prod_buyer IN(Select buyer_id From buyer
                                                                    Where buyer_lgu LIKE 'P20%')));
-- 2��
SELECT  mem_name as ȸ����,
            mem_mileage as ���ϸ���,
            CASE 
            WHEN mem_mileage > = 2500 THEN '���ȸ��'
            ELSE '�Ϲ�ȸ��' 
            END as �����÷�
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
6���� ����(5���ޱ���)�� �԰�� ��ǰ[buy_date] �߿� 
���Ư�����[prod_delivery]�� '��Ź ����'�̸鼭 ����[prod_color]�� null���� ��ǰ�� �߿� 
�Ǹŷ�[cart_qty]�� ��ǰ �Ǹŷ��� ���[avg(cart_qty)]���� ���� �ȸ��� ������
�达 ��[mem_name]�� ���� �մ��� �̸��� 
���� ���ϸ���[mem_mileage]�� ���ϰ� ����[mem_regno2]�� ����Ͻÿ�
Alias �̸�, ���� ���ϸ���, ����
*/
-- NULL�� ��ȸ�� ���� IS NULL�� ����ؾ��Ѵ�!!
Select mem_name �̸�,
        mem_mileage �������ϸ���,
        CASE WHEN SUBSTR(mem_regno2, 1,1) = '1'
                THEN '����'
                ELSE '����'
                    END ����
From member
Where mem_name LIKE '��%'
    AND mem_id 
        IN(Select cart_member From cart
            Where cart_qty >= (Select AVG(cart_qty) From cart)
                AND cart_prod 
                    IN(Select prod_id From prod
                        Where prod_color is NULL
                            AND prod_delivery LIKE '��Ź ����'
                            AND prod_id 
                                IN(Select buy_prod From buyprod
                                    Where TO_CHAR(buy_date, 'MM-DD') <= '05-31')))
;

-- 2��
SELECT mem_name as �̸�,
            mem_mileage as �������ϸ���,
            DECODE(substr(mem_regno2,1,1),1,'��','��') as ����
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
                                                                                AND prod_delivery = '��Ź ����'
                                                                                AND prod_color is NULL )
                                                                                                                                                             
AND cart_qty >= (select AVG(cart_qty) FROM cart))
AND mem_name like '��%';




-- ���� ���
select mem_name ȸ����, 
        mem_mileage �������ϸ���, 
        decode(substr(mem_regno2, 1,1),
                  1, '����',
                  2, '����') as ����
from member 
where mem_name like '��%'
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
                                                       and prod_delivery = '��Ź ����'
                                                       and prod_color is null
                                                    )
                        );

