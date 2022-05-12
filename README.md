# StudyPandas
빅데이터_Pandas_학습_리포지토리

### 1일차
- 데이터베이스 개요

- Oracle 주요 함수
    - 테이블 생성하기
    - 데이터 조회, 입력, 수정, 정렬(Asc:오름차순, Desc:내림차순), 조건
    - Commit (커밋)

|생성|조회|입력|수정|정렬|조건|
|:--:|:--:|:--:|:---:|:---:|:---:|
|CREATE|Select|Insert|Alter|Order By|Where|

### 2일차
- ERD(Entity Relationship Diagram)
    - 데이터베이스 구조를 한 눈에 알아보기 위해 그려놓은 다이어그램

- Oracle 주요 함수

|서브쿼리|조건검색|추출|그룹화|
|:---:|:---:|:---:|:---:|
|IN|Like|EXTRACT|Group By|

|문자열 합치기|소문자 변환|대문자 변화|첫글자는 대문자, 나머지는 소문자로 변환|문자열에서 일부분을 선택해서 조회|문자 치환|
|:--:|:--:|:--:|:-------------:|:--:|:--:|
|CONCAT|LOWER|UPPER|INITCAP|SUBSTR|REPLACE, TRANSLATE|

|반올림|내림|
|:---:|:---:|
|ROUND|TRUNC|

|날짜|
|:---:|
|SYSDATE|

### 3일차
<Select문이 처리되는 순서>
- 컴파일 = 해석 = 처리
1) Select 6) 컬럼, (그룹함수)
2) From 테이블
3) Where 일반조건
   AND
   OR
4) Group By 일반컬럼
5) Having 그룹조건
7) Order By 컬럼(명, 순서, 별칭);

|중복 제거|개수 세기|평균|합|최대|최소|
|:---:|:---:|:---:|:---:|:---:|:---:|
|DISTINCT|COUNT|AVG|SUM|MAX|MIN|

- CASE WHEN THEN 
- ELSE END

### 4일차
- 


