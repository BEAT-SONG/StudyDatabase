/*
lprod : ��ǰ�з�����
prod : ��ǰ���� / �ŷ�ó, ��ǰ�з�
buyer : �ŷ�ó���� 
member : ȸ������
cart : ����(��ٱ���)���� / ȸ��, ��ǰ
buyprod : �԰��ǰ���� / ��ǰ����
remain : ����������
*/

-- ��ǰ �з����̺��� ���� ��ǰ���̺� �����ϴ� �з��� �˻�
-- �з��ڵ�, �з���
-- IN �ȿ��� �ϳ��� �÷��� ���� ������(��)�� ��ȸ�� �� �ִ� ���·� �����Ǿ� ��
-- �������� �������
Select lprod_gu �з��ڵ�, lprod_nm �з���
From lprod
Where lprod_gu IN (Select prod_lgu From prod);

-- ��ǰ �з������Ϳ��� ���� ��ǰ���̺� �������� ���� �з��� �˻��Ͻÿ�.
-- ��Ī�� �з��ڵ�, �з���
Select lprod_gu �з��ڵ�, lprod_nm �з���
From lprod
Where lprod_gu NOT IN (Select prod_lgu From prod);

/*
[����]
�ѹ��� ������ ���� ���� ȸ��ID, �̸� ��ȸ
*/
Select mem_id ȸ��ID, mem_name ȸ���̸�
From member
Where mem_id NOT IN (Select cart_member From cart);

/*
������ ��ȸ�ϱ�
1. ���̺� ã��
2. ��ȸ�� Į�� ã��
3. ���� ���� Ȯ��
*/

/*
[����]
�ѹ��� �Ǹŵ� ���� ���� ��ǰ�� ��ȸ�Ϸ��� �Ѵ�.
�Ǹŵ� ���� ���� ��ǰ�̸��� ��ȸ���ּ���.
*/
Select prod_name ��ǰ��
From prod
Where prod_id NOT IN(Select cart_prod From cart);

/*
[����]
ȸ�� �� '������' ȸ���� ���ݱ��� �����ߴ� ��� ��ǰ���� ��ȸ���ֽÿ�.
*/
Select prod_name ��ǰ��
From prod
Where prod_id IN(Select cart_prod From cart
                        Where cart_member = 'a001');

Select prod_name ��ǰ��
From prod
Where prod_id 
    IN(Select cart_prod From cart
        Where cart_member 
            IN (Select mem_id From member
                Where mem_name = '������'));
                                                        
Select *
From member
Where mem_id = 'a001';

SELECT *
FROM CART;

-- ��ǰ �� �ǸŰ����� 10���� �̻�, 30���� ������ ��ǰ�� ��ȸ
-- ��ȸ �÷��� ��ǰ��, �ǸŰ���
-- ������ �ǸŰ����� �������� ��������
Select prod_name ��ǰ��, prod_sale ��ǰ����
From prod
Where prod_sale >= 100000
    AND prod_sale <= 300000
Order By prod_sale Desc;

Select prod_name ��ǰ��, prod_sale ��ǰ����
From prod
Where prod_sale Between 100000 AND 300000
Order By prod_sale Desc;

-- ȸ�� �� ������ 1975-01-01 ���� 1976-12-31 ���̿� �¾ ȸ���� �˻��Ͻÿ�.
-- ��Ī ȸ��ID, ȸ����, ����
Select mem_id ȸ��ID, mem_name ȸ����, mem_regno1 ����
From member
Where mem_regno1 Between 750101 AND 761231;

Select mem_id ȸ��ID, mem_name ȸ����, mem_bir ����
From member
Where mem_bir Between '75-01-01' AND '76-12-31';

Select mem_id ȸ��ID, mem_name ȸ����, mem_bir ����
From member
Where mem_bir Between '75/01/01' AND '76/12/31';

/*
[����]
�ŷ�ó ����� '������'���� ����ϴ� ��ǰ�� ������ ȸ���� ��ȸ
ȸ��ID, ȸ���̸��� ��ȸ
*/
Select mem_id ȸ��ID, mem_name ȸ���̸�
From member
Where mem_id 
    IN (Select cart_member From cart
        Where cart_prod 
            IN(Select prod_id From prod
                Where prod_buyer
                    IN(Select buyer_id From buyer
                        Where buyer_charger = '������')));


