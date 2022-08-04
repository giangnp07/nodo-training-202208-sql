--Chương 2. LỆNH TRUY VẤN CƠ BẢN

--1. chon toan bo thong tin bang salgrade
select * from salgrade
--2. chon toan bo thong tin bang emp
select * from emp
--3. hien thi job
select distinct job from emp
--4. Hiển thị tên nhân viên và thu nhập trong một năm (REMUNERATION) 
select ename, sal*12 as REMUNERATION from emp
--5. Hiển thị theo nội dung dưới đây
--KING HAS HELP THE POSITION OF PRESIDENT IN DEPT 10 SINCE 17-11-1981
select ename || ' HAS HELP THE POSITION OF '||JOB||' IN DEPT '||DEPTNO||' SINCE '|| to_char(hiredate,'dd-mm-yyyy') from emp
--6. Cau truc bang
desc dept;
--7.Dinh dang va nhan
COLUMN ename HEADING 'Employee|Name' FORMAT A15 COLUMN sal JUSTIFY LEFT FORMAT $ 99,990.00



--Chương 3. TRUY VẤN DỮ LIỆU CÓ ĐIỀU KIỆN 
--1. Lương 1000->2000
select ename, deptno, sal from emp where sal between 1000 and 2000
--2. Hiển thị mã phòng ban, tên phòng ban, sắp xếp theo thứ tự tên phòng ban
select deptno, dname from dept order  by dname;
--3. Hiển thị danh sách những nhân viên làm tại phòng 10 và 20 theo thứ tự A,B,C
 select empno, ename,job,mgr, hiredate, sal, comm, deptno from emp where deptno IN (10,20)
 order by ename;
--4. Hiển thị tên và nghề nghiệp những nhân viên làm nghề thư ký (cleck) tại phòng 20. 
select ename, job from emp where job='cleck' and deptno =20
--5. Hiển thị tất cả những nhân viên mà tên có các ký tự TH và LL. 
select * from emp where ename like '%TH%' or ename like '%LL%'
--6. Hiển thị tên nhân viên, nghề nghiệp, lương của những nhân viên có giám đốc quản lý
select ename, job, sal from emp where job!='PRESIDENT'
--7. Hiển thị tên nhân viên, mã phòng ban, ngày gia nhập công ty sao cho gia nhập công 1983
select ename, deptno, hiredate from emp where EXTRACT(YEAR FROM hiredate) =1983
--8. Hiển thị tên nhân viên, lương một năm (ANUAL_SAL ), thưởng sao cho lương lớn hơn thưởng, 
--sắp theo thứ tự lương giảm dần và tên tăng dần.
select ename,sal*12 as ANUAL_SAL,comm from emp where sal > comm order by ename ,sal asc;



--Chương 4. CÁC HÀM SQL
--4.5.1. Hàm trên từng dòng dữ liệu
--1. Liệt kê tên nhân viên, mã phòng ban và lương nhân viên được tăng 15% (PCTSAL). 
select ename, deptno, (sal*0.15)+sal as PCTSAL from emp
--2.EMPLOYEE_AND_JOB 
select ename ||'*****' ||INITCAP(job) from emp
--3.EMPLOYEE 
select ename ||' ' ||'('|| INITCAP(job) ||')' from emp
--4.
select ename,deptno, INITCAP(job) from emp
--5.Tìm ngày thứ 6 đầu tiên cách 2 tháng so với ngày hiện tại 
select to_char(next_day(SYSDATE+15,'friday'),'dd month yyyy' ) FROM dual;
--6.. Tìm thông itn về tên nhân viên, ngày gia nhập công ty của nhân viên phòng số 20,
select ename, to_char(hiredate, 'month, ddspth yyyy') as DATE_HIRED  from emp where deptno =20
--7.. Hiển thị tên nhân viên, ngày gia nhập công ty, ngày xét nâng lương (sau ngày gia 1 nam)
select ename, to_char(hiredate,'dd-mm-yyyy') as HIREDATE, to_char(ADD_MONTHS(hiredate ,12) ,'dd-mm- yyyy') as REVIEW from emp
--8.Hiển thị tên nhân viên và lương dưới dạng 
select ename, (case when sal<=1500 then 'BElOW 1500'
					when sal > 1500 then 'On Target'
					ELSE 'On Target'
					end
 ) as SALARY  from emp
--9.. Cho biết thứ của ngày hiện tại 
select to_char(SYSDATE,'day') FROM dual;
--10
select decode('14/24','14/24','yes','01/1a','no','99\98','no','udefine') from dual;
--11
select ename, hiredate , next_day(hiredate+15,'friday') as A from emp where (SYSDATE-hiredate)>15


--4.5.2. Hàm trên nhóm dữ liệu 
--1.Tìm lương thấp nhất, lớn nhất và lương trung bình của tất cả các nhân viên 
select min(sal) as SalMin, max(sal) as SalMax, trunc(avg(sal),1) as SalVG from emp
--2.. Tìm lương nhỏ nhất và lớn của mỗi loại nghề nghiệp 
select  job,min(sal) as SalMin, max(sal) as SalMax from emp group by job
--3.Tìm xem có bao nhiêu giám đốc trong danh sách nhân viên. 
select count(empno) as Sum_PRESIDENT from emp where job='PRESIDENT'
--4. Tìm tất cả các phòng ban mà số nhân viên trong phòng >3 
select dname from dept d join emp e on(d.deptno=e.deptno) group by d.dname having count(empno) >3
--5.Tìm ra mức lương nhỏ nhất của mỗi nhân viên làm việc cho một giám đốc nào đó
select min(sal) as SalMin, job from emp where job!='MANAGER' group by job