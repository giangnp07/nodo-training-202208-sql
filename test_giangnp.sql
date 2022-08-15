create table giangnp_NXB
(
id number(7) not null constraint pk_giangnp_NXB primary key,
ma number(7),
ten varchar2(50),
trang_thai varchar2(10),
dia_chi varchar2(30),
mo_ta varchar2(30)
)
create table giangnp_TacGia
(
id number(7) not null constraint pk_giangnp_TacGia primary key,
ma number(7),
ten varchar2(50),
sdt varchar2(10),
dia_chi varchar2(30),
mo_ta varchar2(30)
)

create table giangnp_Sach
(
id number(7) not null constraint pk_giangnp_Sach primary key,
ma number(7),
ten varchar2(50),
id_NXB number(7) constraint fk_giangnp_Sach_giangnp_NXB references giangnp_NXB(id),
id_tg number(7) constraint fk_giangnp_Sach_giangnp_TacGia references giangnp_TacGia(id),
chu_de varchar2(30),
namXB date,
mo_ta varchar2(30),
sl_con number(10),
sl_muon number(10),
tong number(10)
)

create table giangnp_BanDoc
(
id number(7) not null constraint pk_giangnp_BanDoc primary key,
ma number(7),
ten varchar2(50),
sdt varchar2(10),
dia_chi varchar2(30),
ngay_sinh date,
ngay_tao_tK date,
hang varchar2(10)
)

create table pg_MuonSach
(
id number(7) not null constraint pk_pg_MuonSach primary key,
id_BanDoc number(7) constraint fk_pg_BanDoc_giangnp_MuonSach references giangnp_BanDoc(id),
id_Sach number(7)constraint fk_pg_MuonSach_giangnp_Sach references giangnp_Sach(id),
so_luong number(10),
ngay_muon date,
ngay_tra date,
trang_thai varchar2(30),
ghi_chu varchar2(30)
)
partition by range(ngay_muon)
(
partition th1_2 values less than(to_date('28/02/2022','dd-mm-yyyy')),
partition th3_4 values less than(to_date('30/04/2022','dd-mm-yyyy')),
partition th5_6 values less than(to_date('30/06/2022','dd-mm-yyyy')),
partition th7_8 values less than(to_date('30/08/2022','dd-mm-yyyy')),
partition th9_10 values less than(to_date('30/09/2022','dd-mm-yyyy')),
partition th11_12 values less than(to_date('30/10/2022','dd-mm-yyyy'))
)

--B. Yeu cau
--1.	Viết script tạo cấu trúc các bảng. Đối với bảng Mượn Sách cần đánh partition trên trường ngày giờ mượn, 
--và 2 local index: 1 index trên trường id bạn đọc, 1 index trên id sách. Tên indexes theo cấu trúc : TENBANG_IDX_TENTRUONG
--Tao unique
create unique index nxb_uni_ma on giangnp_NXB(ma)
create unique index tacgia_uni_ma on giangnp_TacGia(ma)
create unique index sach_uni_ma on giangnp_Sach(ma)
create unique index bandoc_uni_ma on giangnp_BanDoc(ma)

--Tao index
create index bandoc_idx_id on giangnp_bandoc(id)
create index sach_idx_id on giangnp_sach(id)


--2.	Viết script tạo sequence cho mỗi bảng. Sequence được dùng để insert trường Id cho các bảng. Tên sequence theo cấu trúc : TENBANG_SEQ
--bang giangnp_nxb
CREATE SEQUENCE nxb_seq
      INCREMENT BY 1
      START WITH 1
      MAXVALUE 1000
--Bang giannp_tacgia
      CREATE SEQUENCE tacgia_seq
      INCREMENT BY 1
      START WITH 1
      MAXVALUE 1000
--Bang sach
CREATE SEQUENCE sach_seq
      INCREMENT BY 1
      START WITH 1
      MAXVALUE 1000
--Bang bandoc
CREATE SEQUENCE bandoc_seq
      INCREMENT BY 1
      START WITH 1
      MAXVALUE 1000
      --Bang bandoc
CREATE SEQUENCE muonsach_seq
      INCREMENT BY 1
      START WITH 1
      MAXVALUE 1000
      
--3.	Viết script tạo unique index cho các bảng nếu có.

--4.	Viết script insert dữ liệu mẫu cho tất cả các bảng.
--Bang giangnp_nxb
select * from giangnp_nxb
insert into giangnp_nxb(id,ma,ten,trang_thai,dia_chi,mo_ta) 
values(nxb_seq.NEXTVAL,001,'Kim Dong','ACTIVE','Ha Noi','Khong co');
insert into giangnp_nxb(id,ma,ten,trang_thai,dia_chi,mo_ta) 
values(nxb_seq.NEXTVAL,002,'GDĐT','ACTIVE','Ha Noi','Khong co');
insert into giangnp_nxb(id,ma,ten,trang_thai,dia_chi,mo_ta) 
values(nxb_seq.NEXTVAL,003,'Ha Noi','ACTIVE','Ha Noi','Khong co');
insert into giangnp_nxb(id,ma,ten,trang_thai,dia_chi,mo_ta) 
values(nxb_seq.NEXTVAL,004,'Sao Mai','INACTIVE','Ha Noi','tam dung hoat dong');

