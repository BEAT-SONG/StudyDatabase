/*
lprod : 상품분류정보
prod : 상품정보 / 거래처, 상품분류
buyer : 거래처정보 
member : 회원정보
cart : 구매(장바구니)정보 / 회원, 상품
buyprod : 입고상품정보 / 상품정보
remain : 재고수불정보
*/

-- 상품 분류테이블에서 현재 상품테이블에 존재하는 분류만 검색
-- 분류코드, 분류명
-- IN 안에는 하나의 컬럼에 많은 데이터(열)를 조회할 수 있는 형태로 구성되야 함
-- 서브쿼리 사용형태
Select lprod_gu 분류코드, lprod_nm 분류명
From lprod
Where lprod_gu IN (Select prod_lgu From prod);

-- 상품 분류데이터에서 현재 상품테이블에 존재하지 않은 분류만 검색하시오.
-- 별칭은 분류코드, 분류명
Select lprod_gu 분류코드, lprod_nm 분류명
From lprod
Where lprod_gu NOT IN (Select prod_lgu From prod);

/*
[문제]
한번도 구매한 적이 없는 회원ID, 이름 조회
*/
Select mem_id 회원ID, mem_name 회원이름
From member
Where mem_id NOT IN (Select cart_member From cart);

/*
데이터 조회하기
1. 테이블 찾기
2. 조회할 칼럼 찾기
3. 조건 유무 확인
*/

/*
[문제]
한번도 판매된 적이 없는 상품을 조회하려고 한다.
판매된 적이 없는 상품이름을 조회해주세요.
*/
Select prod_name 상품명
From prod
Where prod_id NOT IN(Select cart_prod From cart);

/*
[문제]
회원 중 '김은대' 회원이 지금까지 구매했던 모든 상품명을 조회해주시오.
*/
Select prod_name 상품명
From prod
Where prod_id IN(Select cart_prod From cart
                        Where cart_member = 'a001');

Select prod_name 상품명
From prod
Where prod_id 
    IN(Select cart_prod From cart
        Where cart_member 
            IN (Select mem_id From member
                Where mem_name = '김은대'));
                                                        
Select *
From member
Where mem_id = 'a001';

SELECT *
FROM CART;

-- 상품 중 판매가격이 10만원 이상, 30만원 이하인 상품을 조회
-- 조회 컬럼은 상품명, 판매가격
-- 정렬은 판매가격을 기준으로 내림차순
Select prod_name 상품명, prod_sale 상품가격
From prod
Where prod_sale >= 100000
    AND prod_sale <= 300000
Order By prod_sale Desc;

Select prod_name 상품명, prod_sale 상품가격
From prod
Where prod_sale Between 100000 AND 300000
Order By prod_sale Desc;

-- 회원 중 생일이 1975-01-01 에서 1976-12-31 사이에 태어난 회원을 검색하시오.
-- 별칭 회원ID, 회원명, 생일
Select mem_id 회원ID, mem_name 회원명, mem_regno1 생일
From member
Where mem_regno1 Between 750101 AND 761231;

Select mem_id 회원ID, mem_name 회원명, mem_bir 생일
From member
Where mem_bir Between '75-01-01' AND '76-12-31';

Select mem_id 회원ID, mem_name 회원명, mem_bir 생일
From member
Where mem_bir Between '75/01/01' AND '76/12/31';

/*
[문제]
거래처 당담자 '강남구'씨가 당담하는 상품을 구매한 회원을 조회
회원ID, 회원이름을 조회
*/
Select mem_id 회원ID, mem_name 회원이름
From member
Where mem_id 
    IN (Select cart_member From cart
        Where cart_prod 
            IN(Select prod_id From prod
                Where prod_buyer
                    IN(Select buyer_id From buyer
                        Where buyer_charger = '강남구')));


Select *
From buyer;

select * from prod;

select * from lprod;

Select mem_id 회원ID, mem_name 회원이름
From member
Where mem_id 
    IN (Select cart_member From cart
        Where cart_prod 
            IN(Select prod_id From prod
                Where prod_lgu
                    IN(Select lprod_gu From lprod
                        Where lprod_gu
                        IN(Select buyer_lgu From buyer
                            Where buyer_charger = '강남구'))));

-- 상품 중 매입가가 300,000~1,500,000이고 판매가가 800,000~2,000,000 인 상품을 검색하시오.
-- 별칭은 상품명, 매입가, 판매가
Select prod_name 상품명, prod_cost 매입가, prod_sale 판매가
From prod
Where prod_cost Between 300000 AND 1500000
    AND prod_sale Between 800000 AND 2000000;
    
-- 회원 중 생일이 1975년도 생이 아닌 회원을 검색하시오.
-- 별칭은 회원ID, 회원명, 생일
-- 생일과 주민번호앞6자리는 다를 수 있다.
Select mem_id 회원ID, mem_name 회원명, mem_bir 생일
From member
Where mem_regno1 NOT Between 750101 AND 751231;

