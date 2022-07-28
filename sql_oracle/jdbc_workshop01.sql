-- 1) emp 테이블 정보를 확인하세요.
DESC emp;

-- 2) 부서번호가 20번인 부서의 사람 중 사원번호, 이름, 월급을 출력하세요.
SELECT EMPNO, ENAME, SAL 
FROM EMP
WHERE DEPTNO = 20;

-- 3) 사원번호가 7521인 사람 중 이름, 입사일, 부서번호를 출력하세요
SELECT ENAME, HIREDATE, DEPTNO 
FROM EMP
WHERE EMPNO = 7521;

-- 4) 이름이 JONES인 사람의 모든 정보를 출력하세요
SELECT *
FROM EMP
WHERE ENAME = 'JONES';

-- 5) 직업이 MANAGER인 사람의 모든 정보를 출력하세요
SELECT *
FROM EMP
WHERE JOB = 'MANAGER';

-- 6)직업이 MANAGER가 아닌 사람의 모든 정보를 출력하세요
SELECT *
FROM EMP
WHERE JOB != 'MANAGER';

-- 7) 급여가 $1000 이상인 사람의 이름, 급여, 부서번호를 출력하세요
SELECT ENAME, SAL, DEPTNO
FROM EMP
WHERE SAL >= 1000;

-- 8) 급여가 $1,600보다 크고 $3,000보다 작은 사람의 이름, 직업, 급여를 출력하세요.
SELECT ENAME, JOB, SAL
FROM EMP
WHERE SAL BETWEEN 1600 AND 3000;

-- 9) 입사일이 80년도인 사람의 모든 정보를 출력하세요
SELECT *
FROM EMP
WHERE HIREDATE LIKE '80%';

-- 10) 입사일이 81/12/09 보다 먼저 입사한 사람들의 모든 정보를 출력하세요.
SELECT *
FROM EMP
WHERE HIREDATE > '2081-12-09';

-- 11) 이름이 S로 시작하는 사원의 사원번호, 이름, 입사일, 급여을 출력하세요.
SELECT EMPNO, ENAME, HIREDATE, SAL
FROM EMP
WHERE ENAME LIKE 'S%';


-- 12) 이름 중 S자가 들어가 있는 사람만 모든 정보를 출력하세요.
SELECT EMPNO, ENAME, HIREDATE, SAL
FROM EMP
WHERE ENAME LIKE '%S%';

-- 13) 커미션이 NULL인 사람의 정보를 출력하세요.
SELECT *
FROM EMP
WHERE COMM IS NULL;

-- 14) 커미션이 NULL이 아닌 사람의 모든 정보를 출력하세요.
SELECT *
FROM EMP
WHERE COMM IS NOT NULL;

--15) 부서가 30번 부서이고 급여가 $1,500 이상인 사람의 이름, 부서 ,월급을 출력하세요.
SELECT e.ENAME, d.DNAME , e.SAL
FROM EMP e JOIN DEPT d 
ON(e.DEPTNO = d.DEPTNO) 
WHERE e.DEPTNO = 30 AND SAL >= 1500;

-- 16) 부서번호가 30인 사람 중 사원번호 순으로 정렬하세요.
SELECT *
FROM EMP
WHERE DEPTNO = 30
ORDER BY EMPNO;

-- 17) 급여가 많은 순으로 정렬하세요.
SELECT *
FROM EMP
ORDER BY SAL DESC;

-- 18) 부서번호로 ASCENDING 정렬한 후 급여는 많은 사람 순으로  출력하세요.
SELECT *
FROM EMP
ORDER BY DEPTNO ASC, sal DESC;

-- 19) emp Table에서 이름, 급여, 커미션 금액(sal*comm/100), 총액(sal + comm)을  구하여 총액이 많은 순서로 출력하세요. 
-- 단, 커미션이 NULL인 사람은 제외한다.
SELECT ENAME, SAL, (SAL*NVL(COMM, 0)/100) "커미션 금액", SAL + COMM 총액 
FROM EMP
WHERE COMM IS NOT NULL
ORDER BY SAL + COMM;

-- 20)  10번 부서의 모든 사람들에게 급여의 13%를 보너스로 지불하기로 하였다. 이름, 급여, 보너스 금액, 부서번호를 출력하세요.
SELECT ENAME, SAL, SAL * 1.13 "보너스 금액", DEPTNO
FROM EMP

