--Chương 5. LỆNH TRUY VẤN DỮ LIỆU MỞ RỘNG
--1. Hiển thị toàn bộ tên nhân viên và tên phòng ban làm việc sắp xếp theo tên phòng
--ban. 
select ename, dname from emp join dept on (emp.deptno = dept.deptno) order by dname 
--2. Hiển thị tên nhân viên, vị trí địa lý, tên phòng với điều kiện lương >1500
--ENAME LOC DNAME 
select ename, loc, dname from emp e join dept d on (e.deptno = d.deptno) where e.sal >1500
--3. Hiển thị tên nhân viên, nghề nghiệp, lương và mức lương.
select ename, job, sal, grade from emp , salgrade 
--4. Hiển thị tên nhân viên, nghề nghiệp, lương và mức lương, với điều kiện mức lương=3.
select ename, job, sal, grade from emp, salgrade where grade=3
--5. Hiển thị những nhân viên tại DALLAS
select ename, loc, sal from emp e join dept d on (e.deptno = d.deptno) where loc ='DALLAS'
--6. Hiển thị tên nhân viên , nghề nghiệp, lương, mức lương, tên phòng làm việc trừ nhân
--viên có nghề là cleck và sắp xếp theo chiều giảm. 
select ename, job, sal, grade, loc from salgrade , emp e join dept d on e.deptno = d.deptno where job !='CLERK' order by sal 
--7. Hiển thị chi tiết về những nhân viên kiếm được 36000 $ 1 năm hoặc nghề là cleck.
--(gồm các trường tên, nghề, thu nhập, mã phòng, tên phòng, mức lương)
--ENAME JOB ANUAL_SAL DNAME GRA
select e.ename, e.job, e.sal,e.deptno, d.loc, grade from salgrade, emp e join dept d on e.deptno = d.deptno where e.sal >36000 or e.job='CLERK'
--8. Hiển thị những phòng không có nhân viên nào làm việc
select d.dname from dept d join emp e on e.deptno = d.deptno where d.deptno not in(select  e.deptno from emp)
--9. Hiển thị mã nhân viên, tên nhân viên, mã người quản lý, tên người quản lý
--EMP_NAME EMP_SAL MGR_NAME MGR_SAL 
select e.ename, e.empno, m.ename mgr_name, m.empno mgr_empno from emp e , emp m where e.mgr = m.empno
--10. Như câu 9 hiển thị thêm thông tin về ông KING. EMP_NAME EMP_SAL MGR_NAME MGR_SAL
select e.ename, e.empno, m.ename mgr_name, m.empno mgr_empno from emp e left join  emp m on e.mgr = m.empno
--11. Hiển thị nghề nghiệp được tuyển dụng vào năm 1981 và không được tuyển dụng vào
--năm 1994. 
select distinct job from emp where extract(year from hiredate) = 1981 and extract(year from hiredate) !=1994
--12. Tìm những nhân viên gia nhập công ty trước giám đốc của họ
select e.ename , m.ename  as name_mgr, to_char(e.hiredate, 'dd mm yyyy') as em_hiredate,to_char(m.hiredate, 'dd mm yyyy') as mgr_hiredate from emp e, emp m where e.mgr = m.empno and e.hiredate > m.hiredate
--13. Tìm tất cả các nhân viên, ngày gia nhập công ty, tên nhân viên, tên người giám đốc
--và ngày gia nhập công ty của người giám đốc ấy.
--EMP_NAME EMP_SAL MGR_NAME MGR_SAL 
select e.ename, e.sal as EMP_SAL, m.sal as MGR_SAL  from emp m , emp e where e.mgr = m.deptno
--14. Tìm những nhân viên kiếm được lương cao nhất trong mỗi loại nghề nghiệp.
--JOB MAX(SAL) 
select job, max(sal) as MAX_SAL  from emp group by job
--15. Tìm mức lương cao nhất trong mỗi phòng ban, sắp xếp theo thứ tự phòng ban.
--ENAME JOB DEPTNO SAL 
select ename, job, deptno from emp where sal in(select max(sal) from emp)
--16. Tìm nhân viên gia nhập vào phòng ban sớm nhất
--ENAME HIREDATE DEPTNO
select ename, hiredate, deptno from emp where hiredate in(select min(hiredate) from emp)
--17. Hiển thị những nhân viên có mức lương lớn hơn lương TB của phòng ban mà họ làm
--việc. 
--EMPNO ENAME SAL DEPT
select empno ,ename ,sal,emp.deptno From emp Join (Select deptno ,avg(Sal) avgsal From emp Group By deptno) avg_sal On emp.deptno=avg_sal.deptno Where sal > avg_sal.avgsal order by deptno;
--18. Hiển thị tên nhân viên, mã nhân viên, mã giám đốc, tên giám đốc, phòng ban làm
--việc của giám đốc, mức lương của giám đốc.
--EMP_NUMBER EMP_NAME EMP_SAL MGR_NUMBER MGR_NAME MGR_DEPT MGR_GRADE
select e.empno as EMP_NUMBER, e.ename as EMP_NAME,  m.ename as MGR_NAME, m.empno as MGR_NUMBER, m.deptno as MGR_GRADE from emp e, emp m, salgrade where e.mgr = m.deptno



