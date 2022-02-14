-- CREATE TABLE(테이블 생성)
-- 모든 상응하는 컬럼과 자신의 데이터 타입을 갖는 새로운 테이블을 만듦
-- 테이블 생성하기
CREATE TABLE lprod(
    lprod_id number(5) NOT NULL, -- 상품분류코드
    lprod_gu char(4) NOT NULL, -- 산품분류
    lprod_nm VARCHAR2(40) NOT NULL, -- 상품분류명
    CONSTRAINT pk_lprod PRIMARY KEY (lprod_gu) -- GU => PK
);

-- 조회하기
Select  * -- 모든 컬럼을 다 가져 오겠다
From lprod;

Select  lprod_id, lprod_gu, lprod_nm
From lprod;

-- 데이터 입력하기
-- '문자열', 숫자
-- 한번에 다 넣을 수 있는 방법은 없다. 하나씩 따로 넣어줘야 한다.
-- 데이터 임포트 = File을 csv 형태로 넣을 수 있다.
Insert Into lprod (
    lprod_id, lprod_gu, lprod_nm
) Values(
    9, 'P403', '문구류'
);

Select  lprod_id, lprod_gu, lprod_nm
From lprod;

-- 상품분류정보(TABLE)에서 상품분류코드(GU)의 값이 P201인 데이터를 조회해 주세요.
Select *
From lprod
-- 조건 추가
Where lprod_gu = 'P201';

Select *
From lprod
-- 조건 추가
Where lprod_gu > 'P201'; -- 데이터(숫자)에 대한 크기 비교

-- 데이터 수정하기
-- 데이터 수정 및 삭제시에 Where 을 추가해서 조건을 주지 않으면 전ㄴ체 데이터가 수정 및 삭제가 될 수 있으므로 주의해야함.
-- 상품분류코드(GU)가 P102 에서 상품분류명(ID)의 값을 향수로 수정해 주세요.
SELECT *
FROM lprod
Where lprod_gu = 'P102';
    
Update lprod
    Set lprod_nm = '향수'
Where lprod_gu = 'P102';

-- 데이터 삭제하기
-- 상품분류정보에서 상품분류코드가 P202에 대한 데이터를 삭제해 주세요.
Select *
From lprod
Where lprod_gu = 'P202';

Delete From lprod
Where lprod_gu = 'P202';

-- 커밋
Commit;

-- 거래처 정보테이블 생성
Create Table buyer(
    buyer_id char(6) NOT NULL, -- 거래처코드
    buyer_name VARCHAR2(40) NOT NULL, -- 거래처명
    buyer_lgu char(4) NOT NULL, -- 취급상품 대분류
    buyer_bank varchar2(60), -- 은행
    buyer_bankno varchar2(60), -- 계좌번호
    buyer_bankname varchar2(15), -- 예금주
    buyer_zip char(7), -- 우편번호
    buyer_add1 VARCHAR2(100), -- 주소1
    buyer_add2 VARCHAR2(70), -- 주소2
    buyer_comtel VARCHAR(14) NOT NULL, -- 전화번호
    buyer_fax VARCHAR(20) NOT NULL -- fax 번호
);

-- Table 형태 수정
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

-- 강사님이 주신 파일로 테이블 생성함.

/*
lprod : 상품분류정보
prod : 상품정보 / 거래처, 상품분류
buyer : 거래처정보 
member : 회원정보
cart : 구매(장바구니)정보 / 회원, 상품
buyprod : 임고상품정보 / 상품정보
remain : 재고수불정보
*/

-- 순서
-- 1. 테이블 찾기
-- 2. 조건이 있는지?
-- 3. 어떤 컬럼을 사용하는지?

-- 회원 테이블부터 회원 ID와 성명을 검색하시오.
Select mem_id, mem_name
From member;

-- 상품 테이블로부터 상품코드와 상품명을 검색하시오.
Select prod_id, prod_name
From prod;

-- 회원 테이블의 마일리지를 12로 나눈 값을 검색하시오.
-- 별칭(알리아스) = () as 000
Select mem_mileage, (mem_mileage/12) as mem_12
From member;