Select *
From buyer;

select * from prod;

select * from lprod;

Select mem_id ȸ��ID, mem_name ȸ���̸�
From member
Where mem_id 
    IN (Select cart_member From cart
        Where cart_prod 
            IN(Select prod_id From prod
                Where prod_lgu
                    IN(Select lprod_gu From lprod
                        Where lprod_gu
                        IN(Select buyer_lgu From buyer
                            Where buyer_charger = '������'))));

-- ��ǰ �� ���԰��� 300,000~1,500,000�̰� �ǸŰ��� 800,000~2,000,000 �� ��ǰ�� �˻��Ͻÿ�.
-- ��Ī�� ��ǰ��, ���԰�, �ǸŰ�
Select prod_name ��ǰ��, prod_cost ���԰�, prod_sale �ǸŰ�
From prod
Where prod_cost Between 300000 AND 1500000
    AND prod_sale Between 800000 AND 2000000;
    
-- ȸ�� �� ������ 1975�⵵ ���� �ƴ� ȸ���� �˻��Ͻÿ�.
-- ��Ī�� ȸ��ID, ȸ����, ����
-- ���ϰ� �ֹι�ȣ��6�ڸ��� �ٸ� �� �ִ�.
Select mem_id ȸ��ID, mem_name ȸ����, mem_bir ����
From member
Where mem_regno1 NOT Between 750101 AND 751231;

Select mem_id ȸ��ID, mem_name ȸ����, mem_bir ����
From member
Where mem_bir NOT Between '75-01-01' AND '75-12-31';

-- ȸ�����̺��� �达 ���� ���� ȸ���� �˻��Ͻÿ�.
-- ��Ī�� ȸ��ID, ����
Select mem_id ȸ��ID, mem_name ����
From member
Where mem_name Like '��%';

-- ȸ�����̺��� �ֹε�Ϲ�ȣ �������� �˻��Ͽ� 1975����� ������ ȸ���� �˻��Ͻÿ�.
-- ��Ī ȸ��ID, ����, �ֹε�Ϲ�ȣ
Select mem_id ȸ��ID, mem_name ����, mem_regno1 �ֹε�Ϲ�ȣ
From member
Where mem_regno1 NOT Like '75%';

-- CONCAT()
-- �ΰ��� ���ڿ��� ��ģ��.
Select CONCAT('My Name is ', mem_name) ����
From member;

-- CHR, ASCII
-- ASCII���� ���ڷ�, ���ڸ� ASCII������ ��ȯ
Select CHR(65) "CHR", ASCII('A') "ASCII"
From dual;

-- LOWER() = �ش� ���ڳ� ���ڿ��� �ҹ��ڷ� ��ȯ
-- UPPER() = �빮�ڷ� ��ȯ
-- INITCAP() = ù ���ڸ� �빮�ڷ� �������� �ҹ��ڷ� ��ȯ
Select LOWER('DATA mainpulation Language') "LOWER",
        UPPER('DATA mainpulation Language') "UPPER",
        INITCAP('DATA mainpulation Language') "INITCAP"
From dual;

-- ȸ�����̺��� ȸ��ID�� �빮�ڷ� ��ȯ�Ͽ� �˻��Ͻÿ�.
-- ��Ī�� ��ȯ �� ID, ��ȯ �� ID
Select mem_id ��ȯ��ID, UPPER(mem_id) ��ȯ��ID 
From member;

-- LPAD, RPAD() = ������ ���� n���� c1�� ä��� ���� ������ c2�� ä����

-- LTRIM(), RTRIM() = ����, ������ ���鹮�ڸ� ����
-- TRIM() = ������ ���鹮�� ����

-- SUBSTR( , , ) = ���ڿ��� �Ϻκ��� �����ؼ� ��ȸ

-- TRANSLATE(c1,c2,c3) = c1���ڿ��� ���Ե� ���� �� c2�� ������ ���ڰ� c3���ڷ� ���� ����

-- REPLACE() = ���ڳ� ���ڿ��� ġȯ
Select REPLACE('SQL Project', 'SQL', 'SSQQLL') ����ġȯ1,
    REPLACE('Java Flex Via', 'a') ����ġȯ2
