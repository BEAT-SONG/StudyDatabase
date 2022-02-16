-- AVG() = ��ȸ ���� �� �ش� �÷����� ��հ�
-- DISTINCT() = �ߺ��� ���� ����
-- �÷��� = NULL���� ����
-- * = NULL���� ����(COUNT �Լ��� ���), ���� ������ Ȯ��
-- NULL�� ������ �ϸ� ������� NULL�� ����

Select COUNT(prod_cost)
From prod;

Select COUNT(DISTINCT(prod_cost))
From prod;

/*
[����]
���ų���(��ٱ���) �������� ȸ�����̵𺰷� �ֹ�(����)�� ���� ����� ��ȸ
ȸ�����̵� �������� ��������
*/
Select cart_member ȸ��ID, ROUND(AVG(cart_qty) , 2)
From cart
Group By cart_member
Order By cart_member DESC
;

Select cart_member ȸ��ID, AVG(cart_qty) as avg_qty
From cart
Group By cart_member
Order By cart_member DESC
;

/*
[����]
��ǰ�������� �ǸŰ����� ��հ��� �����ּ���.
��հ��� �Ҽ��� 2°�ڸ����� ǥ���� �ּ���.
*/
Select ROUND(AVG(prod_sale), 2) as avg_sale
From prod;

Select prod_name ��ǰ��, ROUND(AVG(prod_sale), 2) as avg_sale
From prod
Group By prod_name;

/*
[����]
��ǰ�������� ��ǰ�з��� �ǸŰ����� ��հ��� ���Ͻÿ�,
��ȸ�÷��� ��ǰ�з��ڵ�, ��ǰ�з��� �ǸŰ����� ���
��հ��� �Ҽ��� ��°�ڸ����� ǥ��
*/
Select prod_lgu ��ǰ�з��ڵ�, ROUND(AVG(prod_sale), 2) AS "��ǰ�з��� �ǸŰ���"
From prod
Group By prod_lgu;

-- ȸ�����̺��� ��� �������� COUNT �����Ͻÿ�
Select COUNT(DISTINCT mem_like)
From member;

-- ȸ�����̺��� ��̺� COUNT �����Ͻÿ�.
-- ��Ī = ���, �ڷ��, �ڷ��(*)
Select mem_like ���, COUNT(mem_like) �ڷ��, COUNT(*) "�ڷ��(*)"
From member
Group By mem_like;

Select mem_like ���, COUNT(mem_like) �ڷ��
From member
Group By mem_like;

-- ȸ�����̺��� ������������ COUNT �Ͻÿ�
-- ����������
Select COUNT(DISTINCT(mem_job))
From member;

Select mem_job, COUNT(mem_job) as cnt_job
From member
Group By mem_job
Order By cnt_job DESC
;

/*
[����]
ȸ�� ��ü�� ���ϸ��� ��պ��� ū ȸ���� ���� -- �Ϲ�����
���̵�, �̸�, ���ϸ����� ��ȸ
������ ���ϸ����� ���� ������
*/
Select mem_id ȸ��ID, mem_name ȸ����, mem_mileage ���ϸ���
From member
Where mem_mileage >= (Select AVG(mem_mileage) From member) -- ��ȣ ���� ���� �ϳ��� �Ǿ�� �Ѵ�.
Order By mem_mileage DESC;

Select mem_id ȸ��ID, mem_name ȸ����, mem_mileage ���ϸ���
From member
Order By mem_mileage DESC;

-- MAX()
-- MIN()

-- ������ 2000�⵵ 7�� 11���̶�� �����ϰ� ��ٱ������̺� �߻��� �߰��ֹ���ȣ�� �˻��Ͻÿ�
-- ��Ī = �������� �������� ���� ���� �ֹ���ȣ, �߰��ֹ���ȣ)
-- �������� ����� �����Ѵ�! ��, ������ �ܼ��ؾ� �ӵ��� ������ ����!!!!
Select ('200507110000' || MAX((SUBSTR(cart_no,9)))) AS "�������� �������� ���� ���� �ֹ���ȣ" , 
        ('200507110000' || MAX((SUBSTR(cart_no,9))) + 1) AS "�߰��ֹ���ȣ"
From cart
Where SUBSTR(cart_no,1, 8) = 20050711
;

-- �Ϳ� ��ϲ�, �����
SELECT MAX(cart_no), MAX(cart_no)+1 
FROM cart
Where cart_no LIKE '20050711%';

Select *
From cart
;

