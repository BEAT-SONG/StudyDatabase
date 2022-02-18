/*
<�¿�>
�輺���� �ֹ��ߴ� ��ǰ�� ����� �����Ǿ� �Ҹ��̴�.
����ó�� ������ ���, ��ǰ ���޿� ������ ���� ����� �ʾ����ٴ� �亯�� �޾Ҵ�.
�輺���� �ش� ��ǰ�� ���� ����ڿ��� ���� ��ȭ�Ͽ� �����ϰ� �ʹ�.
� ��ȣ�� ��ȭ�ؾ� �ϴ°�?
*/
-- [��������]
Select DISTINCT(buyer_comtel) ��ȭ��ȣ
From buyer
Where buyer_id IN(Select prod_buyer From prod
                            Where prod_id
                                IN(Select cart_prod From cart
                                    Where cart_member
                                        IN(Select mem_id From member
                                            Where mem_name = '�輺��')));

-- [�Ϲݹ��]
Select DISTINCT(buyer_comtel) ��ȭ��ȣ
From buyer, prod, cart, member
Where buyer_id = prod_buyer
    AND prod_id = cart_prod
        AND cart_member = mem_id
            AND mem_name = '�輺��';

/*
<�°�>
���� �� Ÿ������ ��� ��ȯ������ ����ϴ� �ŷ�ó ����ڰ� ����ϴ� ��ǰ�� 
������ ȸ������ �̸�, ������ ��ȸ �ϸ� 
�̸��� '��'�� �����ϴ� ȸ�������� '��' �� ġȯ�ؼ� ����ض� 
*/
-- [��������]
Select CONCAT(REPLACE(SUBSTR(mem_name, 1, 1), '��', '��'), SUBSTR(mem_name, 2)) ȸ����,
        mem_bir ����
From member
Where mem_add1 NOT LIKE '%����%'
    AND mem_id IN(Select cart_member From cart
                            Where cart_prod
                                IN(Select prod_id From prod
                                    Where prod_buyer
                                        IN(Select buyer_id From buyer
                                            Where buyer_bank = '��ȯ����')))
;

/*
<����>
¦�� �޿� ���ŵ� ��ǰ�� �� 
��Ź ���ǰ� �ʿ� ���� ��ǰ���� ID, �̸�, �Ǹ� ������ ����Ͻÿ�.
���� ��� �� ������ ���� ���� ���� 10�ۼ�Ʈ ���ϵ� ������, 
���� ���� ���� 10�ۼ�Ʈ �߰��� ������ ����Ͻÿ�.
������ ID, �̸� ������ �����Ͻÿ�.
(��, ������ �Һ��ڰ� - ���԰��� ����Ѵ�.)
*/
-- DECODE�� ����ϸ� �ִ밡 ���ǿ� ���ԵǼ� ��������, �ּҴ� ���Ե��� �ʾ� ������� �ʾ� ����� ������ �ʴ´�. �ٸ� ����� ã�ƾ� ��.
Select prod_id ��ǰ�ڵ�,
        prod_name ��ǰ��,
        DECODE((prod_price - prod_cost),
                    (SELECT MIN(prod_price - prod_cost) FROM PROD), (prod_price - prod_cost)*1.10,
                    (SELECT MAX(prod_price - prod_cost) FROM PROD), (prod_price - prod_cost)*0.9, (prod_price - prod_cost)) AS re
From prod
Where prod_delivery != '��Ź ����'
    AND prod_id IN(Select cart_prod From cart
                            Where MOD(TO_NUMBER(SUBSTR(cart_no, 5, 2)), 2) = 0);

-- 3������ ���� ��                    
SELECT
    p.prod_id,
    p.prod_name,
    p.prod_price - p.prod_sale �ǸŸ���,
    CASE WHEN p.prod_price - p.prod_sale 
                        = (SELECT MAX(pp.prod_price - pp.prod_sale) FROM prod pp, cart cc
                           WHERE pp.prod_id = cc.cart_prod
                           AND mod(cc.cart_no, 2) = 0
                           AND pp.prod_delivery != '��Ź ����') 
            THEN ( p.prod_price - p.prod_sale ) * 0.9
            ELSE p.prod_price - p.prod_sale
            END AS max�ǸŸ���,
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
                AND pp.prod_delivery != '��Ź ����'
        ) THEN
            ( p.prod_price - p.prod_sale ) * 1.1
        ELSE
            p.prod_price - p.prod_sale
    END                        AS min�ǸŸ���
FROM
    prod p,
    cart c
WHERE
        p.prod_id = c.cart_prod
    AND mod(c.cart_no, 2) = 0
    AND p.prod_delivery != '��Ź ����';
    
-- ���缺
Select prod_id,
       prod_name,
       prod_price - prod_cost,
       case prod_price - prod_cost
       when (Select max(prod_price - prod_cost) From prod 
                Where prod_delivery != '��Ź ����'
                And prod_id 
                    In(Select cart_prod From cart
                        Where MOD(TO_NUMBER(SUBSTR(cart_no, 5, 2)), 2) = 0))
       then (prod_price - prod_cost) * 0.9
       when (Select min(prod_price - prod_cost) From prod 
                Where prod_delivery != '��Ź ����'
                And prod_id 
                    In(Select cart_prod From cart
                        Where MOD(TO_NUMBER(SUBSTR(cart_no, 5, 2)), 2) = 0))
       then (prod_price - prod_cost) * 1.1
       else prod_price - prod_cost end as �ǸŸ���
From prod
Where prod_delivery != '��Ź ����'
   And prod_id In(Select cart_prod From cart
                        Where MOD(TO_NUMBER(SUBSTR(cart_no, 5, 2)), 2) = 0)
Group By prod_id, prod_name, prod_price - prod_cost;


         