--Bang giangnp_tg
select * from giangnp_tacgia
insert into giangnp_tacgia(id,ma,ten,sdt,dia_chi,mo_ta) 
values(tacgia_seq.NEXTVAL,001,'Nguyen Phuong Giang','0348294617','Phu Tho','Khong co');
insert into giangnp_tacgia(id,ma,ten,sdt,dia_chi,mo_ta) 
values(tacgia_seq.NEXTVAL,002,'Nguyen Phuong Anh','0348294617','Ha Nam','Khong co');
insert into giangnp_tacgia(id,ma,ten,sdt,dia_chi,mo_ta) 
values(tacgia_seq.NEXTVAL,003,'Nguyen Anh Thu','0348294617','Phu Tho','Khong co');
insert into giangnp_tacgia(id,ma,ten,sdt,dia_chi,mo_ta)
values(tacgia_seq.NEXTVAL,004,'Dam Van Viet','0348294617','Ha Noi','Khong co');
--Bang giangnp_sach
select * from giangnp_sach
insert into giangnp_sach(id,ma,ten,id_nxb,id_tg,
						chu_de,namxb,mo_ta,sl_con,sl_muon,tong)
				values(sach_seq.NEXTVAL,001,'Toan',2,2,
					  'Toan hoc',to_date('01/02/2022','dd-mm-yyyy'),'Toan nang cao',5,3,8);
insert into giangnp_sach(id,ma,ten,id_nxb,id_tg,
						chu_de,namxb,mo_ta,sl_con,sl_muon,tong)
				values(sach_seq.NEXTVAL,002,'Chi pheo',3,3,
					  'Van hoc',to_date('01/02/2022','dd-mm-yyyy'),'Van hoc VN',3,2,5);

--Bang giangnp_bandoc	
select * from giangnp_bandoc	
insert into giangnp_bandoc(id,ma,ten,sdt,dia_chi,ngay_sinh,
							ngay_tao_tk,hang)
values(bandoc_seq.nextval,001,'Nguyen Phuong Giang','0911202201','Phu Tho',to_date('07/08/2002','dd-mm-yyyy'),
	  to_date('09/08/2022','dd-mm-yyyy'),1);
insert into giangnp_bandoc(id,ma,ten,sdt,dia_chi,ngay_sinh,ngay_tao_tk,hang)
values(bandoc_seq.nextval,002,'Dam Van Viet','0911202201','Ha Noi',to_date('01/08/2002','dd-mm-yyyy'),
	  to_date('08/07/2022','dd-mm-yyyy'),2);
values(bandoc_seq.nextval,003,'Anh Thu','0911202201','Ha Noi',to_date('24/07/2022','dd-mm-yyyy'),
	  to_date('08/07/2022','dd-mm-yyyy'),2);
values(bandoc_seq.nextval,004,'Phuong Anh','0911202201','Ha Noi',to_date('24/07/2001','dd-mm-yyyy'),
	  to_date('08/07/2022','dd-mm-yyyy'),2);
--Bang pg_muonsach
select * from pg_muonsach
insert into pg_muonsach(id,id_bandoc,id_sach,so_luong,ngay_muon,
						ngay_tra,trang_thai,ghi_chu) 
values(muonsach_seq.nextval,2,3,1,to_date('01/08/2002','dd-mm-yyyy'),
	  to_date('12/08/2002','dd-mm-yyyy'),'da tra','khong');
insert into pg_muonsach(id,id_bandoc,id_sach,so_luong,ngay_muon,ngay_tra,trang_thai,ghi_chu) 
values(muonsach_seq.nextval,3,5,1,to_date('12/08/2002','dd-mm-yyyy'),
	   to_date('01/09/2002','dd-mm-yyyy'),'chua ta','khong');
insert into pg_muonsach(id,id_bandoc,id_sach,so_luong,ngay_muon,ngay_tra,trang_thai,ghi_chu) 
values(muonsach_seq.nextval,null,null,0,to_date('12/08/2002','dd-mm-yyyy'),
	   to_date('01/09/2002','dd-mm-yyyy'),'chua ta','khong');


