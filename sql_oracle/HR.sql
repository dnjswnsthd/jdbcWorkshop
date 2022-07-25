select * from emp;
-- 비교 연산자 page 34
/*
emp 테이블에서 sal가 2500 ~ 3500 사이에 들어있는 사원의 이름과 sal를 검색
between 연산자
*/
select ename, sal from emp where sal >= 2500 and sal <= 3500;
select ename, sal from emp where sal between 2500 and 3000; -- between lower and higher (작은거 부터 안쓰면 데이터 안나옴)
/*
in 연산자
emp테이블에서 사원번호가 7369이거나 7521이거나 7782인 사원을 검색
*/
-- 1STEP 
SELECT * FROM emp WHERE empno = 7369;
SELECT * FROM emp WHERE empno = 7521;
SELECT * FROM emp WHERE empno = 7782;
-- 2STEP
SELECT * FROM emp WHERE empno = 7369 or empno = 7521 or empno = 7782;
-- 3STEP
SELECT * FROM emp WHERE empno in(7369, 7521, 7782);
/*
emp테이블에서 사원번호가 7369, 7521, 7782가 아닌 사원을 검색
*/
-- 2STEP
SELECT * FROM emp WHERE empno != 7369 and empno <> 7521 and empno != 7782;
-- 3STEP
SELECT * FROM emp WHERE empno not in(7369, 7521, 7782);

/*
와일드 카드(%, _)와 like 연산자
emp테이블에서 S로 이름이 시작되는 사원을 검색... 그 사원의 job도 검색
*/
select ename, job from emp where ename like 'S%';
-- emp테이블에서 이름에 S가 포함되는 사원을 검색... 그 사원의 job도 검색
select ename, job from emp where ename like '%S%';
-- emp테이블에서 사원의 이름 중에서 두번째가 M으로 끝나는 사원 검색
select ename, job from emp where ename like '_M%';
-- 입사년도가 82년도인 사원
select ename, job, hiredate from emp where hiredate like '82%';