-- 상품 테이블의 상품코드, 상품명, 판매금액을 검색하시오
-- 판매금액 = 판매단가*55 로 계산한다
SELECT * 
FROM prod;

Select prod_id, prod_name, (prod_sale*55) as prod_sale
From prod;

-- 중복된 ROW(데이터) 제거법
-- Distinct

-- 상품 테이블의 거래처 코드를 중복되지 않게 검색하시오.
Select *
From prod;

Select prod_buyer
From prod;

Select Distinct prod_buyer
From prod;

-- 데이터 정렬
-- Order By
-- 별칭을 사용할 수 있음
-- 회원 테이블에서 회원 ID, 회원명, 생일, 마일리지 검색
-- Asc 오름차순
-- Desc 내림차순
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

-- Where 절
-- True or False
-- 상품 중 판매가가 170,000원인 상품 조회
Select prod_name 상품, prod_sale 판매가
From prod
Where prod_sale = 170000;

-- 상품 판매가격이 170,000원이 아닌 상품 ID와 상품명을 조회
Select *
From prod;

Select prod_id 상품ID, prod_name 상품명
From prod
Where prod_sale != 170000;

-- 상품 중에 매입가격이 200,000원 이하인 상품 검색
-- 단, 상품코드를 기준으로 내림차순
-- 조회 컬럼은 상품 ID, 매입가격, 상품명
Select prod_id 상품코드, prod_name 상품명, prod_cost 매입가격
From prod
Where prod_cost <= 200000
Order By prod_id Desc;

-- 회원 중에 76년도 1월 1일 이후에 태어난
-- 회원ID, 회원이름, 주민등록번호 앞자리 조회
-- 단, 회원아이디 기준 오름차순
Select *
From member;

Select mem_id 회원ID, mem_name 회원이름, mem_regno1 주민등록번호_앞자리
From member
Where mem_regno1 >= 760101
Order By mem_id Asc;

-- 상품 중 상품분류가 P201(여성캐쥬얼)이고 판매가가 170,000원인 상품 조회
Select prod_name 상품명, prod_lgu 상품코드, prod_sale 판매가
From prod
Where prod_lgu = 'P201'
    AND prod_sale = 170000;

-- 상품 중 상품분류가 P201(여성캐쥬얼)이거나 판매가가 170,000원인 상품 조회
Select prod_name 상품명, prod_lgu 상품코드, prod_sale 판매가
From prod
Where prod_lgu = 'P201'
    OR prod_sale = 170000;

-- 상품 중 상품분류가 P201(여성캐쥬얼)이 아니고 판매가가 170,000원도 아닌 상품 조회
Select prod_name 상품명, prod_lgu 상품코드, prod_sale 판매가
From prod
Where prod_lgu != 'P201'
    AND prod_sale != 170000;

-- 상품 중 판매가가 300,000원 이상, 500,000원 이하인 상품을 검색
-- Alias(별칭) 은 상품코드, 상품명, 판매가
Select prod_id 상품코드, prod_name 상품명, prod_sale 판매가
From prod
Where prod_sale >= 300000 
    AND prod_sale <= 500000;
    
-- 상품 중에 판매가격이 150,000원, 170,000원, 330,000원인 상품정보 조회
-- 상품코드, 상품명, 판매가격 조회
-- 정렬은 상품명을 기준으로 오름차순
Select prod_id 상품코드, prod_name 상품명, prod_sale 판매가격
From prod
Where prod_sale = 150000
    OR prod_sale = 170000
    OR prod_sale = 330000
Order By prod_id Asc;

-- 회원 중에 아이디가 C001, F001, W001인 회원 조회
-- 회원ID, 회원이름 조회
-- 정렬은 주민번호 앞자리를 기준으로 내림차순
Select mem_id 회원ID, mem_name 회원이름
From member
Where mem_id = 'c001'
    OR mem_id = 'f001'
    OR mem_id = 'w001'
Order By mem_regno1 Desc;












