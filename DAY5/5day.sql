/*
[����]
��ǰ�з���, ��ǰ��, ��ǰ����, ���Լ���, �ֹ�����, �ŷ�ó���� ��ȸ
��, ��ǰ�ڵ尡 P101, P201, P301�� �͵鿡 ���� ��ȸ
���Լ����� 15�� �̻�
���￡ ��� �ִ� ȸ�� �� ������ 1974����� ����鿡 ���� ��ȸ
������ ȸ�����̵� �������� ��������, ���Լ����� �������� ��������
*/
-- [�Ϲݹ��]
Select prod_lgu ��ǰ�з���,
        prod_name ��ǰ��,
        prod_color ��ǰ����,
        buy_qty ���Լ���,
        cart_qty �ֹ�����,
        buyer_name �ŷ�ó��
        -- ,mem_add1, mem_bir, mem_id
From prod, buyprod, cart, member, buyer
Where prod_lgu LIKE '%01'
        AND prod_id = buy_prod
        AND buy_qty >= '15'
            AND prod_id = cart_prod
                AND cart_member = mem_id
                AND mem_add1 LIKE '%����%'
                AND TO_CHAR(mem_bir, 'YY') = '74'
                    AND prod_buyer = buyer_id
Order By mem_id DESC, buy_qty DESC;

-- [ANSI ����ǥ�ع��]
-- ON() �� �������ִ� ������� ���� ���� �Ϲ������� ���� ���� ����. 
Select prod_lgu ��ǰ�з���,
        prod_name ��ǰ��,
        prod_color ��ǰ����,
        buy_qty ���Լ���,
        cart_qty �ֹ�����,
        buyer_name �ŷ�ó��
        , mem_add1, mem_bir, mem_id
From prod Inner join buyprod
                ON(prod_lgu LIKE '%01'
                    AND buy_qty >= '15'
                    AND prod_id = buy_prod)
                Inner join cart
                    ON(prod_id = cart_prod)
                Inner join member
                    ON(cart_member = mem_id
                         AND mem_add1 LIKE '%����%'
                          AND TO_CHAR(mem_bir, 'YY') = '74')
                Inner join buyer
                    ON(prod_buyer = buyer_id)
Order By mem_id DESC, buy_qty DESC
;

-- OUTER JOIN
-- ���� ���� �͵� ��ȸ�ϰ� ���� �� ���
-- ����ǥ�ع���� ����ؾ� �Ѵ�. ���α׷����� �Ϲݹ���� �ٸ���.
-- (+) = ���ο��� ������ �ʿ� (+) ������ ��ȣ�� ����Ѵ�.

-- ��ü �з��� ��ǰ�ڷ� ���� �˻� ��ȸ
-- ��Ī = �з��ڵ�, �з���, ��ǰ�ڷ��

-- 1. �з����̺� ��ȸ
Select *
From lprod;

-- 2. �Ϲ� join
Select lprod_gu �з��ڵ�,
        lprod_nm �з���,
        COUNT(prod_lgu) ��ǰ�ڷ��
From lprod, prod
Where lprod_gu = prod_lgu
Group by lprod_gu, lprod_nm;

-- 3. outer join ��� Ȯ��
Select lprod_gu �з��ڵ�,
        lprod_nm �з���,
        COUNT(prod_lgu) ��ǰ�ڷ��
From lprod, prod
Where lprod_gu = prod_lgu (+)
Group by lprod_gu, lprod_nm
Order By lprod_gu;

-- 4. ANSI outer join ��� Ȯ��
Select lprod_gu �з��ڵ�,
        lprod_nm �з���,
        COUNT(prod_lgu) ��ǰ�ڷ��
From lprod LEFT OUTER JOIN prod
                ON(lprod_gu = prod_lgu)
Group by lprod_gu, lprod_nm
Order By lprod_gu;

-- ��ü��ǰ�� 2005�� 1�� �԰������ �˻� ��ȸ
-- ��Ī = ��ǰ�ڵ�, ��ǰ��, �԰����
--[�Ϲ� JOIN]
Select prod_id ��ǰ�ڵ�,
        prod_name ��ǰ��,
        SUM(buy_qty) �԰����
From prod, buyprod
Where prod_id = buy_prod
    AND buy_date BETWEEN '2005-01-01' AND '2005-01-31'
Group By prod_id, prod_name;

-- [outer join]
-- ������ ���� �Ϲݹ������ outer join�� ����ϸ� �ȵȴ�.
Select prod_id ��ǰ�ڵ�,
        prod_name ��ǰ��,
        SUM(buy_qty) �԰����
From prod, buyprod
Where prod_id = buy_prod (+)
    AND buy_date BETWEEN '2005-01-01' AND '2005-01-31' -- �� ������ �����鼭 ���͸��Ǿ� outer join�� �ǹ̰� �����. ��� ����ǥ�ع������ ������ �����ؾ���.
