/*
[1����]

�ֹε�ϻ� 1������ ȸ���� ���ݱ��� ������ ��ǰ�� ��ǰ�з� ��  
�� �α��ڰ� 01�̸� �ǸŰ��� 10%�����ϰ�
02�� �ǸŰ��� 5%�λ� �������� ���� �ǸŰ��� ����
(�����ǸŰ��� ������ 500,000~1,000,000�� ���̷� ������������ �����Ͻÿ�.)
(��ȭǥ�� �� õ��������)
(Alias ��ǰ�з�, �ǸŰ�, �����ǸŰ�)
*/
Select prod_lgu ��ǰ�з�, 
         prod_sale �ǸŰ�,
         CASE WHEN SUBSTR(prod_lgu, 3, 4) = '01' THEN TO_CHAR(prod_sale, 'L9,999,999')* 0.9
                 WHEN SUBSTR(prod_lgu, 3, 4) =  '02' THEN TO_CHAR(prod_sale, 'L9,999,999')* 1.05 
                 ELSE TO_CHAR(prod_sale, 'L9,999,999')
                 END new_sale
From prod
Where prod_sale BETWEEN 500000 AND 1000000
            AND prod_id 
                IN(Select cart_prod From cart
                    Where cart_member
                            IN(Select mem_id From member
                                Where TO_CHAR(mem_bir, 'MM') = '01'))
Order By new_sale DESC;

-- ��ȭǥ�ö� õ����ǥ�ð� �ȵ�
Select prod_lgu ��ǰ�з�, 
         prod_sale �ǸŰ�,
         DECODE(SUBSTR(prod_lgu, 3, 4),
                    '01', prod_sale*0.9,
                    '02', prod_sale*0.95, prod_sale) AS new_sale
From prod
Where prod_sale BETWEEN 500000 AND 1000000
            AND prod_id 
                IN(Select cart_prod From cart
                    Where cart_member
                            IN(Select mem_id From member
                                Where TO_CHAR(mem_bir, 'MM') = '01'))
Order By new_sale DESC;

-- �̰Ŵ� �ȵ�.. ��??
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
/*
[2����]

ȸ���� 1975����̰� ���� �ּ��� ȸ���� �����ߴ� ����ǰ �߿� 
�ǸŰ��� �ǸŰ��� ��ü��պ��� ���� ��ǰ�� �˻��غ�����.
��  
1. �ǸŰ��� �������� ���������ϰ�, �ǸŰ��� õ���� ����ǥ��
2. ��ǰ�� �Ｚ�� �� ��ǰ�� ���� 
3. ��ǰ������ NULL���� '����'���� ó��
4. ���� ������ 1�̻��� �͸� ��ȸ
*/

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