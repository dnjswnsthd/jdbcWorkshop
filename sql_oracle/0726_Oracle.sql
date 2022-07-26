-- 0726
-- << 단일행 함수
-- 문자함수 substr()
-- emp 테이블에서 업무중에서 SALESMAN 업무를 SALES만 출력되도록 문자열 추출

SELECT DISTINCT SUBSTR('SALESMAN', 1, 5)
FROM EMP;

-- emp 테이블에서 부서번호가 10번인 사원의 입사일 중 월만 추출해서 출력
SELECT ENAME, JOB, DEPTNO , SUBSTR(HIREDATE, 4, 2) "입사한 월"
FROM EMP
WHERE DEPTNO = 10;

-- length가 생략되면 끝까지 출력한다.
SELECT SUBSTR('HelloWorld', 6) FROM dual;
-- position이 음수면 뒤에서부터 카운트                
SELECT SUBSTR('HelloWorld', -4, 2) FROM dual;


--lower()
SELECT empno, ename, deptno
FROM EMP
WHERE LOWER(ename) = 'scott';

--upper()
SELECT empno, ename, deptno
FROM EMP
WHERE ename = UPPER('scott');

-- emp 테이블에서 blake라는 사람의 사원번호, 부서번호, 이름을 출력
SELECT empno, deptno, INITCAP(ENAME)  
FROM EMP
WHERE LOWER(ENAME) = 'blake'

-- INSTR
-- 사원의 이름 마지막 6번재 철자가 'R'인 사원의 이름을 검색
SELECT ENAME
FROM EMP
WHERE INSTR(ename, 'R')=6;

SELECT  ename
FROM EMP
WHERE INSTR(ename, 'TT') = 4;


-- 응용해서 시험 나온다
-- emp 테이블에서 사원의 이름이 T로 끝나는
-- SUBSTR(), INSTR(), LIKE() 3가지로 다 할 줄 알아야한다.
SELECT ENAME, JOB, HIREDATE 
FROM EMP
WHERE SUBSTR(ENAME, -1) = 'S';

SELECT ENAME, JOB, HIREDATE
FROM EMP
WHERE INSTR(ENAME, 'S', -1) = LENGTH(ENAME);

SELECT ENAME, JOB, HIREDATE
FROM EMP
WHERE ENAME LIKE '%S';

-- concat()
SELECT empno, ename, job, CONCAT(empno, ename) ENAME, 
CONCAT(ename, empno) e_empno, concat(ename, job) e_job
FROM EMP

-- LPAD, RPAD
SELECT LPAD('abc', 6, '*') FROM dual; --***abc
SELECT RPAD('abc', 6, '*') FROM dual; --abc***