/*
[����]
������������ �⵵���� �Ǹŵ� ��ǰ�� ����, ��ձ��ż����� ��ȸ
������ �⵵�� �������� ��������
*/
-- �����͸� ��ȸ�Ҷ� 1���� ������ �ϳ��� �� ������ �������� ������ �����ϸ� �ȴ�. (��������)
-- Group �Լ� = SUM, AVG, MAX, MIN �Լ��̴�.
-- �׷��Լ� ���� �Ϲ��Լ��� Select�� ������ Group By�� �̿��ؼ� �Ϲ��Լ��� �׷�ȭ ������Ѵ�.
Select SUBSTR(cart_no, 1,4) �⵵, SUM(cart_qty) �ǸŵȻ�ǰ����, AVG(cart_qty) ��ձ��ż���
From cart
Group By SUBSTR(cart_no, 1,4)
Order By SUBSTR(cart_no, 1,4) DESC
;

-- �޺� ����
Select SUBSTR(cart_no, 1,6) �⵵��, SUM(cart_qty) �ǸŵȻ�ǰ����, ROUND(AVG(cart_qty), 2) AS ��ձ��ż���
From cart
Group By SUBSTR(cart_no, 1,6)
Order By SUBSTR(cart_no, 1,6) DESC
;

Select SUBSTR(cart_no, 1,6)
From cart;

/*
[����]
������������ �⵵��, ��ǰ�з��ڵ庰�� ��ǰ�� ����(COUNT)�� ��ȸ
������ �⵵�� �������� ��������
*/
Select SUBSTR(cart_no, 1, 4) �⵵, SUBSTR(cart_prod, 1, 4) ��ǰ�з��ڵ�, COUNT(cart_qty) ��ǰ����
From cart
Group By SUBSTR(cart_no, 1, 4), SUBSTR(cart_prod, 1, 4)
Order By SUBSTR(cart_prod, 1, 4) DESC;

-- ȸ�����̺��� ȸ����ü�� ���ϸ��� ���, ���ϸ��� �հ�, �ְ� ���ϸ���, �ּҸ��ϸ���, �ο����� �˻��Ͻÿ�
-- ��Ī = ���ϸ������, ���ϸ����հ�, �ְ��ϸ���, �ּҸ��ϸ���, �ο���
Select ROUND(AVG(mem_mileage), 2) AS ���ϸ������, 
        SUM(mem_mileage) ���ϸ����հ�, 
        MAX(mem_mileage) �ְ��ϸ���, 
        MIN(mem_mileage) �ּҸ��ϸ���, 
        COUNT(mem_id) �ο���
From member;

/*
[����]
��ǰ���̺��� ��ǰ�з��� �ǸŰ� ��ü�� ���, �հ�, �ְ�, ������, �ڷ���� �˻�
��Ī = ���, �հ�, �ְ�, ������, �ڷ��
�ڷ���� 20�� �̻��ΰ� ��ȸ
*/
Select prod_lgu ��ǰ�з�, 
        ROUND(AVG(prod_sale), 2) AS ���, 
        SUM(prod_sale) �հ�,
        MAX(prod_sale) �ְ�,
        MIN(prod_sale) �ּҰ�,
        COUNT(prod_sale) �ڷ��
From prod
Group By prod_lgu
HAVING COUNT(prod_sale) >= 20 -- �׷�ȭ�� �ϰ�/�׷��Լ��� ������ �ְ� ���� ���� HAVING() �Լ� ���
Order By COUNT(prod_sale) DESC;

-- Where �� : �Ϲ����Ǹ� ���
-- HAVING �� : �׷����Ǹ� ��� (�׷��Լ��� ����� ����ó��)

-- ȸ�����̺��� ����(�ּ�1�� 2�ڸ�), ���ϳ⵵���� ���ϸ������, �հ�, �ְ�, �ּ�, �ڷ���� �˻�
-- ��Ī = ����, ���Ͽ���, ���ϸ������,  �հ�, �ְ�, �ּ�, �ڷ��
-- �ڷ�� ������������
Select SUBSTR(mem_add1, 1, 2) ����,
        SUBSTR(mem_bir, 1, 2) ���Ͽ���,
        ROUND(AVG(mem_mileage), 2) ���ϸ������,
        SUM(mem_mileage) ���ϸ����հ�,
        MAX(mem_mileage) �ְ��ϸ���,
        MIN(mem_mileage) �ּҸ��ϸ���,
        COUNT(mem_mileage) �ڷ��
From member
Group By SUBSTR(mem_add1, 1, 2), SUBSTR(mem_bir, 1, 2)
Order By COUNT(mem_mileage) DESC;
 
-- NULLó��
-- NULL ���� 0, 1�� ���� Ư���� ���� �ƴϰ� �ƹ��͵� ���� ���� �ǹ�

-- NULLó���� ���ؼ� NULL�� �߰�
-- �ŷ�ó ����� ������ '��'�̸� NULL�� ����
UPDATE buyer SET  buyer_charger = NULL
Where buyer_charger LIKE '��%';

-- �ŷ�ó ����� ������ '��'�̸� White Space�� ����
-- ''�� ��������� �ν�
-- �����ʹ� ������ �޸𸮸� ����
UPDATE buyer SET  buyer_charger = ''
Where buyer_charger LIKE '��%';

