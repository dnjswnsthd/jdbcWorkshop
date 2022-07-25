select * from emp;
-- �� ������ page 34
/*
emp ���̺��� sal�� 2500 ~ 3500 ���̿� ����ִ� ����� �̸��� sal�� �˻�
between ������
*/
select ename, sal from emp where sal >= 2500 and sal <= 3500;
select ename, sal from emp where sal between 2500 and 3000; -- between lower and higher (������ ���� �Ⱦ��� ������ �ȳ���)
/*
in ������
emp���̺��� �����ȣ�� 7369�̰ų� 7521�̰ų� 7782�� ����� �˻�
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
emp���̺��� �����ȣ�� 7369, 7521, 7782�� �ƴ� ����� �˻�
*/
-- 2STEP
SELECT * FROM emp WHERE empno != 7369 and empno <> 7521 and empno != 7782;
-- 3STEP
SELECT * FROM emp WHERE empno not in(7369, 7521, 7782);

/*
���ϵ� ī��(%, _)�� like ������
emp���̺��� S�� �̸��� ���۵Ǵ� ����� �˻�... �� ����� job�� �˻�
*/
select ename, job from emp where ename like 'S%';
-- emp���̺��� �̸��� S�� ���ԵǴ� ����� �˻�... �� ����� job�� �˻�
select ename, job from emp where ename like '%S%';
-- emp���̺��� ����� �̸� �߿��� �ι�°�� M���� ������ ��� �˻�
select ename, job from emp where ename like '_M%';
-- �Ի�⵵�� 82�⵵�� ���
select ename, job, hiredate from emp where hiredate like '82%';