Select mem_id 회원ID, mem_name 회원명, mem_bir 생일
From member
Where mem_bir NOT Between '75-01-01' AND '75-12-31';

-- 회원테이블에서 김씨 성을 가진 회원을 검색하시오.
-- 별칭은 회원ID, 성명
Select mem_id 회원ID, mem_name 성명
From member
Where mem_name Like '김%';

-- 회원테이블에서 주민등록번호 앞지리를 검색하여 1975년생을 제외한 회원을 검색하시오.
-- 별칭 회원ID, 성명, 주민등록번호
Select mem_id 회원ID, mem_name 성명, mem_regno1 주민등록번호
From member
Where mem_regno1 NOT Like '75%';

-- CONCAT()
-- 두개의 문자열을 합친다.
Select CONCAT('My Name is ', mem_name) 성명
From member;

-- CHR, ASCII
-- ASCII값을 문자로, 문자를 ASCII값으로 반환
Select CHR(65) "CHR", ASCII('A') "ASCII"
From dual;

-- LOWER() = 해당 문자나 문자열을 소문자로 변환
-- UPPER() = 대문자로 변환
-- INITCAP() = 첫 글자를 대문자로 나머지는 소문자로 변환
Select LOWER('DATA mainpulation Language') "LOWER",
        UPPER('DATA mainpulation Language') "UPPER",
        INITCAP('DATA mainpulation Language') "INITCAP"
From dual;

-- 회원테이블의 회원ID를 대문자로 변환하여 검색하시오.
-- 별칭은 변환 전 ID, 변환 후 ID
Select mem_id 변환전ID, UPPER(mem_id) 변환후ID 
From member;

-- LPAD, RPAD() = 지정된 길이 n에서 c1을 채우고 남은 공간을 c2로 채워라

-- LTRIM(), RTRIM() = 좌측, 우측의 공백문자를 제거
-- TRIM() = 양쪽의 공백문자 제거

-- SUBSTR( , , ) = 문자열의 일부분을 선택해서 조회

-- TRANSLATE(c1,c2,c3) = c1문자열에 포함된 문자 중 c2에 지정된 문자가 c3문자로 각각 변경

-- REPLACE() = 문자나 문자열을 치환
Select REPLACE('SQL Project', 'SQL', 'SSQQLL') 문자치환1,
    REPLACE('Java Flex Via', 'a') 문자치환2
From dual;

-- 회원테이블의 회원성명 중 성씨 '이' ---> '리' 로 치환하여 뒤에 이름을 붙인 후 검색하시오.
-- 별칭은 회원명, 회원명치환
-- 모든 '이' ---> '리'
Select mem_name 회원명,
    REPLACE(mem_name, '이', '리') 회원명치환
From member;

Select mem_name 회원명,
    CONCAT(REPLACE(SUBSTR(mem_name, 1, 1), '이', '리'), SUBSTR(mem_name, 2)) 회원명치환
From member;

Select mem_name 회원명,
    CONCAT(REPLACE(SUBSTR(mem_name, 1, 1), '이', '리'), SUBSTR(mem_name, 2, 3)) 회원명치환
From member;

-- ROUND(n, l) = 지정된 자릿수(l) 밑에서 반올림
-- TRUNC(n, l) = 위와 같음, 반올림이 아니라 절삭
-- 일의 자리 수 = 0 , 소수점 첫째자리 수 = 1 ....

-- MOD(c, n) = n으로 나눈 나머지

-- 날짜 함수
-- SYSDATE = 시스템에서 제공하는 현재 날자와 시간 값
-- dual = 더미 테이블 
Select sysdate -1
From dual;

-- ADD_MONTHS(data, n) = date에 월을 더한 날짜
-- NEXT_DAY(data, char) = 해당 날짜 이후 가장 빠른 요일의 날짜
-- LAST_DAY(date) = 월의 마지막 날짜
Select NEXT_DAY(SYSDATE, '월요일'),
        LAST_DAY(SYSDATE)
From dual;

-- 이번달이 며칠 남아있는지?
Select LAST_DAY(SYSDATE) - SYSDATE 남은일수
From dual;

-- EXTRACT(fmf FROM data) = 날짜에서 필요한 부분만 추출
Select EXTRACT(YEAR FROM SYSDATE) "년도",
    EXTRACT(MONTH FROM SYSDATE) "월",
    EXTRACT(DAY FROM SYSDATE) "일"
From dual;

-- 생일이 3월인 회원을 검색하시오.
Select mem_name 회원명, EXTRACT(MONTH From mem_bir) 월생
From member
Where EXTRACT(MONTH From mem_bir) = '3';

