 -- 그룹함수
-- NULL 값을 건너뛴다.
-- COUNT()
SELECT
	COUNT(*)
FROM
	EMP;
SELECT
	COUNT(-1)
FROM
	EMP;
SELECT
	COUNT(MGR)
FROM
	EMP; 

-- EMP테이블에서 부서 종류의 갯수
SELECT
	COUNT(DISTINCT deptno)
FROM
	emp;

-- 92page 예제 1
SELECT
	min(ename),
	max(ename),
	min(hiredate),
	max(hiredate)
FROM
	emp;

-- 92page 예제 2
SELECT
	avg(sal),
	max(sal),
	min(sal),
	sum(sal)
FROM
	emp
WHERE
	lower(job) = 'salesman';

-- EMP 테이블에서 총인원, 보너스 받는 인원수를 검색
SELECT
	COUNT(*) 총인원,
	COUNT(comm) "보너스 받는 인원",
	AVG(comm) "보너스 평균1"
FROM
	emp;

SELECT
	COUNT(*) 총인원,
	COUNT(comm) "보너스 받는 인원",
	ROUND(AVG(nvl(comm, 0)))"보너스 평균2"
FROM
	emp;

-- GROUP BY절
-- SELECT절에서 그룹함수에 적용되지 않는 컬럼은 반드시 GROUP BY절 뒤에 명시되어야 한다.
-- 1) 원래는 그룹이 하나
SELECT
	AVG(sal)
FROM
	emp;
-- 2) 지금은 세 그룹 -- 3) 정렬
SELECT
	deptno,
	ROUND(AVG(sal))
FROM
	emp
GROUP BY
	deptno
ORDER BY 	
	1;
-- 4) Alias 못씀
SELECT deptno DName, ROUND(AVG(sal)) AvgSalary
FROM emp
GROUP BY deptno -- Alias 못씀
ORDER  BY AvgSalary; -- Alias 쓸 수 있음(Alias가 더 좋다)


-- 95page 예제2
SELECT deptno, count(*), avg(sal), min(sal), max(sal), sum(sal)
FROM emp
GROUP BY deptno
ORDER BY sum(sal) DESC;

-- 96page 예제3
SELECT job, count(*), TRUNC(avg(sal)), sum(sal)
FROM emp
GROUP BY job;
-- 96page 예제4
SELECT job, deptno, count(*), avg(sal), sum(sal)
FROM emp
GROUP BY job, deptno;

-- emp테이블에서 각부서별 평균급여를 구하는데 그중에서 평균급여가 2000달러 이상인 사원의 평균급여를 검색...
-- where에서는 그룹함수 사용할 수 없다.
-- 실행 순서가 FROM -> WHERE -> GROUP BY -> HAVING -> SELECT -> ORDER BY이기 때문
SELECT deptno, TRUNC(avg(sal)) 평균급여
FROM emp
GROUP BY deptno
HAVING avg(sal) >= 2000;

-- 98PAGE 예제 1
SELECT deptno, count(*), SUM(sal) 
FROM emp
GROUP BY deptno
HAVING count(*) > 4

-- 98page 예제 2
SELECT deptno, avg(sal), sum(sal)
FROM emp
GROUP BY DEPTNO 
HAVING max(sal) > 2900;

-- 98page 예제 3
SELECT job, avg(sal), sum(sal)
FROM emp
GROUP BY job
HAVING avg(sal) >= 3000;

-- 99page 예제 5
SELECT deptno, avg(sal)
FROM emp
WHERE lower(job) = 'clerk'
GROUP BY DEPTNO 
HAVING avg(sal) > 1000;

-- 99page 예제 7
SELECT max(sum(sal))
FROM emp
GROUP BY deptno;

-- 입사년도별, 인원수 입사년도, 인원수로 alias
SELECT to_char(to_date(hiredate, 'rr-mm-dd'),'yyyy-mm-dd') 입사년도, count(to_date(hiredate, 'rr-mm-dd')) 인원수 
FROM EMP
GROUP BY HIREDATE;

-- 20번 부서에서 가장 먼저 입사한 사원
SELECT DEPTNO, MIN(TO_CHAR(HIREDATE, 'RR/MM/DD'))
FROM emp
GROUP BY DEPTNO
HAVING DEPTNO = 20;


-- ROLLUP : 소그룹의 합계를 계산하는 기능
-- GROUP BY 절로 묶인 각각의 소그룹 합계와 전체 합계 모두를 구하는 기능.
SELECT deptno, count(*), sum(sal)
FROM emp
GROUP BY ROLLUP (deptno);

SELECT deptno, job, sum(sal)
FROM emp
GROUP BY ROLLUP (deptno, job);

-- join 
SELECT *
FROM EMP;

SELECT *
FROM DEPT;

-- 1) 카테시안 결과 출력 (조인 조건을 안줬다.)
-- 15 *4  단순히 곱해서 결과 출력
SELECT * FROM emp,dept; --60라인

-- EQUI JOIN
-- 2) 조인 조건을 지정
SELECT * FROM emp, dept
WHERE emp.DEPTNO = dept.DEPTNO; --15라인 컬럼명을 직접 명시하여 불필요한 컬럼영이 노출되지 않도록

