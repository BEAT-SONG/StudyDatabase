/*
[����]
ȸ������ �߿� ���ų����� �ִ� ȸ���� ���� 
ȸ�����̵�, ȸ���̸�, ����(0000-00-00 ����)�� ��ȸ�� �ּ���
������ ������ �������� ��������
*/
Select mem_id ȸ��ID, mem_name ȸ���̸�, TO_CHAR(mem_bir, 'YYYY-MM-DD') ����
From member
Where mem_id 
    IN(Select cart_member From cart) 
Order By mem_bir ASC;

-- TO_CHAR() = ����, ����, ��¥�� ������ ������ ���ڿ� ��ȯ
-- ��������
-- EXISTS() = IN()�� �´��� �ʸ´��� Ȯ�� = ���� ������ TRUE ������ FALSE
-- �ӵ��� �Ʒ� ������ ������.
-- IN�� 2�� / EXISTS�� 1�� ����.
Select prod_id, prod_name, prod_lgu
From prod
Where prod_lgu
    IN(Select lprod_gu From lprod
        Where lprod_nm ='������ȭ')
;

Select prod_id, prod_name, prod_lgu
From prod
Where 
    EXISTS(Select lprod_gu From lprod
                    Where lprod_gu = prod.prod_lgu
                        AND lprod_gu = 'P301')
;

-- TABLE JOIN
-- RDB�� �ٽ�
-- ������ DB�� ���� ū ������ ���� TABLE�� JOIN�Ͽ� ���ϴ� ����� �����ϴµ� �ִ�.
-- Equi Join = �̳����� = �Ϲ����� ����

-- <ANSI JOIN>
-- Cross join
-- Inner join
-- Outer join = left / right = �м��� ���� �����.

-- Cross join = �������� ���¸� �˱� ���ؼ� �� = ��� ��, ��� �÷��� ��ȸ�� = �ټ����� ���̺�κ��� ���յ� ����� �߻� (n*m)
Select *
From lprod, prod; -- cross join

Select COUNT(*) -- count
From lprod, prod; -- cross join

Select *
From lprod, prod, buyer;

Select COUNT(*)
From lprod, prod, buyer;

-- Cross join
-- [�Ϲݹ��]
Select m.mem_id, c.cart_member, p.prod_id
From member m, cart c, lprod l, prod p, buyer b; -- ��Ī�� ���϶� AS�� ����ϸ� �ȵ�.

Select COUNT(*)
From member m, cart c, lprod l, prod p, buyer b;

-- [ANSI ����ǥ�ع��]
-- �̸� �״�θ� ���
Select *
From member Cross join cart 
                    Cross join prod 
                    Cross join lprod
                    Cross join buyer;

-- Equi - join (Simple join) (Inner join)
-- n���� ���̺��� join�Ҷ����� �ּ��� n-1�� �̻��� ���ǽ��� �ʿ��ϴ�.

-- ��ǰ���̺��� ��ǰ�ڵ�, ��ǰ��, �з����� ��ȸ
-- ��ǰ���̺� : prod
-- �з����̺� : lprod
-- [�Ϲݹ��]
-- �Ϲ������� Select�� ���� ���̺��� ���� ���� ���� ����
Select p.prod_id ��ǰ�ڵ�,
        p.prod_name ��ǰ��,
        l.lprod_nm �з���
From prod p, lprod l -- n = 2
-- �������ǽ��� ���� ���� �ۼ��ؾ���.
Where p.prod_lgu = l.lprod_gu; -- n-1 = 1 / �������ֱ�

-- [ANSI ����ǥ�ع��]
Select p.prod_id ��ǰ�ڵ�,
        p.prod_name ��ǰ��,
        l.lprod_nm �з���
From prod p Inner join lprod l
                    on(p.prod_lgu = l.lprod_gu); -- ���������� �ۼ�, �Ϲ����ǵ� �ۼ��� �� �ִ�.
                    
-- ��Ī�� ����ϴ� ���
Select A.prod_id ��ǰ�ڵ�,
        A.prod_name ��ǰ��,
        B.lprod_nm �з���,
        C.buyer_name �ŷ�ó��
From prod A, lprod B, buyer C -- From ������ AS �� ����ϸ� �ȵȴ�.
Where A.prod_lgu = B.lprod_gu
    AND A.prod_buyer = C.buyer_id;

-- [ANSI ����ǥ�ع��]
Select A.prod_id ��ǰ�ڵ�,
        A.prod_name ��ǰ��,
        B.lprod_nm �з���,
        C.buyer_name �ŷ�ó��
From prod A Inner join lprod B
                    ON (A.prod_lgu = B.lprod_gu)
                Inner join buyer C
                    ON (A.prod_buyer = C.buyer_id) ;
                    
