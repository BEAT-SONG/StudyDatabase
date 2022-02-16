-- AVG() = 조회 범위 내 해당 컬럼들의 평균값
-- DISTINCT() = 중복된 값으 제외
-- 컬럼명 = NULL값은 제외
-- * = NULL값도 포함(COUNT 함수만 사용), 행의 유무를 확이
-- NULL과 연산을 하면 결과값이 NULL이 나옴

Select COUNT(prod_cost)
From prod;

Select COUNT(DISTINCT(prod_cost))
From prod;

/*
[문제]
구매내역(장바구니) 정보에서 회원아이디별로 주문(수량)에 대한 평균을 조회
회원아이디를 기준으로 내림차순
*/
Select cart_member 회원ID, ROUND(AVG(cart_qty) , 2)
From cart
Group By cart_member
Order By cart_member DESC
;

Select cart_member 회원ID, AVG(cart_qty) as avg_qty
From cart
Group By cart_member
Order By cart_member DESC
;

/*
[문제]
상품정보에서 판매가격의 평균값을 구해주세요.
평균값은 소수점 2째자리까지 표현해 주세요.
*/
Select ROUND(AVG(prod_sale), 2) as avg_sale
From prod;

Select prod_name 상품명, ROUND(AVG(prod_sale), 2) as avg_sale
From prod
Group By prod_name;

/*
[문제]
상품정보에서 상품분류별 판매가격의 평균값을 구하시오,
조회컬럼은 상품분류코드, 상품분류변 판매가격의 평균
평균값은 소수점 둘째자리까지 표현
*/
Select prod_lgu 상품분류코드, ROUND(AVG(prod_sale), 2) AS "상품분류별 판매가격"
From prod
Group By prod_lgu;

-- 회원테이블의 취미 종류수를 COUNT 집계하시오
Select COUNT(DISTINCT mem_like)
From member;

-- 회원테이블의 취미별 COUNT 집계하시오.
-- 별칭 = 취미, 자료수, 자료수(*)
Select mem_like 취미, COUNT(mem_like) 자료수, COUNT(*) "자료수(*)"
From member
Group By mem_like;

Select mem_like 취미, COUNT(mem_like) 자료수
From member
Group By mem_like;

-- 회원테이블의 직업종류수를 COUNT 하시오
-- 직업종류수
Select COUNT(DISTINCT(mem_job))
From member;

Select mem_job, COUNT(mem_job) as cnt_job
From member
Group By mem_job
Order By cnt_job DESC
;

/*
[문제]
회원 전체의 마일리지 평균보다 큰 회원에 대한 -- 일반조건
아이디, 이름, 마일리지를 조회
정렬은 마일리지가 높은 순으로
*/
Select mem_id 회원ID, mem_name 회원명, mem_mileage 마일리지
From member
Where mem_mileage >= (Select AVG(mem_mileage) From member) -- 괄호 안의 값이 하나가 되어야 한다.
Order By mem_mileage DESC;

Select mem_id 회원ID, mem_name 회원명, mem_mileage 마일리지
From member
Order By mem_mileage DESC;

-- MAX()
-- MIN()

-- 오늘이 2000년도 7월 11일이라고 가정하고 장바구니테이블에 발생할 추가주문번호를 검색하시오
-- 별칭 = 현재년월일 기준으로 가장 높은 주문번호, 추가주문번호)
-- 여러가지 방법이 존재한다! 단, 쿼리가 단순해야 속도도 빠르고 좋다!!!!
Select ('200507110000' || MAX((SUBSTR(cart_no,9)))) AS "현재년월일 기준으로 가장 높은 주문번호" , 
        ('200507110000' || MAX((SUBSTR(cart_no,9))) + 1) AS "추가주문번호"
From cart
Where SUBSTR(cart_no,1, 8) = 20050711
;

-- 귀영 언니꺼, 강사님
SELECT MAX(cart_no), MAX(cart_no)+1 
FROM cart
Where cart_no LIKE '20050711%';

Select *
From cart
;

