--#################### 단일행 함수 실습 ###################
-- 1) 이름이 'adams' 인 직원의 급여와 입사일을 조회하시오.
SELECT
	sal,
	TO_CHAR(TO_DATE(hiredate, 'rr-mm-dd'), 'YYYY-MM-DD') 입사일
FROM
	emp
WHERE
	LOWER(ENAME) = LOWER('Adams');


-- 2) 'Adams의 입사일은 95/11/02 이고, 급여는 3000 입니다.' 이런 식으로 직원 정보를 조회하시오.
SELECT
	INITCAP(ename) || '의 입사일은 ' || TO_CHAR(TO_DATE(hiredate, 'rr-mm-dd'), 'YYYY-MM-DD') || ' 급여는' || sal || '입니다.' EmpInfo
FROM
	emp
WHERE
	LOWER(ENAME) = LOWER('Adams');

-- 3) 이름이 5글자 이하인 직원들의 이름, 급여, 입사일을 조회하시오.
SELECT
	ename,
	sal,
	TO_CHAR(TO_DATE(hiredate, 'rr-mm-dd'), 'YYYY-MM-DD')
FROM
	emp
WHERE
	LENGTH(ename) <= 5;


-- 4) 1987 년도에 입사한 직원의 이름, 입사일을 조회하시오.
SELECT
	ename,
	TO_CHAR(TO_DATE(hiredate, 'rr-mm-dd'), 'YYYY-MM-DD')
FROM
	emp
WHERE
	substr(TO_CHAR(TO_DATE(hiredate, 'rrrr-mm-dd'), 'yyyy-mm-dd'), 1, 4) = '1987';

-- 5) 7년 이상 장기 근속한 직원들의 이름, 입사일, 급여, 근무년차를 조회하시오.
SELECT
	ename,
	TO_CHAR(TO_DATE(hiredate, 'rrrr-mm-dd'), 'yyyy-mm-dd') 입사일,
	sal,
	TRUNC(MONTHS_BETWEEN(SYSDATE , TO_DATE(hiredate, 'RR/MM/DD')) / 12) 근속년차
FROM
	emp
WHERE
	TRUNC(MONTHS_BETWEEN(SYSDATE , TO_DATE(hiredate, 'RR/MM/DD')) / 12)  >= 7;


-- ##################  그룹 함수 실습 ######################
-- 1)  30번 부서 월급의 평균(소수2자리에서 내림, 소수점 한자리로 표기), 최고, 최저, 인원수를 구하여 출력하라.
SELECT TRUNC(AVG(SAL) , 1), MAX(SAL), MIN(SAL), COUNT(SAL)
FROM emp
WHERE DEPTNO = 30;

-- 2) 각 부서별 급여의 평균(반올림, 정수부분만 표기되도록), 최고, 최저, 인원수를 구하여 출력하라.
SELECT TRUNC(AVG(SAL)), MAX(SAL), MIN(SAL), COUNT(SAL)
FROM EMP
GROUP BY DEPTNO
ORDER BY DEPTNO;

-- 3) 각 부서별 같은 업무를 하는 사람의 인원수를 구하여 부서번호,업무명, 인원수를 출력하라.
SELECT
	deptno,
	job,
	count(DEPTNO)
FROM
	emp
GROUP BY
	DEPTNO, JOB 
ORDER BY
	DEPTNO;

-- 4) 같은 업무를 하는 사람의 수가 2명 이상인 업무와 인원수를  출력하라.
SELECT
	job,
	count(DEPTNO)
FROM
	emp
GROUP BY
	DEPTNO, JOB 
HAVING
	count(DEPTNO) >= 2
ORDER BY
	DEPTNO;


-- 5) 각 부서별 평균 월급(소수이하 버림), 전체 월급, 최고 월급, 최저 월급을 구하여 평균 월급이 많은 순으로 출력하라. 
SELECT
	TRUNC(AVG(SAL)) "평균 월급",
	SUM(SAL),
	MAX(SAL),
	MIN(SAL)
FROM
	emp
GROUP BY
	DEPTNO
ORDER BY
	"평균 월급" DESC;


-- 6) 각 부서별 같은 업무를 하는 사람의 급여의 합계를 구하여 부서번호,업무명, 급여합계를 출력하라.
-- 단, 부서별 급여합계도 같이 출력하라.
SELECT
	DEPTNO,
	JOB,
	SUM(SAL)
FROM
	emp e
GROUP BY
	ROLLUP(DEPTNO,
	JOB);


-- 7) 각 부서별 인원수를 조회하되 인원수가 5명 이상인 부서만 출력되도록 하시오.
SELECT
	deptno ,
	count(*)
FROM
	emp
GROUP BY
	deptno
HAVING
	count(*) >= 5;

-- 8)  각 부서별 최대급여와 최소급여를 조회하시오.
-- 단, 최대급여와 최소급여가 같은 부서는 직원이 한명일 가능성이 높기때문에 
-- 조회결과에서 제외시킨다.
SELECT
	MAX(SAL),
	MIN(SAL)
FROM
	emp
GROUP BY
	DEPTNO
HAVING
	MAX(sal) != MIN(sal);

-- 10) 부서가 10, 20, 30 번인 직원들 중에서 급여를 2500 이상 5000 이하를 받는
-- 직원들을 대상으로 부서별 평균 급여를 조회하시오.
-- 단, 평균급여가 2000 이상인 부서만 출력되어야 하며, 출력결과를 평균급여가 높은
-- 부서먼저 출력되도록 해야 한다.
SELECT deptno, avg(sal) 평균급여
FROM emp
WHERE sal BETWEEN 2500 AND 5000
GROUP BY DEPTNO 
HAVING avg(sal) >= 2000
ORDER BY 평균급여 desc;