/*
[����]
ȸ���� ������ �ŷ�ó ������ ��ȸ
ȸ�����̵�, ȸ���̸�, ��ǰ�ŷ�ó��, ��ǰ�з����� ��ȸ
*/
/*
<����>
1. ����� ���̺� = member, cart, prod buyer, lprod
2. ��ȸ�� �÷� = mem_id, mem_name, buyer_name, lprod_nm
3. ��������
mem_id = cart_member
cart_prod = prod_id
prod_buyer = buyer_id
prod_lgu = lprod_gu
4. �Ϲ����� = ����
*/
-- [�Ϲݹ��]
Select M.mem_id ȸ��ID,
        M.mem_name ȸ���̸�,
        B.buyer_name ��ǰ�ŷ�ó��,
        L.lprod_nm ��ǰ�з���
From member M, cart C, prod P, buyer B, lprod L
    Where M.mem_id = C.cart_member
        AND C.cart_prod = P.prod_id
        AND P.prod_buyer = B.buyer_id
        AND P.prod_lgu = L.lprod_gu;

-- �ٸ� ����        
Select M.mem_id ȸ��ID,
        M.mem_name ȸ���̸�,
        B.buyer_name ��ǰ�ŷ�ó��,
        L.lprod_nm ��ǰ�з���
From member M, cart C, prod P, buyer B, lprod L
    Where M.mem_id = C.cart_member
        AND C.cart_prod = P.prod_id
        AND P.prod_buyer = B.buyer_id
        AND B.buyer_lgu = L.lprod_gu;

-- �ٸ� ����        
Select M.mem_id ȸ��ID,
        M.mem_name ȸ���̸�,
        B.buyer_name ��ǰ�ŷ�ó��,
        L.lprod_nm ��ǰ�з���
From member M, cart C, prod P, buyer B, lprod L
    Where M.mem_id = C.cart_member
        AND C.cart_prod = P.prod_id
        AND P.prod_lgu = L.lprod_gu
        AND P.prod_buyer = B.buyer_id;

-- [ANSI ����ǥ�ع��]
Select M.mem_id ȸ��ID,
        M.mem_name ȸ���̸�,
        B.buyer_name ��ǰ�ŷ�ó��,
        L.lprod_nm ��ǰ�з���
From member M Inner join cart C
                    ON(M.mem_id = C.cart_member)
                        Inner join prod P
                    ON(C.cart_prod = P.prod_id)
                        Inner join buyer B
                    ON(P.prod_buyer = B.buyer_id)
                        Inner join lprod L
                    ON(P.prod_lgu = L.lprod_gu);

-- �ٸ� ����
Select M.mem_id ȸ��ID,
        M.mem_name ȸ���̸�,
        B.buyer_name ��ǰ�ŷ�ó��,
        L.lprod_nm ��ǰ�з���
From member M Inner join cart C
                    ON(M.mem_id = C.cart_member)
                        Inner join prod P
                    ON(C.cart_prod = P.prod_id)
                        Inner join lprod L
                    ON(P.prod_lgu = L.lprod_gu)
                        Inner join buyer B
                    ON(L.lprod_gu = B.buyer_lgu)
;

-- �Ϳ����
SELECT A.mem_id "ȸ��ID", 
            A.mem_name "ȸ���̸�",
            B.buyer_name "��ǰ�ŷ�ó��",
            C.lprod_nm "��ǰ�з���"
FROM member A, buyer B, lprod C, prod D, CART E
WHERE  B.buyer_lgu = C.lprod_gu
AND C.lprod_gu = D.prod_lgu
AND D.prod_id = E.cart_prod
AND E.cart_member = A.mem_id;

SELECT  A.mem_id "ȸ��ID", 
            A.mem_name "ȸ���̸�",
            B.buyer_name "��ǰ�ŷ�ó��",
            C.lprod_nm "��ǰ�з���"
FROM member A INNER JOIN cart E
                On(A.mem_id = E.cart_member)
                INNER JOIN prod D
                On(E.cart_prod = D.prod_id)
                INNER JOIN buyer B
                On(D.prod_buyer = B.buyer_id)
                INNER JOIN lprod C
                On(B.buyer_lgu = C.lprod_gu);

/*
[����]
�ŷ�ó�� '�Ｚ����'�� �ڷῡ ����
��ǰ�ڵ�, ��ǰ��, �ŷ�ó���� ��ȸ�Ϸ��� �մϴ�.
*/
-- [�Ϲݹ��]
Select P.prod_id ��ǰ�ڵ�,
        P.prod_name ��ǰ��,
        B.buyer_name �ŷ�ó
From prod P, buyer B
    Where P.prod_buyer = B.buyer_id
    AND B.buyer_name = '�Ｚ����';