/*
[문제]
구매정보에서 년도별로 판매된 상품의 개수, 평균구매수량을 조회
정렬은 년도를 기준으로 내림차순
*/
-- 데이터를 조회할때 1건이 나오든 하나도 안 나오든 논리적으로 쿼리를 구성하면 된다. (쫄지말기)
-- Group 함수 = SUM, AVG, MAX, MIN 함수이다.
-- 그룹함수 외의 일반함수가 Select에 있으면 Group By를 이용해서 일반함수를 그룹화 해줘야한다.
Select SUBSTR(cart_no, 1,4) 년도, SUM(cart_qty) 판매된상품개수, AVG(cart_qty) 평균구매수량
From cart
Group By SUBSTR(cart_no, 1,4)
Order By SUBSTR(cart_no, 1,4) DESC
;

-- 달별 기준
Select SUBSTR(cart_no, 1,6) 년도월, SUM(cart_qty) 판매된상품개수, ROUND(AVG(cart_qty), 2) AS 평균구매수량
From cart
Group By SUBSTR(cart_no, 1,6)
Order By SUBSTR(cart_no, 1,6) DESC
;

Select SUBSTR(cart_no, 1,6)
From cart;

/*
[문제]
구매정보에서 년도별, 상품분류코드별로 상품의 개수(COUNT)를 조회
정렬은 년도를 기준으로 내림차순
*/
Select SUBSTR(cart_no, 1, 4) 년도, SUBSTR(cart_prod, 1, 4) 상품분류코드, COUNT(cart_qty) 상품개수
From cart
Group By SUBSTR(cart_no, 1, 4), SUBSTR(cart_prod, 1, 4)
Order By SUBSTR(cart_prod, 1, 4) DESC;

-- 회원테이블의 회원전체의 마일리지 평균, 마일리지 합계, 최고 마일리지, 최소마일리지, 인원수를 검색하시오
-- 별칭 = 마일리지평균, 마일리지합계, 최고마일리지, 최소마일리지, 인원수
Select ROUND(AVG(mem_mileage), 2) AS 마일리지평균, 
        SUM(mem_mileage) 마일리지합계, 
        MAX(mem_mileage) 최고마일리지, 
        MIN(mem_mileage) 최소마일리지, 
        COUNT(mem_id) 인원수
From member;

/*
[문제]
상품테이블에서 상품분류별 판매가 전체의 평균, 합계, 최고값, 최저값, 자료수를 검색
별칭 = 평균, 합계, 최고값, 최저값, 자료수
자료수가 20개 이상인것 조회
*/
Select prod_lgu 상품분류, 
        ROUND(AVG(prod_sale), 2) AS 평균, 
        SUM(prod_sale) 합계,
        MAX(prod_sale) 최고값,
        MIN(prod_sale) 최소값,
        COUNT(prod_sale) 자료수
From prod
Group By prod_lgu
HAVING COUNT(prod_sale) >= 20 -- 그룹화를 하고/그룹함수에 조건을 주고 싶을 때는 HAVING() 함수 사용
Order By COUNT(prod_sale) DESC;

-- Where 절 : 일반조건만 사용
-- HAVING 절 : 그룹조건만 사용 (그룹함수를 사용한 조건처리)

-- 회원테이블에서 지역(주소1의 2자리), 생일년도별로 마일리지평균, 합계, 최고, 최소, 자료수를 검색
-- 별칭 = 지역, 생일연도, 마일리지평균,  합계, 최고, 최소, 자료수
-- 자료수 내림차순으로
Select SUBSTR(mem_add1, 1, 2) 지역,
        SUBSTR(mem_bir, 1, 2) 생일연도,
        ROUND(AVG(mem_mileage), 2) 마일리지평균,
        SUM(mem_mileage) 마일리지합계,
        MAX(mem_mileage) 최고마일리지,
        MIN(mem_mileage) 최소마일리지,
        COUNT(mem_mileage) 자료수
From member
Group By SUBSTR(mem_add1, 1, 2), SUBSTR(mem_bir, 1, 2)
Order By COUNT(mem_mileage) DESC;
 
-- NULL처리
-- NULL 값은 0, 1과 같은 특정한 값이 아니고 아무것도 없는 것을 의미

-- NULL처리를 위해서 NULL을 추가
-- 거래처 담당자 성씨가 '김'이면 NULL로 갱신
UPDATE buyer SET  buyer_charger = NULL
Where buyer_charger LIKE '김%';

-- 거래처 담당자 성씨가 '성'이면 White Space로 갱신
-- ''는 빈공백으로 인식
-- 데이터는 없지만 메모리를 차지
UPDATE buyer SET  buyer_charger = ''
Where buyer_charger LIKE '성%';

