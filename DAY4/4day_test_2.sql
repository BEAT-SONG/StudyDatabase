/*
[1����]
�ֹε�ϻ� 1������ ȸ���� ���ݱ��� ������ ��ǰ�� ��ǰ�з� ��  
�� �α��ڰ� 01�̸� �ǸŰ��� 10%�����ϰ�
02�� �ǸŰ��� 5%�λ� �������� ���� �ǸŰ��� ����
(�����ǸŰ��� ������ 500,000~1,000,000�� ���̷� ������������ �����Ͻÿ�.)
(��ȭǥ�� �� õ��������)
(Alias ��ǰ�з�, �ǸŰ�, �����ǸŰ�)
*/
-- �ȉ�,.
Select prod_lgu ��ǰ�з�, 
         prod_sale �ǸŰ�,
         CASE WHEN SUBSTR(prod_lgu, 3, 4) = '01' THEN TO_NUMBER(prod_sale, 'L9,999,999,999,999')* 0.9
                 WHEN SUBSTR(prod_lgu, 3, 4) =  '02' THEN TO_NUMBER(prod_sale, 'L9,999,999,999,999')* 1.05 
                 ELSE TO_NUMBER(prod_sale, 'L9,999,999,999,999')
                 END new_sale
From prod
Where prod_sale BETWEEN 500000 AND 1000000
            AND prod_id 
                IN(Select cart_prod From cart
                    Where cart_member
                            IN(Select mem_id From member
                                Where TO_CHAR(mem_bir, 'MM') = '01'))
Order By new_sale DESC;

-- �̰Ŵ� �ȵ�.. ��??
-- DECODE�ȿ� TO_CHAR�� ����ϸ� �ȵȴ�.
Select prod_lgu ��ǰ�з�, 
         prod_sale �ǸŰ�,
         DECODE(SUBSTR(prod_lgu, 3, 4),
                    '01', TO_CHAR(prod_sale, 'L9,999,999')*0.9,
                    '02', TO_CHAR(prod_sale, 'L9,999,999')*1.05, prod_sale) AS new_sale
From prod
Where prod_sale BETWEEN 500000 AND 1000000
            AND prod_id 
                IN(Select cart_prod From cart
                    Where cart_member
                            IN(Select mem_id From member
                                Where TO_CHAR(mem_bir, 'MM') = '01'))
Order By new_sale DESC;

-- ��ȭǥ�ö� õ����ǥ�ð� ��
-- DECODE ��ü�� TO_CHAR(, 'L9,999,999,999')�� �����ϸ� ����!!!!!
Select prod_lgu ��ǰ�з�, 
         prod_sale �ǸŰ�,
         TO_CHAR((DECODE(SUBSTR(prod_lgu, 3, 4),
                    '01', prod_sale*0.9,
                    '02', prod_sale*0.95, prod_sale)), 'L9,999,999,999') AS new_sale
From prod
Where prod_sale BETWEEN 500000 AND 1000000
            AND prod_id 
                IN(Select cart_prod From cart
                    Where cart_member
                            IN(Select mem_id From member
                                Where TO_CHAR(mem_bir, 'MM') = '01'))
Order By new_sale DESC;


-- 5��
-- �ֹι�ȣ�� ����
select prod_lgu ��ǰ�з�, prod_sale �ǸŰ�,
to_char(decode(substr(prod_lgu,3,2),
    '01',prod_sale - prod_sale*0.1 ,
    '02',prod_sale*1.05, prod_sale),'L999,999,999') as �����ǸŰ�
from prod
where prod_id in
(select cart_prod
from cart
where cart_member in
(select mem_id
from member
where substr(mem_regno1,3,2)= '01'))
and decode(substr(prod_lgu,3,1),
    '01',prod_sale - prod_sale*0.1 ,
    '02',prod_sale*1.05, prod_sale) BETWEEN 500000 and 1000000
order by �����ǸŰ�;

/*
[2����]
ȸ���� 1975���[mem_bir]�̰� ����[mem_add1] �ּ��� ȸ���� �����ߴ� ����ǰ �߿� 
�ǸŰ�[prod_sale]�� �ǸŰ��� ��ü���[avg(prod_sale)]���� ���� ��ǰ�� �˻��غ�����.
��  
1. �ǸŰ�[prod_sale]�� �������� ��������[desc]�ϰ�, �ǸŰ��� õ���� ����ǥ��[to_char(,)]
2. ��ǰ�� �Ｚ�� �� ��ǰ�� ���� [prod_name]
3. ��ǰ������ NULL���� '����'���� ó�� [NVL(prod_color, '����')]
4. ���� ������ 1�̻��� �͸� ��ȸ[group by prod_color]
*/
Select prod_name ��ǰ��,
        NVL(prod_color, '����') ��ǰ����,
        prod_sale ��ǰ�ǸŰ�
From prod
Group By prod_name, prod_color, prod_sale
;


/*
[3����]
���� ������ �����ϰ� ������ 2���̰� �������ڰ� 4�� ~ 6�� ������ ȸ�� �� 
���ż����� ��üȸ���� ��� ���ż������� ���� ȸ�� ��ȸ �� 

"(mem_name) ȸ������ (Extract(month form mem_bir)) �� ������ �������� �����մϴ�. 
2��Ʈ (mem_add �� 2����) ���� �̿��� �ּż� �����մϴ�.
�̹� 2�� ���ȿ��� VVIPȸ������ ���ϸ����� 3��� ����Ͻ� �� �ֽ��ϴ�.
�����ε� ���� �̿� �ٶ��ϴ�." ���

(Alias ȸ����, ����, �ּ�, �̸��� �ּ�, ���� ���� ����)
*/