Group By prod_id, prod_name
Order By prod_id, prod_name;

-- [����ǥ�ع�� outer join]
-- Where ���� ������� �ʰ� ���ϴ� ������ ON�� ����.
Select prod_id ��ǰ�ڵ�,
        prod_name ��ǰ��,
        SUM(buy_qty) �԰����
From prod LEFT OUTER JOIN buyprod
                ON(prod_id = buy_prod
                    AND buy_date BETWEEN '2005-01-01' AND '2005-01-31')
Group By prod_id, prod_name
Order By prod_id, prod_name;

-- NULL �� ����(ó��)
-- NVL() 
Select prod_id ��ǰ�ڵ�,
        prod_name ��ǰ��,
        SUM(NVL(buy_qty, 0)) �԰����
From prod LEFT OUTER JOIN buyprod
                ON(prod_id = buy_prod
                    AND buy_date BETWEEN '2005-01-01' AND '2005-01-31')
Group By prod_id, prod_name
Order By prod_id, prod_name;

-- ��ü ȸ���� 2005�⵵ 4���� ������Ȳ ��ȸ
-- ȸ��ID, ����, ���ż����� ��
Select mem_id ȸ��ID, 
        mem_name ����,
        SUM(NVL(cart_qty,0)) ���ż�����
From member LEFT OUTER JOIN cart
                        ON(mem_id = cart_member
                            AND SUBSTR(cart_no, 1, 6) = '200504')
Group By mem_id, mem_name
Order By mem_id, mem_name;

-- 2005�⵵ ���� ���� ��Ȳ�� �˻�
-- ��Ī = ���Կ�, ���Լ���, ���Աݾ�(���Լ���*��ǰ���̺��� ���԰�)
Select TO_CHAR(buy_date , 'mm' ) ���Կ�,
        SUM(buy_qty) ���Լ���,
        TO_CHAR(SUM(buy_qty*prod_cost), 'L9,999,999,999,999') ���Աݾ�
From buyprod, prod 
    Where buy_prod = prod_id
        AND EXTRACT(YEAR From buy_date) = 2005 
Group By TO_CHAR(buy_date , 'mm' )
Order By ���Կ� ASC;

-- 2005�⵵ ���� �Ǹ� ��Ȳ�� �˻�
-- ��Ī = �Ǹſ�, �Ǹż���, �Ǹűݾ�(�Ǹż���*��ǰ���̺��� �ǸŰ�)
Select SUBSTR(cart_no, 5, 2) �Ǹſ�,
        SUM(cart_qty) �Ǹż���,
        SUM(cart_qty * prod_sale) �Ǹűݾ�        
From cart, prod
Where cart_prod = prod_id
    AND SUBSTR(cart_no, 1, 4) = '2005'
Group By SUBSTR(cart_no, 5, 2)
Order By SUBSTR(cart_no, 5, 2) ;

-- ��������
-- Select ���� Select ���� ����.
-- From ���� Select ���� ������ �ϳ��� ���̺��� �ִµа� �̶�� �����ϸ� ��.

-- ��ǰ�з��� ��ǻ����ǰ(P101)�� ��ǰ�� 2005�⵵ ���ں� �Ǹ� ��ȸ
-- ��Ī = �Ǹ���, �Ǹűݾ�(5,000,000�ʰ��� ��츸), �Ǹż���
-- HAVING�� �̿��Ͽ� �ش� ��ȸ
Select SUBSTR(cart_no, 5, 4) �Ǹ���,
        SUM(prod_sale * cart_qty) �Ǹűݾ�,
        SUM(cart_qty) �Ǹż���
From prod, cart
Where prod_id = cart_prod
    AND prod_lgu = 'P101'
    AND SUBSTR(cart_no, 1, 4) = '2005'
Group By SUBSTR(cart_no, 5, 4)
HAVING SUM(prod_sale * cart_qty) >= '5000000'
Order By SUBSTR(cart_no, 5, 4)
;

-- ��������
-- �������
-- ������ �ؾ���..
-- Select () = �ϳ��� �÷��� �ϳ��� ���� ������ ���������Ѵ�.
-- From () = n���� �÷��� n���� ���� ������ ���������Ѵ�.
-- �񱳿����� = �ϳ��� �÷��� �ϳ��� ���� ������ ���������Ѵ�.
-- IN() = �ϳ��� �÷��� n���� ��(��)
-- EXIST() = n���� �÷��� n���� ���� ������ ���������Ѵ�.

-- ANL�� OR�� ����, � ���̶� ������ TRUE
-- ALL�� AND�� ����, ��� �����ؾ߸� TRUE
-- �����÷��� ������
-- �������������� ����� ����










