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