-- 3) 조인 조건을 지정 + 컬려명을 구체적으로 명시 4). 3) + 컬럼명 앞에 테이블을 지정 5) 3) + 4) 5) + 테이블 alias
SELECT e.EMPNO, e.ENAME, e.DEPTNO, d.DNAME , d.LOC
FROM EMP e , DEPT d
WHERE e.DEPTNO = d.DEPTNO;

-- 사원이름, 급여, 부서번호, 부서위치를 출력 단 급여가 2000달러 이상이고 부서가 30번
SELECT
	e.ENAME ,
	e.SAL,
	e.DEPTNO ,
	d.LOC
FROM
	EMP e,
	DEPT d
WHERE
	e.DEPTNO = d.DEPTNO
	AND e.sal >= 2000
	AND e.DEPTNO = 30;
	

SELECT e.EMPNO, e.ENAME, e.JOB, s.GRADE , s.LOSAL , s.HISAL 
FROM EMP e , SALGRADE s 
WHERE e.sal >s.LOSAL AND e.SAL <= s.HISAL ;



-- A, B 테이블을 조인할 경우, 조건에 맞지않는 데이터도 표시하고 싶을때 OUTER JOIN을 사용
-- 기본적인 조인방식은 INNER(공통적인 컬럼값만 표시하는 방법)
SELECT e.ENAME, e.DEPTNO "부서번호1", d.DEPTNO "부서번호2", d.DNAME 
FROM EMP e, DEPT d
WHERE e.DEPTNO = d.DEPTNO;
-- 1)
-- +는 데이터가 부족한 쪽에 붙인다.
SELECT e.ENAME, e.DEPTNO "부서번호1", d.DEPTNO "부서번호2", d.DNAME 
FROM EMP e, DEPT d
WHERE e.DEPTNO(+) = d.DEPTNO; -- 데이터가 없는 쪽에 +를 붙인다.
-- 2)
-- RIGHT JOIN(위와 같음)
SELECT e.ENAME, e.DEPTNO "부서번호1", d.DEPTNO "부서번호2", d.DNAME 
FROM EMP e RIGHT OUTER JOIN DEPT d 
ON e.DEPTNO = d.DEPTNO; -- 데이터가 있는 쪽을 기준으로 삼는다.


-- 123page 예제1
SELECT e.EMPNO , e.ENAME , e.JOB , e.DEPTNO e_deptno, d.DEPTNO d_deptno, d.DNAME 
FROM EMP e, DEPT d 
WHERE e.DEPTNO = d.DEPTNO ;

-- 124page 예제5
SELECT e.ENAME , e.SAL , e.DEPTNO , d.DEPTNO , d.DNAME 
FROM EMP e right OUTER join DEPT d 
ON e.DEPTNO = d.DEPTNO 
WHERE e.sal > 2000;

-- 125page 예제6 **
SELECT e.ENAME , e.SAL , e.DEPTNO , d.DEPTNO , d.DNAME 
FROM EMP e , DEPT d 
WHERE e.DEPTNO(+) = d.DEPTNO AND e.sal(+) > 2000;

--LEFT OUTER JOIN
SELECT (e.ename || '의 매니저는' || m.ename || '입니다.') INFO
FROM EMP e, EMP m
WHERE E.MGR = M.EMPNO(+)
ORDER BY 1;

SELECT (e.ename || '의 매니저는' || m.ename || '입니다.') INFO
FROM EMP e LEFT OUTER JOIN EMP m
ON E.MGR = M.EMPNO
ORDER BY 1;

-- FULL OUTER JOIN
-- 두 테이블 모두 한가씩 이상의 부족한 데이터를 가지고 있는 경우
CREATE TABLE outera (sawonid NUMBER(3)); -- 30이 없다.
CREATE TABLE outerb (sawonid NUMBER(3)); -- 40이 없다.

INSERT INTO outera VALUES(10);
INSERT INTO outera VALUES(20);
INSERT INTO outera VALUES(40);

INSERT INTO outerb VALUES(10);
INSERT INTO outerb VALUES(20);
INSERT INTO outerb VALUES(30);

SELECT sawonid FROM outera FULL OUTER JOIN outerb USING(sawonid);


-- SELF JOIN
/*
 * 1. 특정사원의 상사 이름을 검색.
 * 2. 먼저 특정사원을 EMP테이블에서 검색.. BLAKE
 * 3. BLAKE에 대한 상사번호를 검색....7839
 * -----------------------------------------
 * 4. 7839에 해당하는 사원번호를 검색
 * 5. 해당 사원번호의 이름을 검색
 */
SELECT
	*
FROM
	(SELECT EMPNO, ENAME, MGR FROM EMP) e,
	(SELECT	empno, ename FROM emp) m
WHERE 
	e.MGR = m.EMPNO ;


SELECT e.empno, e.ename 사원이름, m.ename 상사이름
FROM emp e, emp m
WHERE e.mgr = m.empno
AND e.ename = 'BLAKE';