/*
[문제]
회원 생일 중 1973년생이 주로 구매한 상품을 오름차순으로 조회
- 조회 컬럼 : 상품명
- 단, 상품명에 삼성이 포함된 상품만 조회. 조회 결과는 중복 제거
*/
-- 못함.. 강사님꺼 
-- 조건 = EXTRACT(YEAR FROM mem_bir) = 1973
Select DISTINCT prod_name 상품명
From prod
Where prod_id 
    IN (Select cart_prod From cart
            Where cart_member
                IN(Select mem_id From member
                    Where mem_bir Between '73-01-01' AND '73-12-31'
                        AND prod_name LIKE '%삼성%'))
Order By prod_name ASC;

Select DISTINCT prod_name 상품명
From prod
Where prod_name LIKE '%삼성%'  
    AND prod_id 
        IN (Select cart_prod From cart
            Where cart_member
                IN(Select mem_id From member
                    Where EXTRACT(YEAR FROM mem_bir) = 1973))
Order By prod_name ASC;

-- CAST(expr AS type) = 명시적으로 형 변환
-- TO_CHAR() = 숫자, 문자, 날짜를 지정한 형식의 문자열 변환
-- TO_NUMBER() =  숫자형식의 문자열을 숫자로 변환
-- TO_DATE() = 날짜 형식의 문자열을 날짜로 변환
Select TO_CHAR(CAST('2008-12-25' AS DATE), 'YYYY.MM.DD HH24:MI')
From dual;

Select TO_CHAR(SYSDATE, 'AD YYYY, CC "세기"')
From dual;

-- 상품테이블에서 상품입고일을 '2008-09-28' 형식으로 나오게 검색하시오
-- 별칭 = 상품명, 상품판매가, 입고일
Select prod_name 상품명, prod_sale 상품판매가, 
        TO_CHAR(prod_insdate, 'YYYY-MM-DD') 입고일
From prod;

-- 회원이름과 생일로 다음처럼 출력되게 작성하시오.
-- 김은대님은 1976년 1월 출생이고 태어난 요일은 목요일
Select CONCAT(CONCAT(mem_name, '님 은'), TO_CHAR(mem_bir,'YYYY'))
From member;

Select (mem_name || '님은' || 
        TO_CHAR(mem_bir,'YYYY') || '년 ' || 
        TO_CHAR(mem_bir,'D') ||'월 출생이고 태어난 요일은 ' ||  
        TO_CHAR(mem_bir, 'day') || '입니다.'
        ) as sumStr
From member;

-- 숫자
-- 9는 유효한 숫자, 0은 무효한 숫자 = 의미없는 자리수
-- $, L = 달러 및 지역 화폐 기호
-- MI = 음수인 경우 우측에 마이너스 표시, 우측에 표시
-- PR = 음수인 경우 "<>"괄호로 묶는다. 우측에 표시
-- X = 해당 숫자를 16진수로 표현
Select TO_CHAR(1234.6, '999,999.00')
From dual;

Select TO_CHAR(-1234.6, 'L999,999.00PR')
From dual;

Select TO_CHAR(255, 'XXX')
From dual;

-- 상품테이블에서 상품코드, 상품명, 매입가격, 소비자가격, 판매가격을 출력하시오
-- 단, 가격은 천단위 구분 및 원화표시
Select prod_id 상품코드, prod_name 상품명, 
        TO_CHAR(prod_cost,'L9,999,999') 매입가격, 
        TO_CHAR(prod_sale,'L9,999,999') 소비자가격, 
        TO_CHAR(prod_price,'L9,999,999') 판매가격
From prod;

-- TO_NUMBER() =  숫자형식의 문자열을 숫자로 변환

-- 회원테이블에서 '이쁜이'회원의 회원ID 2~4 문자열을 숫자형으로 치환한 후 10을 더하여 새로운 회원ID를 조합하시오.
-- 별칭 = 회원ID, 조합회원ID
-- 못함...

Select mem_id 회원ID,
        Substr(mem_id, 1, 2) ||
        (Substr(mem_id, 3, 4) + 10)
From member
Where mem_name = '이쁜이';

-- 상품테이블의 상품분류별 매입가격 평균 값
-- AVG() = 그룹함수
/*
[규칙]!!
일반 컬럼과 그룹 함수를 같이 사용할 경우에는
꼭 Group By절을 넣어 주어여 합니다.
그리고 Group By절에는 일반 컬럼이 모두 들어가야 합니다.
*/
Select prod_lgu "상품 분류",
        ROUND(AVG(prod_cost), 2) "매입가격 평균"
From prod
Group By prod_lgu;

Select ROUND(AVG(prod_cost), 2) "매입가격 평균"
From prod;

-- 상품테이블의 총 판매가격 평균 값을 구하시오,
-- 별칭 = 상품판매가격평균
Select ROUND(AVG(prod_sale), 2) "상품판매가격평균"
From prod;

-- 상품테이블의 상품분류별 판매가격 평균값
Select prod_lgu,  
        ROUND(AVG(prod_sale), 2) "상품판매가격평균"
From prod
Group By prod_lgu;

Select prod_lgu,  
        AVG(prod_sale) as avg_sale
From prod
Group By prod_lgu;