From dual;

-- ȸ�����̺��� ȸ������ �� ���� '��' ---> '��' �� ġȯ�Ͽ� �ڿ� �̸��� ���� �� �˻��Ͻÿ�.
-- ��Ī�� ȸ����, ȸ����ġȯ
-- ��� '��' ---> '��'
Select mem_name ȸ����,
    REPLACE(mem_name, '��', '��') ȸ����ġȯ
From member;

Select mem_name ȸ����,
    CONCAT(REPLACE(SUBSTR(mem_name, 1, 1), '��', '��'), SUBSTR(mem_name, 2)) ȸ����ġȯ
From member;

Select mem_name ȸ����,
    CONCAT(REPLACE(SUBSTR(mem_name, 1, 1), '��', '��'), SUBSTR(mem_name, 2, 3)) ȸ����ġȯ
From member;

-- ROUND(n, l) = ������ �ڸ���(l) �ؿ��� �ݿø�
-- TRUNC(n, l) = ���� ����, �ݿø��� �ƴ϶� ����
-- ���� �ڸ� �� = 0 , �Ҽ��� ù°�ڸ� �� = 1 ....

-- MOD(c, n) = n���� ���� ������

-- ��¥ �Լ�
-- SYSDATE = �ý��ۿ��� �����ϴ� ���� ���ڿ� �ð� ��
-- dual = ���� ���̺� 
Select sysdate -1
From dual;

-- ADD_MONTHS(data, n) = date�� ���� ���� ��¥
-- NEXT_DAY(data, char) = �ش� ��¥ ���� ���� ���� ������ ��¥
-- LAST_DAY(date) = ���� ������ ��¥
Select NEXT_DAY(SYSDATE, '������'),
        LAST_DAY(SYSDATE)
From dual;

-- �̹����� ��ĥ �����ִ���?
Select LAST_DAY(SYSDATE) - SYSDATE �����ϼ�
From dual;

-- EXTRACT(fmf FROM data) = ��¥���� �ʿ��� �κи� ����
Select EXTRACT(YEAR FROM SYSDATE) "�⵵",
    EXTRACT(MONTH FROM SYSDATE) "��",
    EXTRACT(DAY FROM SYSDATE) "��"
From dual;

-- ������ 3���� ȸ���� �˻��Ͻÿ�.
Select mem_name ȸ����, EXTRACT(MONTH From mem_bir) ����
From member
Where EXTRACT(MONTH From mem_bir) = '3';

/*
[����]
ȸ�� ���� �� 1973����� �ַ� ������ ��ǰ�� ������������ ��ȸ
- ��ȸ �÷� : ��ǰ��
- ��, ��ǰ�� �Ｚ�� ���Ե� ��ǰ�� ��ȸ. ��ȸ ����� �ߺ� ����
*/
-- ����.. ����Բ� 
-- ���� = EXTRACT(YEAR FROM mem_bir) = 1973
Select DISTINCT prod_name ��ǰ��
From prod
Where prod_id 
    IN (Select cart_prod From cart
            Where cart_member
                IN(Select mem_id From member
                    Where mem_bir Between '73-01-01' AND '73-12-31'
                        AND prod_name LIKE '%�Ｚ%'))
Order By prod_name ASC;

Select DISTINCT prod_name ��ǰ��
From prod
Where prod_name LIKE '%�Ｚ%'  
    AND prod_id 
        IN (Select cart_prod From cart
            Where cart_member
                IN(Select mem_id From member
                    Where EXTRACT(YEAR FROM mem_bir) = 1973))
Order By prod_name ASC;

-- CAST(expr AS type) = ��������� �� ��ȯ
-- TO_CHAR() = ����, ����, ��¥�� ������ ������ ���ڿ� ��ȯ
-- TO_NUMBER() =  ���������� ���ڿ��� ���ڷ� ��ȯ
-- TO_DATE() = ��¥ ������ ���ڿ��� ��¥�� ��ȯ
Select TO_CHAR(CAST('2008-12-25' AS DATE), 'YYYY.MM.DD HH24:MI')
From dual;

Select TO_CHAR(SYSDATE, 'AD YYYY, CC "����"')
From dual;

