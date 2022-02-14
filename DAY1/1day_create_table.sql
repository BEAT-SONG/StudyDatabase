-- CREATE TABLE(���̺� ����)
-- ��� �����ϴ� �÷��� �ڽ��� ������ Ÿ���� ���� ���ο� ���̺��� ����
-- ���̺� �����ϱ�
CREATE TABLE lprod(
    lprod_id number(5) NOT NULL, -- ��ǰ�з��ڵ�
    lprod_gu char(4) NOT NULL, -- ��ǰ�з�
    lprod_nm VARCHAR2(40) NOT NULL, -- ��ǰ�з���
    CONSTRAINT pk_lprod PRIMARY KEY (lprod_gu) -- GU => PK
);

-- ��ȸ�ϱ�
Select  * -- ��� �÷��� �� ���� ���ڴ�
From lprod;

Select  lprod_id, lprod_gu, lprod_nm
From lprod;

-- ������ �Է��ϱ�
-- '���ڿ�', ����
-- �ѹ��� �� ���� �� �ִ� ����� ����. �ϳ��� ���� �־���� �Ѵ�.
-- ������ ����Ʈ = File�� csv ���·� ���� �� �ִ�.
Insert Into lprod (
    lprod_id, lprod_gu, lprod_nm
) Values(
    9, 'P403', '������'
);

Select  lprod_id, lprod_gu, lprod_nm
From lprod;

-- ��ǰ�з�����(TABLE)���� ��ǰ�з��ڵ�(GU)�� ���� P201�� �����͸� ��ȸ�� �ּ���.
Select *
From lprod
-- ���� �߰�
Where lprod_gu = 'P201';

Select *
From lprod
-- ���� �߰�
Where lprod_gu > 'P201'; -- ������(����)�� ���� ũ�� ��

-- ������ �����ϱ�
-- ������ ���� �� �����ÿ� Where �� �߰��ؼ� ������ ���� ������ ����ü �����Ͱ� ���� �� ������ �� �� �����Ƿ� �����ؾ���.
-- ��ǰ�з��ڵ�(GU)�� P102 ���� ��ǰ�з���(ID)�� ���� ����� ������ �ּ���.
SELECT *
FROM lprod
Where lprod_gu = 'P102';
    
Update lprod
    Set lprod_nm = '���'
Where lprod_gu = 'P102';

-- ������ �����ϱ�
-- ��ǰ�з��������� ��ǰ�з��ڵ尡 P202�� ���� �����͸� ������ �ּ���.
Select *
From lprod
Where lprod_gu = 'P202';

Delete From lprod
Where lprod_gu = 'P202';

-- Ŀ��
Commit;

-- �ŷ�ó �������̺� ����
Create Table buyer(
    buyer_id char(6) NOT NULL, -- �ŷ�ó�ڵ�
    buyer_name VARCHAR2(40) NOT NULL, -- �ŷ�ó��
    buyer_lgu char(4) NOT NULL, -- ��޻�ǰ ��з�
    buyer_bank varchar2(60), -- ����
    buyer_bankno varchar2(60), -- ���¹�ȣ
    buyer_bankname varchar2(15), -- ������
    buyer_zip char(7), -- �����ȣ
    buyer_add1 VARCHAR2(100), -- �ּ�1
    buyer_add2 VARCHAR2(70), -- �ּ�2
    buyer_comtel VARCHAR(14) NOT NULL, -- ��ȭ��ȣ
    buyer_fax VARCHAR(20) NOT NULL -- fax ��ȣ
);

-- Table ���� ����
-- ALTER
Alter Table buyer ADD(buyer_mail varchar2(60) NOT NULL,
                                buyer_charger varchar2(20),
                                buyer_telext varchar2(2) );

Alter Table buyer Modify (buyer_name VARCHAR2(60));

Alter Table buyer 
    ADD(Constraint pk_buyer PRIMARY KEY(buyer_id),
            CONSTRAINT fr_buyer_lprod FOREIGN key(buyer_lgu)
                                            REFERENCES lprod(lprod_gu)
);

-- ������� �ֽ� ���Ϸ� ���̺� ������.

/*
lprod : ��ǰ�з�����
prod : ��ǰ���� / �ŷ�ó, ��ǰ�з�
buyer : �ŷ�ó���� 
member : ȸ������
cart : ����(��ٱ���)���� / ȸ��, ��ǰ
buyprod : �Ӱ��ǰ���� / ��ǰ����
remain : ����������
*/

-- ����
-- 1. ���̺� ã��
-- 2. ������ �ִ���?
-- 3. � �÷��� ����ϴ���?

-- ȸ�� ���̺���� ȸ�� ID�� ������ �˻��Ͻÿ�.
Select mem_id, mem_name
From member;

-- ��ǰ ���̺�κ��� ��ǰ�ڵ�� ��ǰ���� �˻��Ͻÿ�.
Select prod_id, prod_name
From prod;

-- ȸ�� ���̺��� ���ϸ����� 12�� ���� ���� �˻��Ͻÿ�.
-- ��Ī(�˸��ƽ�) = () as 000
Select mem_mileage, (mem_mileage/12) as mem_12
From member;