-- LTRIM, RTRIM, TRIM
SELECT LTRIM('aaababaaa', 'aa') FROM dual; --babaaa
SELECT RTRIM('aaababaaa', 'a') FROM dual; --aaabab
--SELECT TRIM('aaababaaa, 'a') FROM dual; --error
SELECT TRIM('a' FROM 'aaababaaa') FROM dual; --bab FROM을 써야한다.

--TRIM은 양쪽 공백을 제거할때 주로 사용된다.
SELECT TRIM('   bab     ') FROM dual; -- bab
SELECT TRIM('   ba b     ') FROM dual; -- ba b 가운데 공백 제거는 불가능하다.

-- 가운데 공백을 제거하려면 어떻게 해야할까? replace
SELECT replace('     ba b     ', ' ', '') FROM dual; --bab

-- 숫자 함수
SELECT ROUND(45.926, 2) FROM dual; -- 45.93 소수점 2번째 자리까지 출력 3번째 자리에서 반올림
SELECT ROUND(45.926) FROM dual; -- 46 , 0 이 생략되있다. 
SELECT ROUND(45.926, 0) FROM dual; -- 46 위아 동일
SELECT ROUND(45.926, -1) FROM dual; -- 50 1의 자리에서 반올림
SELECT ROUND(45.926, -2) FROM dual; -- 0 10의 자리에서 반올림
 
SELECT TRUNC(45.926, 2) FROM dual; -- 45.92 버림
SELECT TRUNC(45.926) FROM dual; -- 45 , 0 이 생략
SELECT TRUNC(45.926, 0) FROM dual; -- 45 위와 같다
SELECT TRUNC(45.926, -1) FROM dual; -- 40 1의 자리를 버림한다.

-- MOD 나머지연산
SELECT SAL, MOD(SAL, 30)
FROM EMP
WHERE DEPTNO = 10;


-- 날짜 함수
/*
 * 날짜 + 숫자 = 날짜
 * 날짜 - 숫자 = 날짜
 * 날짜 - 날짜 = 숫자(기간)
 */
SELECT SYSDATE FROM DUAL; -- 2022-07-26 10:51:54.000
SELECT SYSDATE + 100 FROM DUAL; -- 2022-11-03 10:52:03.000
SELECT SYSDATE - 1 FROM DUAL; -- 2022-07-25 10:52:37.000

SELECT TRUNC(ABS(TO_DATE('2022-7-18', 'YYYY-MM-DD') - SYSDATE)) FROM DUAL; -- 8

-- 여러분이 지금까지 살아온 일생을 구하세요
SELECT TRUNC(ABS(TO_DATE('1996-4-15', 'YYYY-MM-DD') - SYSDATE)) FROM DUAL; -- 9,598

-- EMP 테이블에서 현재까지의 근무일수가 몇 주 몇 일인가를 조회한다.
SELECT ENAME, HIREDATE, SYSDATE , SYSDATE - HIREDATE "Total Days",
trunc((SYSDATE-HIREDATE)/7.0) Weeks,
ROUND(MOD((SYSDATE-HIREDATE), 7),0) Days
FROM EMP
ORDER BY SYSDATE - HIREDATE  DESC;

-- 아래 예제중에 한 문제(리뷰 안해줌)
-- EMP 테이블에서 10번 부서원이 현재까지의 근무 월수를 계산하여 조회한다. (69page 예제 1)
SELECT ENAME, HIREDATE, SYSDATE,
		MONTHS_BETWEEN(SYSDATE, HIREDATE) m_between, -- 근무 월수
		TRUNC(MONTHS_BETWEEN(SYSDATE, HIREDATE), 0) t_between -- 근무 월수 소수점 버림
FROM EMP
WHERE deptno = 10
ORDER BY MONTHS_BETWEEN(SYSDATE, HIREDATE) DESC;

SELECT ENAME, TRUNC(MONTHS_BETWEEN(SYSDATE,TO_DATE(HIREDATE,'RR/MM/DD'))) "근무개월" 
FROM EMP 
WHERE DEPTNO = 10 
ORDER BY HIREDATE ASC;

-- EMP 테이블에서 10번 부서원의 입사 일자로부터 5개월이 지난 후 날짜를 계산하여 출력하여라. (70page 예제 2)
SELECT ename, TO_DATE(HIREDATE,'RR/MM/DD'), ADD_MONTHS(TO_DATE(HIREDATE,'RR/MM/DD'), 5) a_month
FROM EMP
WHERE DEPTNO IN (10, 30)
ORDER BY HIREDATE DESC;

-- 오늘날짜가 1년 중 몇년째 주인지 조회한다.(단, 1월 1일 부터 첫째 일요일 까지를 1주차로 한다.) (74page 예제 2)
SELECT TO_CHAR(SYSDATE, 'WW') TEST -- WW: 일년 중의 주 W: 한달 중의 주
FROM DUAL;

-- EMP 테이블에서 20번 부서 중 입사 일자를 '1998년 1월 1일'의 형태로 출력하여라.(75page 예제 3)
SELECT ename, TO_DATE(HIREDATE,'RR/MM/DD'), to_char(TO_DATE(HIREDATE,'RR/MM/DD'), 'YYYY"년" MM"월" DD"일"') t_kor
FROM EMP
WHERE deptno = 20
ORDER BY TO_DATE(HIREDATE,'RR/MM/DD') DESC;

-- '201407'이라는 년월을 표시하는 문자값에서 15개월 후의 년을 문자로 표시해본다. (75page 예제 3)
SELECT TO_CHAR(ADD_MONTHS(TO_DATE('201407', 'YYYYMM'),15), 'YYYYMM') test1 FROM dual; --201510

-- 각 사원들의 이름, 입사일, 입사일로부터 여섯 달 경과 후 첫번째 일요일의 날짜를 년도4자리/월2자리/일자 형태로 나오도록 조회 (76page 예제7)
SELECT ename, TO_DATE(HIREDATE,'RR/MM/DD'), TO_CHAR(NEXT_DAY(ADD_MONTHS(TO_DATE(HIREDATE,'RR/MM/DD'),6),1), 'yyyy/month/dd')  "NEXT 6 Month"
FROM emp;

--to_number: <char>를 숫자로 변환하여 반환한다.

