-- ##################  문자열 함수 실습 ######################
-- 1) 직원의 이름에 대소문자 상관없이 s가 들어간 직원의 모든 정보를 출력하라.
SELECT * 
FROM emp
WHERE LOWER(ename) LIKE '%s%';

SELECT * 
FROM emp
WHERE UPPER(ename) LIKE '%S%';

-- 2) 모든 직원들의 이름을 첫글자만 대문자로 변경하여 출력하라.
SELECT ename, INITCAP(ename)
FROM emp;

SELECT ename, UPPER(SUBSTR(ename, 1, 1)) || LOWER(SUBSTR(ename, 2)) "첫 문자 대문자"
FROM emp;

-- 3) 직원 정보 중 사원번호, 이름, 급여를 출력한다.  단, 이름은 앞에서 3글자씩만 출력하라.
SELECT empno, SUBSTR(ename, 1, 3) "앞에서 3글자 이름", sal
FROM emp;

-- 4) 이름의 글자수가 6자 이상인 사람의 이름을 앞에서 3자만 구하여 소문자로 이름만을 출력하라.
SELECT LOWER(ename) "소문자 이름"
FROM emp
WHERE LENGTH(ename) >= 6;

-- 5) 직원의 이름과 급여를 출력하라, 단, 금액의 정확도를 위해 급여를 6자리로 출력하고, 앞 여백을 모두 * 로 채워 출력하라.
SELECT ename, sal, LPAD(SAL, 6, '*')
FROM emp;


-- 6) 직원정보를 입력하던중 아래와 같이 입력 되었다.
insert into emp values(8001,'   PARK   ', 'IT' ,  7900 , '21/11/10', 20000,1000,10);
select * from emp;
-- 이름이 'PARK'인 직원의 정보를 출력하여 보자.
 SELECT *
 FROM emp
 WHERE ename = '   PARK   ';

-- 이름 좌우에 공백이 있더라도 공백을 제거하고 이름이 'PARK'인 직원의 정보를 출력하여 보자.
 SELECT *
 FROM emp
 WHERE TRIM(ename) = 'PARK';


-- ##################  숫자 함수 실습 ######################
-- 1) 급여가 $1,500부터 $3,000 사이의 사람은 급여의 15%를 회비로 지불하기로 하였다. 
-- 이를 이름, 급여, 회비(소수점 두 자리 아래에서 반올림)를 출력하라.
SELECT ename, sal, ROUND(sal*0.15, 1)회비
FROM emp
WHERE sal BETWEEN 1500 AND 3000

-- 2) 급여가 $2,000 이상인 모든 사람은 급여의 5%를 경조비로 내기로 하였다. 
-- 이름, 급여, 경조비(소수점 이하 절삭)를 출력하라.
SELECT ename, sal, TRUNC(sal*0.05) 회비
FROM emp
WHERE sal >= 2000;

SELECT ename, sal, TRUNC(sal*0.05, 0) 회비
FROM emp
WHERE sal >= 2000;
  

 -- 3) 이익을 배분하기 위해 comm의 150%를 보너스로 지급하려 한다. comm이 있는 직원들을 대상으로 
 -- 직원번호, 직원명, 급여, comm의 150%를 소숫점이하 올림하여 출력하라. (comm이 0이거나, null이면 제외)
SELECT empno, ename, sal, comm, FLOOR(comm * 1.5)
FROM emp
WHERE comm IS NOT NULL AND comm != 0;


-- ##################  날짜 함수 실습 ######################

-- 1)입사일로부터 100일이 지난 후를 구해보자. 사원이름, 입사일, 100일 후의 날, 급여를 출력하라.
SELECT ename, TO_CHAR(TO_DATE(hiredate, 'RR/MM/DD'), 'YYYY-MM-DD'), TO_CHAR(TO_DATE(hiredate, 'RR/MM/DD') + 100, 'YYYY-MM-DD') "100일 뒤", sal
FROM emp;

-- 2) 입사일로부터 6개월이 지난 후의 날짜를 구하려고 한다.  입사일, 6개월 후의 날짜, 급여를 출력하라
SELECT TO_CHAR(TO_DATE(hiredate, 'RR/MM/DD'), 'YYYY-MM-DD') 입사일, TO_CHAR(TO_DATE(ADD_MONTHS(hiredate, 6),'RR/MM/DD'), 'YYYY-MM-DD') "입사 후 6개월"
FROM emp;

-- 3) 입사일로부터 오늘까지의 일수를 구하여 이름, 입사일, 근무일수를 출력하라.
select ename, TO_CHAR(TO_DATE(hiredate, 'RR/MM/DD'), 'YYYY-MM-DD'), TRUNC(sysdate-TO_DATE(hiredate, 'RR/MM/DD')) 근무일수 
from emp;

-- 4) 직원의 이름, 근속년수를 구하여 출력하라.
SELECT ename, trunc(months_between(sysdate, TO_DATE(hiredate, 'RR/MM/DD')) /12) "근속년"
FROM emp;


-- ##################  변환 함수 실습 ######################

-- 1) 모든 직원의 이름과 입사일을 ‘1996-5-14’의 형태로 출력 하라.
SELECT ename, TO_CHAR(TO_DATE(hiredate, 'RR/MM/DD'), 'YYYY-MM-DD')
FROM emp;

-- 2) 모든 직원의 이름과 입사한 요일을 출력하라.
select ename, to_char(hiredate,'DAY') 입사요일 from emp;



-- ##################  일반 함수 실습 ######################

-- 1)  모든 직원의 이름, 급여, 커미션을 출력하라. 단, comm이 null이면 0으로 출력하라.
SELECT ename, sal, NVL(comm, 0) 
FROM emp

SELECT ename, sal, COALESCE(comm, 0) 
FROM emp