-- ��ǰ ���̺��� ��ǰ�ڵ�, ��ǰ��, �Ǹűݾ��� �˻��Ͻÿ�
-- �Ǹűݾ� = �ǸŴܰ�*55 �� ����Ѵ�
SELECT * 
FROM prod;

Select prod_id, prod_name, (prod_sale*55) as prod_sale
From prod;

-- �ߺ��� ROW(������) ���Ź�
-- Distinct

-- ��ǰ ���̺��� �ŷ�ó �ڵ带 �ߺ����� �ʰ� �˻��Ͻÿ�.
Select *
From prod;

Select prod_buyer
From prod;

Select Distinct prod_buyer
From prod;

-- ������ ����
-- Order By
-- ��Ī�� ����� �� ����
-- ȸ�� ���̺��� ȸ�� ID, ȸ����, ����, ���ϸ��� �˻�
-- Asc ��������
-- Desc ��������
Select mem_id, mem_name, mem_bir, mem_mileage
From member
Order By mem_id Asc;

Select mem_id as id, 
         mem_name as name, 
         mem_bir as bir, 
         mem_mileage
From member
Order By id Asc;

Select mem_id as id, 
         mem_name as name, 
         mem_bir as bir, 
         mem_mileage
From member
Order By 3 Asc;

Select mem_id as id, 
         mem_name as name, 
         mem_bir as bir, 
         mem_mileage
From member
Order By mem_mileage, 1 Asc;

-- Where ��
-- True or False
-- ��ǰ �� �ǸŰ��� 170,000���� ��ǰ ��ȸ
Select prod_name ��ǰ, prod_sale �ǸŰ�
From prod
Where prod_sale = 170000;

-- ��ǰ �ǸŰ����� 170,000���� �ƴ� ��ǰ ID�� ��ǰ���� ��ȸ
Select *
From prod;

Select prod_id ��ǰID, prod_name ��ǰ��
From prod
Where prod_sale != 170000;

-- ��ǰ �߿� ���԰����� 200,000�� ������ ��ǰ �˻�
-- ��, ��ǰ�ڵ带 �������� ��������
-- ��ȸ �÷��� ��ǰ ID, ���԰���, ��ǰ��
Select prod_id ��ǰ�ڵ�, prod_name ��ǰ��, prod_cost ���԰���
From prod
Where prod_cost <= 200000
Order By prod_id Desc;

-- ȸ�� �߿� 76�⵵ 1�� 1�� ���Ŀ� �¾
-- ȸ��ID, ȸ���̸�, �ֹε�Ϲ�ȣ ���ڸ� ��ȸ
-- ��, ȸ�����̵� ���� ��������
Select *
From member;

Select mem_id ȸ��ID, mem_name ȸ���̸�, mem_regno1 �ֹε�Ϲ�ȣ_���ڸ�
From member
Where mem_regno1 >= 760101
Order By mem_id Asc;

-- ��ǰ �� ��ǰ�з��� P201(����ĳ���)�̰� �ǸŰ��� 170,000���� ��ǰ ��ȸ
Select prod_name ��ǰ��, prod_lgu ��ǰ�ڵ�, prod_sale �ǸŰ�
From prod
Where prod_lgu = 'P201'
    AND prod_sale = 170000;

-- ��ǰ �� ��ǰ�з��� P201(����ĳ���)�̰ų� �ǸŰ��� 170,000���� ��ǰ ��ȸ
Select prod_name ��ǰ��, prod_lgu ��ǰ�ڵ�, prod_sale �ǸŰ�
From prod
Where prod_lgu = 'P201'
    OR prod_sale = 170000;

-- ��ǰ �� ��ǰ�з��� P201(����ĳ���)�� �ƴϰ� �ǸŰ��� 170,000���� �ƴ� ��ǰ ��ȸ
Select prod_name ��ǰ��, prod_lgu ��ǰ�ڵ�, prod_sale �ǸŰ�
From prod
Where prod_lgu != 'P201'
    AND prod_sale != 170000;

-- ��ǰ �� �ǸŰ��� 300,000�� �̻�, 500,000�� ������ ��ǰ�� �˻�
-- Alias(��Ī) �� ��ǰ�ڵ�, ��ǰ��, �ǸŰ�
Select prod_id ��ǰ�ڵ�, prod_name ��ǰ��, prod_sale �ǸŰ�
From prod
Where prod_sale >= 300000 
    AND prod_sale <= 500000;
    
-- ��ǰ �߿� �ǸŰ����� 150,000��, 170,000��, 330,000���� ��ǰ���� ��ȸ
-- ��ǰ�ڵ�, ��ǰ��, �ǸŰ��� ��ȸ
-- ������ ��ǰ���� �������� ��������
Select prod_id ��ǰ�ڵ�, prod_name ��ǰ��, prod_sale �ǸŰ���
From prod
Where prod_sale = 150000
    OR prod_sale = 170000
    OR prod_sale = 330000
Order By prod_id Asc;

-- ȸ�� �߿� ���̵� C001, F001, W001�� ȸ�� ��ȸ
-- ȸ��ID, ȸ���̸� ��ȸ
-- ������ �ֹι�ȣ ���ڸ��� �������� ��������
Select mem_id ȸ��ID, mem_name ȸ���̸�
From member
Where mem_id = 'c001'
    OR mem_id = 'f001'
    OR mem_id = 'w001'
Order By mem_regno1 Desc;