-- ��ǰ���̺��� ��ǰ�԰����� '2008-09-28' �������� ������ �˻��Ͻÿ�
-- ��Ī = ��ǰ��, ��ǰ�ǸŰ�, �԰���
Select prod_name ��ǰ��, prod_sale ��ǰ�ǸŰ�, 
        TO_CHAR(prod_insdate, 'YYYY-MM-DD') �԰���
From prod;

-- ȸ���̸��� ���Ϸ� ����ó�� ��µǰ� �ۼ��Ͻÿ�.
-- ��������� 1976�� 1�� ����̰� �¾ ������ �����
Select CONCAT(CONCAT(mem_name, '�� ��'), TO_CHAR(mem_bir,'YYYY'))
From member;

Select (mem_name || '����' || 
        TO_CHAR(mem_bir,'YYYY') || '�� ' || 
        TO_CHAR(mem_bir,'D') ||'�� ����̰� �¾ ������ ' ||  
        TO_CHAR(mem_bir, 'day') || '�Դϴ�.'
        ) as sumStr
From member;

-- ����
-- 9�� ��ȿ�� ����, 0�� ��ȿ�� ���� = �ǹ̾��� �ڸ���
-- $, L = �޷� �� ���� ȭ�� ��ȣ
-- MI = ������ ��� ������ ���̳ʽ� ǥ��, ������ ǥ��
-- PR = ������ ��� "<>"��ȣ�� ���´�. ������ ǥ��
-- X = �ش� ���ڸ� 16������ ǥ��
Select TO_CHAR(1234.6, '999,999.00')
From dual;

Select TO_CHAR(-1234.6, 'L999,999.00PR')
From dual;

Select TO_CHAR(255, 'XXX')
From dual;

-- ��ǰ���̺��� ��ǰ�ڵ�, ��ǰ��, ���԰���, �Һ��ڰ���, �ǸŰ����� ����Ͻÿ�
-- ��, ������ õ���� ���� �� ��ȭǥ��
Select prod_id ��ǰ�ڵ�, prod_name ��ǰ��, 
        TO_CHAR(prod_cost,'L9,999,999') ���԰���, 
        TO_CHAR(prod_sale,'L9,999,999') �Һ��ڰ���, 
        TO_CHAR(prod_price,'L9,999,999') �ǸŰ���
From prod;

-- TO_NUMBER() =  ���������� ���ڿ��� ���ڷ� ��ȯ

-- ȸ�����̺��� '�̻���'ȸ���� ȸ��ID 2~4 ���ڿ��� ���������� ġȯ�� �� 10�� ���Ͽ� ���ο� ȸ��ID�� �����Ͻÿ�.
-- ��Ī = ȸ��ID, ����ȸ��ID
-- ����...

Select mem_id ȸ��ID,
        Substr(mem_id, 1, 2) ||
        (Substr(mem_id, 3, 4) + 10)
From member
Where mem_name = '�̻���';

-- ��ǰ���̺��� ��ǰ�з��� ���԰��� ��� ��
-- AVG() = �׷��Լ�
/*
[��Ģ]!!
�Ϲ� �÷��� �׷� �Լ��� ���� ����� ��쿡��
�� Group By���� �־� �־ �մϴ�.
�׸��� Group By������ �Ϲ� �÷��� ��� ���� �մϴ�.
*/
Select prod_lgu "��ǰ �з�",
        ROUND(AVG(prod_cost), 2) "���԰��� ���"
From prod
Group By prod_lgu;

Select ROUND(AVG(prod_cost), 2) "���԰��� ���"
From prod;

-- ��ǰ���̺��� �� �ǸŰ��� ��� ���� ���Ͻÿ�,
-- ��Ī = ��ǰ�ǸŰ������
Select ROUND(AVG(prod_sale), 2) "��ǰ�ǸŰ������"
From prod;

-- ��ǰ���̺��� ��ǰ�з��� �ǸŰ��� ��հ�
Select prod_lgu,  
        ROUND(AVG(prod_sale), 2) "��ǰ�ǸŰ������"
From prod
Group By prod_lgu;

Select prod_lgu,  
        AVG(prod_sale) as avg_sale
From prod
Group By prod_lgu;