-- [ANSI ����ǥ�ع��]
Select P.prod_id ��ǰ�ڵ�,
        P.prod_name ��ǰ��,
        B.buyer_name �ŷ�ó
From prod P Inner join buyer B
                    ON(P.prod_buyer = B.buyer_id)
Where B.buyer_name ='�Ｚ����';

Select P.prod_id ��ǰ�ڵ�,
        P.prod_name ��ǰ��,
        B.buyer_name �ŷ�ó
From prod P Inner join buyer B
                    ON(P.prod_buyer = B.buyer_id
                        AND B.buyer_name ='�Ｚ����');

/*
[����]
��ǰ���̺��� ��ǰ�ڵ�, ��ǰ��, �з���, �ŷ�ó��, �ŷ��ּҸ� ��ȸ
�ǸŰ����� 10��������
�ŷ�ó �ּҰ� �λ��� ��츸 ��ȸ
*/
-- [�Ϲݹ��]
Select P.prod_id '��ǰ�ڵ�',
        P.prod_name '��ǰ��',
        L.lprod_id '��ǰ�з���',
        B.buyer_name '�ŷ�ó��',
        B.buyer_add1 '�ŷ��ּ�'
From prod P, lprod L, buyer B
    Where P.prod_lgu = L.lprod_gu
        AND B.buyer_id = P.prod_buyer
        AND P.prod_sale <= '100000'
        AND B.buyer_add1 LIKE '%�λ�%'
;

Select P.prod_id ��ǰ�ڵ�,
        P.prod_name ��ǰ��,
        L.lprod_id ��ǰ�з���,
        B.buyer_name �ŷ�ó��,
        B.buyer_add1 �ŷ��ּ�,
        P.prod_sale �ǸŰ�
From prod P , lprod L , buyer B 
    Where prod_lgu = lprod_gu
        AND prod_buyer = buyer_id
        AND prod_sale <= '100000'
        AND buyer_add1 LIKE '%�λ�%'
;

-- [ANSI ����ǥ�ع��]
Select P.prod_id ��ǰ�ڵ�,
        P.prod_name ��ǰ��,
        L.lprod_id ��ǰ�з���,
        B.buyer_name �ŷ�ó��,
        B.buyer_add1 �ŷ��ּ�,
        P.prod_sale �ǸŰ�        
From prod P Inner join lprod L
                    ON(P.prod_lgu = L.lprod_gu)
                Inner join buyer B
                    ON(P.prod_buyer = B.buyer_id
                        AND P.prod_sale <= '100000'
                        AND B.buyer_add1 LIKE '%�λ�%');

/*
[����]
��ǰ�з��ڵ�(lprod_gu)�� P101�ΰͿ� ����
��ǰ�з���, ��ǰ���̵�(��ǰ�ڵ�), �ǸŰ�, �ŷ�ä�����, ȸ�����̵�, �ֹ����� ��ȸ
��ǰ�з����� �������� �������� DESC
��ǰ���̵� �������� �������� ASC
�Ϲ�, ǥ��
*/
-- [�Ϲݹ��]
Select lprod_nm ��ǰ�з���, 
            prod_id ��ǰ�з��ڵ�, 
            prod_sale �ǸŰ�, 
            buyer_charger �ŷ�ä�����, 
            mem_id ȸ��ID, 
            cart_qty �ֹ�����
From member, cart, prod, buyer, lprod
    Where mem_id = cart_member
        AND cart_prod = prod_id
        AND prod_buyer = buyer_id
        AND prod_lgu = lprod_gu
        AND lprod_gu = 'P101'
Order By lprod_nm DESC, prod_id ASC;

-- �����
Select lprod_nm ��ǰ�з���, 
            prod_id ��ǰ�з��ڵ�, 
            prod_sale �ǸŰ�, 
            buyer_charger �ŷ�ä�����, 
            cart_member ȸ��ID, 
            cart_qty �ֹ�����
From cart, prod, buyer, lprod
    Where cart_prod = prod_id
        AND prod_buyer = buyer_id
        AND prod_lgu = lprod_gu
        AND lprod_gu = 'P101'
Order By lprod_nm DESC, prod_id ASC;

-- [ANSI ����ǥ�ع��]
Select lprod_nm ��ǰ�з���, 
            prod_id ��ǰ�з��ڵ�, 
            prod_sale �ǸŰ�, 
            buyer_charger �ŷ�ä�����, 
            mem_id ȸ��ID, 
            cart_qty �ֹ�����
From member Inner join cart
                        ON(mem_id = cart_member)
                    Inner join prod
                        ON(cart_prod = prod_id)
                    Inner join buyer
                        ON(prod_buyer = buyer_id)                        
                    Inner join lprod
                        ON(prod_lgu = lprod_gu
                            AND lprod_gu = 'P101')
Order By lprod_nm DESC, prod_id ASC;