-- 확인
-- 거래처 담당자 성씨가 '김'이면 NULL로 갱신되었으므로 조회가 되지 않는다.
Select buyer_name 거래처, buyer_charger 담당자
From buyer
Where buyer_charger LIKE '김%';

-- 거래처 담당자 성씨가 '성'이면 White Space로 갱신되었으므로 조회가 되지 않는다.
Select buyer_name 거래처, buyer_charger 담당자
From buyer
Where buyer_charger LIKE '성%';

-- NVL(,)
-- IS NULL : Where절에서 사용 가능.
-- NULLIF(,)

--NULL을 이용 NULL값 비교
Select buyer_name 거래처, buyer_charger 담당자
From buyer
Where buyer_charger = NULL;

-- IS NULL을 이용 NULL값 비교
Select buyer_name 거래처, buyer_charger 담당자
From buyer
Where buyer_charger IS NULL;

Select buyer_name 거래처, buyer_charger 담당자
From buyer
Where buyer_charger IS NOT NULL;

-- 해당컬럼이 NULL인 경우 대신할 문자나 숫자 치환
-- NULL이 존재하는 상태로 조회
Select buyer_name 거래처, buyer_charger 담당자
From buyer;

-- NVL을 이용 NULL값일 경우 '없다'로 치환
Select buyer_name 거래처, NVL(buyer_charger, '없다') AS 담당자
From buyer;

-- 회원 마일리지에 100을 더한 수치를 검색하시오
-- NVL 사용
-- 별칭은 성명, 마일리지, 변경마일리지
Select mem_name 성명, mem_mileage 마일리지, NVL(mem_mileage, 0) + '100' "변경마일리지"
From member;

-- 강사님
Select mem_name 성명, mem_mileage 마일리지, mem_mileage + '100' "변경마일리지"
From member;

-- 회원마일리지가 있으면 '정상회원', NULL이면 '비정상회원'으로 검색하시오.
-- NVL2 사용. 별칭 = 성명, 마일리지, 회원상태
Select mem_name 성명, mem_mileage 마일리지, NVL2(mem_mileage, '정상회원', '비정상회원') "회원상태"
From member;

-- DECODE() = IF문과 같은 기능을 함
Select DECODE(SUBSTR(prod_lgu, 1, 2),
                    'P1', '컴퓨터/전자 제품',
                    'P2', '의류',
                    'P3', '잡화', '기타')
From prod;

-- DECODE('기준이 되는 값', '2', '3', ...'')
-- '기준이 되는 값' 뒤부터 2개씩 묶어서 왼쪽에 있는 값이 기준 값이 '기준이 되는 값'과 같으면 오른쪽에 있는 값을 출력
-- 마지막에 하나가 남으면 위의 조건이 다 아니면 출력 (else의 느낌)

-- 상품분류중 앞의 두 글자가 'P1'이면 판매가의 10%로 인상하고 'P2'이면 판매가의 15%인상하고 나머지는 동일 판매가로 검색
-- DECODE 함수 사용
-- 별칭 = 상품명, 판매가, 변경판매가
Select prod_name 상품명, 
        prod_sale 판매가, 
        DECODE(SUBSTR(prod_lgu, 1,2),
                    'P1', prod_sale*1.10,
                    'P2', prod_sale*1.15, prod_sale) AS "변경판매가"
From prod;

-- CASE WHEN THEN 
-- ELSE END RESULT

-- CASE WHEN THEN 
-- ELSE END

-- 회원정보테이블의 주민등록 뒷자리(7자리중 첫번째)에서 성별 구분을 검색
-- CASE 구문 사용
-- 별칭 = 회원명, 주민등록번호(주민1, 주민2), 성별
Select mem_name 회원명, 
        SUBSTR(mem_regno2,1,1) 주민등록번호, 
        CASE WHEN SUBSTR(mem_regno2,1,1) = '1' THEN '남성'
                WHEN SUBSTR(mem_regno2,1,1) = '2' THEN '여성' 
                END "성별"   
From member;

Select mem_name 회원명, 
        SUBSTR(mem_regno2,1,1) 주민등록번호, 
        CASE WHEN SUBSTR(mem_regno2,1,1) = '1' THEN '남성'
                ELSE '여성' 
                END "성별"   
From member;