--5.	Hiển thị dách sách tác giả và tổng số lượng sách của tác giả gồm các trường thông tin:
--Mã Tác Giả, Tên Tác Giả, Chủ Đề, Số Lượng Sách
--Sắp xếp theo số lượng sách giảm dần.
select * from giangnp_sach
select t.ten, sum(s.tong) sl from giangnp_tacgia t join giangnp_sach s on (t.id=s.id_tg) group by t.ten

--6.	Hiển thị 10 quyển sách có số lượng được mượn nhiều nhất gồm các trường thông tin:
--Mã Sách, Tên Sách, Tên Nhà Xuất Bản, Tên Tác Giả, Chủ Đề, Năm Xuất Bản, Số Lượng Còn Lại, Số Lượng Đã Mượn, Tổng Số
select *from (
    select *From giangnp_sach order by sl_muon
) where rownum <=10;

--7.	Hiển thị  thông tin bạn đọc và sách được mượn từ ngày đầu tháng hiện tại đến thời điểm hiện tại.
--Mã Bạn Đọc, Tên Bạn Đọc, Mã Sách, Tên Sách, Ngày Giờ Mượn, Số lượng
--Sắp xếp theo ngày giờ mượn giảm dần, Tên bạn đọc tăng dần.
select s.ma, m.ngay_muon, m.so_luong , d.ten from giangnp_sach s join pg_muonsach m on (s.id = m.id_sach) 
																 join giangnp_bandoc d on(d.id=m.id_bandoc) 
															      order by d.ten, m.ngay_muon desc
															      
--8.	Hiển thị 10 quyển sách có số lượng được mượn nhiều nhất tính từ đầu năm 2022
--Mã Sách, Tên Sách, Số Lượng Đã Được Mượn.
select *from (
    select s.ma, s.ten,s.sl_muon From giangnp_sach s join pg_muonsach m on(m.id_sach=s.id) 
    where m.ngay_muon> to_date('01/01/2002','dd-mm-yyyy') group by  s.ma, s.ten,s.sl_muon order by sum(sl_muon)
) where rownum <=10;
select * from giangnp_sach

--9.	Hiển thị danh sách bạn đọc và số lần mượn sách tính từ đầu năm 2022 sắp xếp theo tên bạn đọc tăng dần:
--Mã Bạn Đọc, Tên Bạn Đọc, Số Lần Mượn
select count (m.so_luong) slan, d.ma,d.ten from pg_muonsach m join giangnp_bandoc d on (d.id=m.id_bandoc) 
where m.ngay_muon> to_date('01/01/2002','dd-mm-yyyy') group by d.ten,d.ma

--10.	Hiển thị thông tin bạn đọc gồm có:
--Mã Bạn Đọc, Tên Bạn Đọc, Tuổi (được tính dựa vào trường ngày sinh)
select ma, ten, extract(year from sysdate) - extract(year from ngay_sinh) as Tuoi from giangnp_bandoc

--11.	Thống kê tổng số bạn đọc theo độ tuổi
--Tuổi, Tổng số Bạn Đọc
select * from pgiang_bandoc
select extract(year from sysdate) - extract(year from ngay_sinh) as tuoi, count(ma) as tong_so from pgiang_bandoc
group by ma,extract(year from sysdate) - extract(year from ngay_sinh)

--12.	Thống kê số lượng sách được xuất bản theo Nhà Xuất Bản, Theo năm xuất bản.
--Năm Xuất Bản, Mã Nhà Xuất Bản,Tên Nhà Xuất Bản, Số Lượng Sách
--Sắp xếp theo Năm xuất bản giảm dần, Tên Nhà xuất bản tăng dần.
select extract(year from  s.nam_xb) as nam, s.ma_nxb, t.ten ,s.tong as so_luong_sach from pgiang_sach s 
join pgiang_tacgia t on(t.ma =s.ma_tg)
order by extract(year from  s.nam_xb), t.ten desc

--13.	Hiển thị 5 quyển sách được các bạn đọc có độ tuổi từ 18 đến 25 mượn nhiều nhất tính từ đầu năm 2022. (Tính theo trường số lượng mượn của sách)
--Mã Sách, Tên Sách, Số Lượng Được Mượn
select * from(
select s.ma,s.ten,s.sl_muon from pgiang_sach s join muonsach m on(s.ma = m.ma_sach) 
join pgiang_bandoc b on (b.ma = m.ma_bandoc) 
where extract(year from sysdate) - extract(year from ngay_sinh) between 18 and 25
)where rownum <=5

--14.	Hiển thị toàn bộ bạn đọc và sách mà bạn đọc đấy mượn, sẽ có bạn chưa mượn vẫn cần hiển thị và tên sách để là null.
--Mã bạn đọc, tên ban đọc, tên sách
select b.ma,b.ten ten_ban_doc,s.ten ten_sach from pgiang_sach s join muonsach m on(m.ma_sach = s.ma) 
right join pgiang_bandoc b on (b.ma = m.ma_bandoc)