-- Ȯ��
-- �ŷ�ó ����� ������ '��'�̸� NULL�� ���ŵǾ����Ƿ� ��ȸ�� ���� �ʴ´�.
Select buyer_name �ŷ�ó, buyer_charger �����
From buyer
Where buyer_charger LIKE '��%';

-- �ŷ�ó ����� ������ '��'�̸� White Space�� ���ŵǾ����Ƿ� ��ȸ�� ���� �ʴ´�.
Select buyer_name �ŷ�ó, buyer_charger �����
From buyer
Where buyer_charger LIKE '��%';

-- NVL(,)
-- IS NULL : Where������ ��� ����.
-- NULLIF(,)

--NULL�� �̿� NULL�� ��
Select buyer_name �ŷ�ó, buyer_charger �����
From buyer
Where buyer_charger = NULL;

-- IS NULL�� �̿� NULL�� ��
Select buyer_name �ŷ�ó, buyer_charger �����
From buyer
Where buyer_charger IS NULL;

Select buyer_name �ŷ�ó, buyer_charger �����
From buyer
Where buyer_charger IS NOT NULL;

-- �ش��÷��� NULL�� ��� ����� ���ڳ� ���� ġȯ
-- NULL�� �����ϴ� ���·� ��ȸ
Select buyer_name �ŷ�ó, buyer_charger �����
From buyer;

-- NVL�� �̿� NULL���� ��� '����'�� ġȯ
Select buyer_name �ŷ�ó, NVL(buyer_charger, '����') AS �����
From buyer;

-- ȸ�� ���ϸ����� 100�� ���� ��ġ�� �˻��Ͻÿ�
-- NVL ���
-- ��Ī�� ����, ���ϸ���, ���渶�ϸ���
Select mem_name ����, mem_mileage ���ϸ���, NVL(mem_mileage, 0) + '100' "���渶�ϸ���"
From member;

-- �����
Select mem_name ����, mem_mileage ���ϸ���, mem_mileage + '100' "���渶�ϸ���"
From member;

-- ȸ�����ϸ����� ������ '����ȸ��', NULL�̸� '������ȸ��'���� �˻��Ͻÿ�.
-- NVL2 ���. ��Ī = ����, ���ϸ���, ȸ������
Select mem_name ����, mem_mileage ���ϸ���, NVL2(mem_mileage, '����ȸ��', '������ȸ��') "ȸ������"
From member;

-- DECODE() = IF���� ���� ����� ��
Select DECODE(SUBSTR(prod_lgu, 1, 2),
                    'P1', '��ǻ��/���� ��ǰ',
                    'P2', '�Ƿ�',
                    'P3', '��ȭ', '��Ÿ')
From prod;

-- DECODE('������ �Ǵ� ��', '2', '3', ...'')
-- '������ �Ǵ� ��' �ں��� 2���� ��� ���ʿ� �ִ� ���� ���� ���� '������ �Ǵ� ��'�� ������ �����ʿ� �ִ� ���� ���
-- �������� �ϳ��� ������ ���� ������ �� �ƴϸ� ��� (else�� ����)

-- ��ǰ�з��� ���� �� ���ڰ� 'P1'�̸� �ǸŰ��� 10%�� �λ��ϰ� 'P2'�̸� �ǸŰ��� 15%�λ��ϰ� �������� ���� �ǸŰ��� �˻�
-- DECODE �Լ� ���
-- ��Ī = ��ǰ��, �ǸŰ�, �����ǸŰ�
Select prod_name ��ǰ��, 
        prod_sale �ǸŰ�, 
        DECODE(SUBSTR(prod_lgu, 1,2),
                    'P1', prod_sale*1.10,
                    'P2', prod_sale*1.15, prod_sale) AS "�����ǸŰ�"
From prod;

-- CASE WHEN THEN 
-- ELSE END RESULT

-- CASE WHEN THEN 
-- ELSE END

-- ȸ���������̺��� �ֹε�� ���ڸ�(7�ڸ��� ù��°)���� ���� ������ �˻�
-- CASE ���� ���
-- ��Ī = ȸ����, �ֹε�Ϲ�ȣ(�ֹ�1, �ֹ�2), ����
Select mem_name ȸ����, 
        SUBSTR(mem_regno2,1,1) �ֹε�Ϲ�ȣ, 
        CASE WHEN SUBSTR(mem_regno2,1,1) = '1' THEN '����'
                WHEN SUBSTR(mem_regno2,1,1) = '2' THEN '����' 
                END "����"   
From member;

Select mem_name ȸ����, 
        SUBSTR(mem_regno2,1,1) �ֹε�Ϲ�ȣ, 
        CASE WHEN SUBSTR(mem_regno2,1,1) = '1' THEN '����'
                ELSE '����' 
                END "����"   
From member;