--Chương 7. TABLE VÀ CÁC LỆNH SQL VỀ TABLE
--1. Tạo bảng PROJECT với các column được chỉ ra dưới đây, PROJID là promary key, và
--P_END_DATE > P_START_DATE.
--Column name Data Type Size.
--PROJID NUMBER 4
--P_DESC VARCHAR2 20
--P_START_DATE DATE
--P_END_DATE DATE
--BUDGET_AMOUNT NUMBER 7,2
--MAX_NO_STAFF NUMBER 2 
create table PROJECT_Giangnp
(
PROJID number(4) not null constraint pk_PROJECT_Giangnp primary key,
P_DESC varchar2(20),
P_START_DATE date,
P_END_DATE date,
BUDGET_AMOUNT number(7,2),
MAX_NO_STAFF number(2),
check(P_END_DATE>P_START_DATE)
);
--2. Tạo bảng ASSIGNMENTS với các column được chỉ ra dưới đây, đồng thời cột
--PROJID là foreign key tới bảng PROJECT, cột EMPNO là foreign key tới bảng EMP.
--Column name 	Data Type 	Size.
--PROJID 		NUMBER 		4 		NOT NULL
--EMPNO 		NUMBER 		4 		NOT NULL
--A_START_DATE 	DATE
--A_END_DATE 	DATE
--BILL_AMOUNT 	NUMBER 		4
create table ass_giangnp
(
PROJID number(4) not null constraint fk_ass_giangnp_PROJECT_Giangnp references PROJECT_Giangnp(PROJID),
EMPNO number(4) not null constraint fk_ass_giangnp_emp references emp(EMPNO),
A_START_DATE date,
A_END_DATE date,
BILL_AMOUNT number(4),
ASSIGN_TYPE varchar2(2)
);
--3. Thêm column COMMENTS kiểu LONG vào bảng PROJECTS. Thêm column HOURS kiểu
--NUMBER vào bảng ASSIGNMENTS.
alter table PROJECT_Giangnp (COMMENTS long)
alter table ass_giangnp add(HOURS number)
--4. Sử dụng view USER_OBJECTS hiển thị tất cả các đối tượng user sở hữu.
select * from USER_OBJECTS
--5. Thêm ràng buộc duy nhất (UNIQUE) cho 2 column PROJECT_ID và EMPNO của bảng
--ASSIGNMENTS.
alter table ass_giangnp modify (PROJID unique)
--6. Xem các thông tin về các ràng buộc trong USER_CONSTRAINTS. 
select * from  USER_CONSTRAINTS
--7. Xem trong USER hiện tại có tất cả bao nhiêu bảng.
select table_name from USER_tables


--Chương 8. CÁC LỆNH THAO TÁC DỮ LIỆU 
--1. Thêm dữ liệu vào bảng PROJECTS.
--PROJID 		1 					2
--P_DESC 		WRITE C030 COURSE 	PROOF READ NOTES
--P_START_DATE 	02-JAN-88 			01-JAN-89
--P_END_DATE 	07-JAN-88 			10-JAN-89
--BUDGET_AMOUNT 500 				600
--MAX_NO_STAFF 	1 					1
insert into PROJECT_Giangnp(PROJID,P_DESC,P_START_DATE,P_END_DATE,BUDGET_AMOUNT,MAX_NO_STAFF) values(1,'WRITE C030 COURSE','02-JAN-88','07-JAN-88',500,1);
insert into PROJECT_Giangnp(PROJID,P_DESC,P_START_DATE,P_END_DATE,BUDGET_AMOUNT,MAX_NO_STAFF) values(2,'PROOF READ NOTES','01-JAN-89','10-JAN-89',600,1);
insert into PROJECT_Giangnp(PROJID,P_DESC,P_START_DATE,P_END_DATE,BUDGET_AMOUNT,MAX_NO_STAFF) values(3,'PROOF READ NOTES','01-JAN-89','10-JAN-89',600,1)
--2. Thêm dữ liệu vào bảng ASSIGNMENTS.
--PROJID 		1 			1			 2
--EMPNO 		7369 		7902		7844
--A_START_DATE 	01-JAN-88 	04-JAN-88 	01-JAN-89
--A_END_DATE 	03-JAN-88 	07-JAN-88 	10-JAN-89
--BILL_Amount 	50.00 		55.00 		45.50
--ASSIGN_TYPE 	WR			WR 			PF
--HOURS 		15 			20 			30 
insert into ass_giangnp(PROJID,EMPNO,A_START_DATE,A_END_DATE,BILL_Amount,ASSIGN_TYPE,HOURS) values(1,7369,'01-JAN-88','03-JAN-88',50.00,'WR',15)
insert into ass_giangnp(PROJID,EMPNO,A_START_DATE,A_END_DATE,BILL_Amount,ASSIGN_TYPE,HOURS) values(1,7902,'04-JAN-88','07-JAN-88',55.00,'WR',20)
insert into ass_giangnp(PROJID,EMPNO,A_START_DATE,A_END_DATE,BILL_Amount,ASSIGN_TYPE,HOURS) values( 2,7844,'01-JAN-89','10-JAN-89',45.50,'WR',30)
--3. Cập nhật trường ASSIGN_TYPE từ WT thành WR. 
update ass_giangnp set ASSIGN_TYPE='WR'
--4. Nhập thêm số liệu vào bảng ASSIGNMENTS.
insert into ass_giangnp(PROJID,EMPNO,A_START_DATE,A_END_DATE,BILL_Amount,ASSIGN_TYPE,HOURS) values( 2,7001,'01-JAN-89','10-JAN-89',45.50,'WR',30)



--Chương 9. SEQUENCE VÀ INDEX
--1. Tạo Index trên cột PROJID cho bảng ASSIGNMENT.
create index PROJID_index on ass_giangnp(PROJID)
--2. Hiển thị danh sách của nhân viên thuộc sự quản lý của người có tên là 1 biến được nhập từ bàn phím
--EMPNO ENAME JOB MGR HIREDATE SAL COMM DEPTNO
select e.empno,e.ename,e.job,m.mgr,e.hiredate,e.sal,e.comm,e.deptno from emp e join emp m on e.mgr=m.empno
where m.mgr =(select mgr from emp where ename='&ename');