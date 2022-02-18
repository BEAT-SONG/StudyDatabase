/*
1. ��ö�� �� ���� �� TV �� ���峪�� ��ȯ�������� �Ѵ�
��ȯ�������� �ŷ�ó ��ȭ��ȣ�� �̿��ؾ� �Ѵ�.
����ó�� ��ȭ��ȣ�� ��ȸ�Ͻÿ�.
*/
Select buyer_name ����ó,
        buyer_comtel ��ȭ��ȣ
From buyer
Where buyer_id IN(Select prod_buyer From prod
                            Where prod_name LIKE '%TV%'
                            AND prod_id
                                IN(Select cart_prod From cart
                                    Where cart_member
                                        IN(Select mem_id From member
                                            Where mem_name = '��ö��')));

-- join ���
-- [�Ϲݹ��]
Select buyer_name ����ó, buyer_comtel ��ȭ��ȣ
From buyer, prod, cart, member
    Where buyer_id = prod_buyer
        AND prod_name LIKE '%TV%'
            AND prod_id = cart_prod
                AND cart_member = mem_id
                AND mem_name = '��ö��';

-- [ANSI ����ǥ�ع��]
Select buyer_name ����ó, buyer_comtel ��ȭ��ȣ
From buyer Inner join prod
                    ON(buyer_id = prod_buyer
                        AND prod_name LIKE '%TV%')
                Inner join cart
                    ON(prod_id = cart_prod)
                Inner join member
                    ON(cart_member = mem_id
                        AND mem_name = '��ö��');
 
-- ��Ʈ��+F7 = ����
-- ���缺
SELECT
    buyer_name   ����ó,
    buyer_comtel ��ȭ��ȣ
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
                            mem_name = '��ö��'
                    )
            )
    );


/*
2. ������ ��� 73�����Ŀ� �¾ �ֺε��� 2005��4���� ������ ��ǰ�� ��ȸ�ϰ�, 
�׻�ǰ�� �ŷ��ϴ� ���ŷ�ó�� ���� ������ ���¹�ȣ�� �����ÿ�.
(��, �����-���¹�ȣ).
*/
Select prod_name ��ǰ��
From prod
Where prod_id 
            IN(Select cart_prod From cart
                Where cart_no LIKE '200504%'
                    AND cart_member
                        IN(Select mem_id From member
                            Where TO_CHAR(mem_bir, 'YY') >= '73'
                                AND mem_job = '�ֺ�'
                                AND mem_add1 LIKE '%����%'));

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
                                AND mem_job = '�ֺ�'
                                AND mem_add1 LIKE '%����%')));
                                
SELECT buyer_bank AS "�����", 
           buyer_bankno AS "���¹�ȣ"
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
                                                                                WHERE mem_add1 like '%����%' 
                                                                                AND substr(mem_regno1,1,2) >= '73'
                                                                                AND mem_job = '�ֺ�')                         
                                                             AND substr(cart_no,1,6) = '200504')
                                                       );
                                

-- ���缺
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
                            mem_add1 LIKE '%����%'
                            AND mem_job = '�ֺ�'
                            AND to_char(mem_bir, 'yy') > 73
                    )
                    AND substr(cart_no, 1, 6) = 200504
            )
    );

/*
3. ������ ������ ȸ���� �� 5���̻� ������ ȸ���� 4�����Ϸ� ������ ȸ������ ������ �������� �ٸ� ������ ������ �����̴�. 
ȸ������ ���Ű���(qty)�� ����  ������������ �����ϰ�  ȸ������ ȸ��id�� ��ȭ��ȣ(HP)�� ��ȸ�϶�.
qty 5�� �̻����� �Ͻø� �˴ϴ�.
*/
Select mem_id ȸ��ID,
        mem_hp ��ȭ��ȣ,
        (Select sum(cart_qty) From cart
            Where cart_member = member.mem_id) as TMP
From member
Order By TMP ASC;

