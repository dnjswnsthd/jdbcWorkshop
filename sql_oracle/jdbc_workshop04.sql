-- ### equi join ###

-- 1.  emp와 dept Table을 JOIN하여 부서번호, 부서명, 이름, 급여를  출력하라.
SELECT e.DEPTNO, d.DNAME , e.ENAME , e.SAL
FROM EMP e , DEPT d
WHERE
	e.DEPTNO = d.DEPTNO;

-- 2.  이름이 ‘SMITH’인 사원의 부서명을 출력하라.
SELECT d.DNAME
FROM EMP e, DEPT d
WHERE e.DEPTNO = d.DEPTNO AND e.ENAME = 'SMITH';

--  ### Non Equi join ###
--3. 사원번호, 이름 ,업무, 급여, 급여의 등급, 하한 값, 상한 값을 출력하라.
SELECT EMPNO, ENAME, JOB, SAL, s.GRADE, s.LOSAL, s.HISAL
FROM EMP e, SALGRADE s;

-- ### outer join ###
-- 4.  dept Table에 있는 모든 부서를 출력하고, emp Table에 있는 DATA와 JOIN하여 모든 사원의 이름, 부서번호, 부서명, 급여를 출력 하라.
SELECT e.ename, e.DEPTNO, d.DNAME, e.SAL
FROM EMP e, DEPT d
WHERE e.DEPTNO(+) = d.DEPTNO;

-- ###self join###
-- 5.  emp Table에 있는 empno와 mgr을 이용하여 서로의 관계를 다음과 같이 출력하라.
-- ‘SMTH의 매니저는 FORD이다’
SELECT e.ename || '의 매니저는' || m.ENAME || '이다.'
FROM EMP e ,EMP m
WHERE e.mgr = m.EMPNO;

-- ### join 실습 ###

-- 1. 관리자가 7698인 사원의 이름, 사원번호, 관리자번호, 관리자명을 출력하라.
SELECT E.ENAME, E.DEPTNO, E.MGR, M.ENAME 
FROM  EMP e, EMP M
WHERE E.MGR = M.EMPNO AND E.MGR = 7698;

-- 2. 업무가 MANAGER이거나 CLERK인 사원의 사원번호, 이름, 급여, 업무, 부서명
SELECT e.EMPNO , e.ENAME, e.SAL , e.JOB , d.DNAME 
FROM EMP e, DEPT d 
WHERE e.DEPTNO = d.DEPTNO AND (e.JOB = 'MANAGER' OR e.JOB = 'CLERK');

-- ### SubQuery ###
-- 1.  ‘SMITH'의 직무와 같은 사람의 이름, 부서명, 급여, 직무를  출력하라.
SELECT e.ENAME , d.DNAME , e.SAL , e.JOB 
FROM EMP e, DEPT d 
WHERE e.DEPTNO = d.DEPTNO AND e.JOB = (SELECT JOB FROM emp WHERE ENAME = 'SMITH');

-- 2.  ‘JONES’가 속해있는 부서의 모든 사람의 사원번호, 이름, 입사일, 급여를 출력하라.
SELECT EMPNO , ENAME , TO_CHAR(TO_DATE(HIREDATE, 'RR-MM-DD'), 'YYYY-MM-DD')
FROM emp 
WHERE DEPTNO = (SELECT DEPTNO FROM emp WHERE ENAME = 'JONES');


-- 3.  전체 사원의 평균급여보다 급여가 많은 사원의 사원번호, 이름,부서명, 입사일, 지역, 급여를 출력하라.
SELECT e.EMPNO, e.ENAME , d.DEPTNO , TO_CHAR(TO_DATE(HIREDATE, 'RR-MM-DD'), 'YYYY-MM-DD') , d.LOC , e.SAL 
FROM EMP e , DEPT d 
WHERE e.SAL > (SELECT avg(sal) FROM emp)

-- 4. 10번 부서와 같은 일을 하는 사원의 사원번호, 이름, 부서명,지역, 급여를 급여가 많은 순으로 출력하라.
SELECT e.EMPNO , e.ENAME , d.DNAME , d.LOC , e.SAL 
FROM EMP e , DEPT d 
WHERE e.DEPTNO = d.DEPTNO AND e.JOB IN (SELECT job FROM emp WHERE DEPTNO = 10)
ORDER BY SAL desc;


-- 5.  10번 부서 중에서 30번 부서에는 없는 업무를 하는 사원의 사원번호, 이름, 부서명, 입사일, 지역을 출력하라.
SELECT e.EMPNO , e.ENAME , d.DNAME , TO_CHAR(TO_DATE(HIREDATE, 'RR-MM-DD'), 'YYYY-MM-DD'), d.LOC 
FROM EMP e , DEPT d 
WHERE e.DEPTNO = d.DEPTNO AND e. DEPTNO  = 10 AND e.JOB NOT IN (SELECT JOB FROM emp WHERE DEPTNO = 30);


--6.  ‘KING’이나 ‘JAMES'의 급여와 같은 사원의 사원번호, 이름,급여를 출력하라.
SELECT EMPNO, ENAME, SAL
FROM EMP e 
WHERE sal = (SELECT sal FROM EMP e2 WHERE ENAME= 'KING') OR sal = (SELECT sal FROM EMP e2 WHERE ENAME= 'JAMES');

-- 7.  급여가 30번 부서의 최고 급여보다 높은 사원의 사원번호,이름, 급여를 출력하라.
SELECT EMPNO, ENAME, SAL
FROM EMP
WHERE SAL > (SELECT MAX(SAL) FROM EMP WHERE DEPTNO = 30);