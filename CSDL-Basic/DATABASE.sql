Create Database QuanLyTruongHoc
Go

Use QuanLyTruongHoc
Go
	

Create Table THAMGIADT
(
		MAGV nchar(3),
		MADT nchar(4),
		STT int,
		PHUCAP float,
		KETQUA nvarchar(10),
		Primary Key (MAGV,MADT,STT)
)
go
	
Create Table KHOA
(
		MAKHOA nchar (4),
		TENKHOA nvarchar (50),
		NAMTL int,
		PHONG char(3),
		DIENTHOAI char(10),
		TRUONGKHOA nchar(3),
		NGAYNHANCHUC datetime,
		primary key (MAKHOA)
)
go
	
create table BOMON
(
		MABM nchar(4),
		TENBM nchar (50),
		PHONG char(3),
		DIENTHOAI char(11),
		TRUONGBM nchar(3),
		MAKHOA nchar (4),
		NGAYNHANCHUC date,
		primary key (MABM)
)
go
	
create table CONGVIEC 
(
		MADT nchar(4),
		SOTT int,
		TENCV nvarchar(50),
		NGAYBD datetime,
		NGAYKT datetime,
		primary key (MADT,SOTT)
)
go
	
create table DETAI
(
		MADT nchar(4),
		TENDT nvarchar(50),
		CAPQL nchar(20),
		KINHPHI float,
		NGAYBD date,
		NGAYKT date,
		MACD nchar(4),
		GVCNDT nchar(3),
		primary key (MADT)
)
go
create table CHUDE
(
		MACD nchar(4),
		TENCD nvarchar(30),
		primary key (MACD)
)
go
	

create table GIAOVIEN
(
		MAGV nchar(3),
		HOTEN nvarchar(50),
		LUONG float,
		PHAI nchar(3),
		NGSINH date,
		DIACHI nchar(50),
		GVQLCM nchar(3),
		MABM nchar(4),
		primary key (MAGV)
)
go
	
create table NGUOITHAN
(
		MAGV nchar(3),
		TEN nchar(12),
		NGSINH datetime,
		PHAI nchar(3),
		primary key (MAGV,TEN)
)
go

	
create table GV_DT
(
		MAGV nchar(3),
		DIENTHOAI char (10),
		primary key (MAGV,DIENTHOAI)
)
go
	
-- 3/ Tạo khoá ngoại
--Tạo khoá ngoại ở bảng THAMGIADT
Alter table THAMGIADT
	add constraint FK_HG1_MADT
	foreign key (MADT, STT)
	references CONGVIEC(MADT,SOTT)
go
		
--Tạo khóa ngoại ở bảng CONGVIEC
Alter table CONGVIEC
	add constraint FK_HG2_MADT
	foreign key (MADT)
	references DETAI(MADT)
go
		
--Tạo khóa ngoại ở bảng DETAI
Alter table DETAI
	add constraint FK_HG3_MACD
	foreign key (MACD)
	references CHUDE(MACD)
go
		
--Tạo khóa ngoại ở bảng DETAI
Alter table DETAI
		add constraint FK_HG4_GVCNDT
		foreign key (GVCNDT)
		references GIAOVIEN(MAGV)
go
		
--Tạo khóa ngoại ở bảng THAMGIADT
Alter table THAMGIADT
	add constraint FK_HG5_MAGV
	foreign key (MAGV)
	references GIAOVIEN(MAGV)
go
		
--Tạo khóa ngoại ở bảng GIAOVIEN
Alter table GIAOVIEN
	add constraint FK_HG6_GVQLCM
	foreign key (GVQLCM)
	references GIAOVIEN(MAGV)
go
			
--Tạo khóa ngoại ở bảng KHOA
Alter table KHOA
	add constraint FK_HG7_TRUONGKHOA
	foreign key (TRUONGKHOA)
	references GIAOVIEN(MAGV)
go
		
--Tạo khóa ngoại ở bảng NGUOITHAN
Alter table NGUOITHAN
    add constraint FK_HG8_MAGV
	foreign key (MAGV)
	references GIAOVIEN(MAGV)
go
		
--Tạo khóa ngoại ở bảng GIAOVIEN
Alter table GIAOVIEN
	add constraint FK_HG9_MABM
	foreign key (MABM)
	references BOMON(MABM)
go
		
--Tạo khóa ngoại ở bảng BOMON
Alter table BOMON
	add constraint FK_HG10_MAKHOA
	foreign key (MAKHOA)
	references KHOA(MAKHOA)
go
		
--Tạo khóa ngoại ở bảng BOMON
Alter table BOMON
	add constraint FK_HG11_TRUONGBM
	foreign key (TRUONGBM)
	references GIAOVIEN(MAGV)
go
		
--Tạo khóa ngoại ở bảng GV_DT
Alter table GV_DT
	add constraint FK_HG12_MAGV
	foreign key (MAGV)
	references GIAOVIEN(MAGV)
go
		
--  Nhập data
--Nhập data cho bảng CHUDE
	Insert Into CHUDE(MACD,TENCD)
	values ('NCPT', N'Nghiên cứu phát triển')
	Insert Into CHUDE(MACD,TENCD)
	values ('QLGD', N'Quản lý giáo dục')
	Insert Into CHUDE(MACD,TENCD)
	values ('UDCN', N'Ứng dụng công nghệ')
	go
	
--Nhập data cho bảng GIAOVIEN
	Insert Into GIAOVIEN(MAGV,HOTEN,LUONG,PHAI,NGSINH,DIACHI, )
	values ('001',N'Nguyễn Hoài An',2000.0,N'Nam','1973-02-15',N'25/3 Lạc Long Quân, Q.10,TP HCM')
	Insert Into GIAOVIEN(MAGV,HOTEN,LUONG,PHAI,NGSINH,DIACHI)
	values ('002',N'Trần Trà Hương',2500.0,N'Nữ','1960-06-20',N'125 Trần Hưng Đạo, Q.1, TP HCM')
	Insert Into GIAOVIEN(MAGV,HOTEN,LUONG,PHAI,NGSINH,DIACHI,GVQLCM)
	values ('003',N'Nguyễn Ngọc Ánh',2200.0,N'Nữ','1975-05-11',N'12/21 Võ Văn Ngân Thủ Đức, TP HCM',N'002')
	Insert Into GIAOVIEN(MAGV,HOTEN,LUONG,PHAI,NGSINH,DIACHI)
	values ('004',N'Trương Nam Sơn',2300.0,N'Nam','1959-06-20',N'215 Lý Thường Kiệt,TP Biên Hòa')
	Insert Into GIAOVIEN(MAGV,HOTEN,LUONG,PHAI,NGSINH,DIACHI)
	values ('005',N'Lý Hoàng Hà',2500.0,N'Nam','1954-10-23',N'22/5 Nguyễn Xí, Q.Bình Thạnh, TP HCM')
	Insert Into GIAOVIEN(MAGV,HOTEN,LUONG,PHAI,NGSINH,DIACHI,GVQLCM)
	values ('006',N'Trần Bạch Tuyết',1500.0,N'Nữ','1980-05-20',N'127 Hùng Vương, TP Mỹ Tho',N'004')
	Insert Into GIAOVIEN(MAGV,HOTEN,LUONG,PHAI,NGSINH,DIACHI)
	values ('007',N'Nguyễn An Trung',2100.0,N'Nam','1976-06-05',N'234 3/2, TP Biên Hòa')
	Insert Into GIAOVIEN(MAGV,HOTEN,LUONG,PHAI,NGSINH,DIACHI,GVQLCM)
	values ('008',N'Trần Trung Hiếu',1800.0,N'Nam','1977-08-06',N'22/11 Lý Thường Kiệt,TP Mỹ Tho',N'007')
	Insert Into GIAOVIEN(MAGV,HOTEN,LUONG,PHAI,NGSINH,DIACHI,GVQLCM)
	values ('009',N'Trần Hoàng nam',2000.0,N'Nam','1975-11-22',N'234 Trấn Não,An Phú, TP HCM',N'001')
	Insert Into GIAOVIEN(MAGV,HOTEN,LUONG,PHAI,NGSINH,DIACHI,GVQLCM)
	values ('010',N'Phạm Nam Thanh',1500.0,N'Nam','1980-12-12',N'221 Hùng Vương,Q.5, TP HCM',N'007')
	go
	
--Nhập data cho bảng DETAI
	Insert Into DETAI(MADT,TENDT,CAPQL,KINHPHI,NGAYBD,NGAYKT,MACD,GVCNDT)
	values ('001',N'HTTT quản lý các trường ĐH',N'ĐHQG',20.0,'2007-10-20','2008-10-20',N'QLGD','002')
	Insert Into DETAI(MADT,TENDT,CAPQL,KINHPHI,NGAYBD,NGAYKT,MACD,GVCNDT)
	values ('002',N'HTTT quản lý giáo vụ cho một Khoa',N'Trường',20.0,'2000-10-12','2001-10-12',N'QLGD','002')
	Insert Into DETAI(MADT,TENDT,CAPQL,KINHPHI,NGAYBD,NGAYKT,MACD,GVCNDT)
	values ('003',N'Nghiên cứu chế tạo sợi Nanô Platin',N'ĐHQG',300.0,'2008-05-15','2010-05-15',N'NCPT','005')
	Insert Into DETAI(MADT,TENDT,CAPQL,KINHPHI,NGAYBD,NGAYKT,MACD,GVCNDT)
	values ('004',N'Tạo vật liệu sinh học bằng màng ối người',N'Nhà nước',100.0,'2007-01-01','2009-12-31',N'NCPT','004')
	Insert Into DETAI(MADT,TENDT,CAPQL,KINHPHI,NGAYBD,NGAYKT,MACD,GVCNDT)
	values ('005',N'Ứng dụng hóa học xanh',N'Trường',200.0,'2003-10-10','2004-12-10',N'UDCN','007')
	Insert Into DETAI(MADT,TENDT,CAPQL,KINHPHI,NGAYBD,NGAYKT,MACD,GVCNDT)
	values ('006',N'Nghiên cứu tế bào gốc',N'Nhà nước',4000.0,'2006-10-12','2009-10-12',N'NCPT','004')
	Insert Into DETAI(MADT,TENDT,CAPQL,KINHPHI,NGAYBD,NGAYKT,MACD,GVCNDT)
	values ('007',N'HTTT quản lý thư viện ở các trường ĐH',N'Trường',20.0,'2009-05-10','2010-05-10',N'QLGD','001')
	go
	
--Nhập data cho bảng CONGVIEC
	Insert Into CONGVIEC(MADT,SOTT,TENCV,NGAYBD,NGAYKT)
	values ('001',1,N'Khởi tạo và Lập kế hoạch','2007-10-20','2008-12-20')
	Insert Into CONGVIEC(MADT,SOTT,TENCV,NGAYBD,NGAYKT)
	values ('001',2,N'Xác định yêu cầu','2008-12-21','2008-03-21')
	Insert Into CONGVIEC(MADT,SOTT,TENCV,NGAYBD,NGAYKT)
	values ('001',3,N'Phân tích hệ thống','2008-03-22','2008-05-22')
	Insert Into CONGVIEC(MADT,SOTT,TENCV,NGAYBD,NGAYKT)
	values ('001',4,N'Thiết kế hệ thống','2008-05-23','2008-06-23')
	Insert Into CONGVIEC(MADT,SOTT,TENCV,NGAYBD,NGAYKT)
	values ('001',5,N'Cài đặt thử nghiệm','2008-06-24','2008-10-20')
	Insert Into CONGVIEC(MADT,SOTT,TENCV,NGAYBD,NGAYKT)
	values ('002',1,N'Khởi tạo và lập kế hoạch','2009-05-10','2009-07-10')
	Insert Into CONGVIEC(MADT,SOTT,TENCV,NGAYBD,NGAYKT)
	values ('002',2,N'Xác định yêu cầu','2009-07-11','2009-10-11')
	Insert Into CONGVIEC(MADT,SOTT,TENCV,NGAYBD,NGAYKT)
	values ('002',3,N'Phân tích hệ thống','2009-10-12','2009-12-20')
	Insert Into CONGVIEC(MADT,SOTT,TENCV,NGAYBD,NGAYKT)
	values ('002',4,N'Thiết kế hệ thống','2009-12-21','2010-03-22')
	Insert Into CONGVIEC(MADT,SOTT,TENCV,NGAYBD,NGAYKT)
	values ('002',5,N'Cài đặt thử nghiệm','2010-03-23','2010-05-10')
	Insert Into CONGVIEC(MADT,SOTT,TENCV,NGAYBD,NGAYKT)
	values ('006',1,N'Lấy mẫu','2006-10-20','2007-02-20')
	Insert Into CONGVIEC(MADT,SOTT,TENCV,NGAYBD,NGAYKT)
	values ('006',2,N'Nuôi cấy','2007-02-21','2008-09-21')
	go
	
--Nhập data cho bảng THAMGIADT
	Insert Into THAMGIADT(MAGV,MADT,STT,PHUCAP)
	values ('001','002',1,0.0)
	Insert Into THAMGIADT(MAGV,MADT,STT,PHUCAP)
	values ('001','002',2,2.0)
	Insert Into THAMGIADT(MAGV,MADT,STT,PHUCAP,KETQUA)
	values ('002','001',4,2.0,N'Đạt')
	Insert Into THAMGIADT(MAGV,MADT,STT,PHUCAP,KETQUA)
	values ('003','001',1,1.0,N'Đạt')
	Insert Into THAMGIADT(MAGV,MADT,STT,PHUCAP,KETQUA)
	values ('003','001',2,0.0,N'Đạt')
	Insert Into THAMGIADT(MAGV,MADT,STT,PHUCAP,KETQUA)
	values ('003','001',4,1.0,N'Đạt')
	Insert Into THAMGIADT(MAGV,MADT,STT,PHUCAP)
	values ('003','002',2,0.0)
	Insert Into THAMGIADT(MAGV,MADT,STT,PHUCAP,KETQUA)
	values ('004','006',1,0.0,N'Đạt')
	Insert Into THAMGIADT(MAGV,MADT,STT,PHUCAP,KETQUA)
	values ('004','006',2,1.0,N'Đạt')
	Insert Into THAMGIADT(MAGV,MADT,STT,PHUCAP,KETQUA)
	values ('006','006',2,1.5,N'Đạt')
	Insert Into THAMGIADT(MAGV,MADT,STT,PHUCAP)
	values ('009','002',3,0.5)
	Insert Into THAMGIADT(MAGV,MADT,STT,PHUCAP)
	values ('009','002',4,1.5)
	go
	
--Nhập data cho bảng KHOA
	Insert Into KHOA(MAKHOA,TENKHOA,NAMTL,PHONG,DIENTHOAI,TRUONGKHOA,NGAYNHANCHUC)
	values (N'CNTT',N'Công nghệ thông tin',1995,'B11','0838123456','002','2005-02-20')
	Insert Into KHOA(MAKHOA,TENKHOA,NAMTL,PHONG,DIENTHOAI,TRUONGKHOA,NGAYNHANCHUC)
	values (N'HH',N'Hóa học',1980,'B41','0838456456','007','2001-10-15')
	Insert Into KHOA(MAKHOA,TENKHOA,NAMTL,PHONG,DIENTHOAI,TRUONGKHOA,NGAYNHANCHUC)
	values (N'SH',N'Sinh học',1980,'B31','0838454545','004','2000-10-11')
	Insert Into KHOA(MAKHOA,TENKHOA,NAMTL,PHONG,DIENTHOAI,TRUONGKHOA,NGAYNHANCHUC)
	values (N'VL',N'Vật lý',1976,'B21','0838223223','005','2003-09-18')
	go
	
--Nhập data cho bảng NGUOITHAN
	Insert Into NGUOITHAN(MAGV,TEN,NGSINH,PHAI)
	values ('001',N'Hùng','1990-01-14',N'Nam')
	Insert Into NGUOITHAN(MAGV,TEN,NGSINH,PHAI)
	values ('001',N'Thủy','1994-12-08',N'Nữ')
	Insert Into NGUOITHAN(MAGV,TEN,NGSINH,PHAI)
	values ('003',N'Hà','1998-09-03',N'Nữ')
	Insert Into NGUOITHAN(MAGV,TEN,NGSINH,PHAI)
	values ('003',N'Thu','1998-09-03',N'Nữ')
	Insert Into NGUOITHAN(MAGV,TEN,NGSINH,PHAI)
	values ('007',N'Mai','2003-03-26',N'Nữ')
	Insert Into NGUOITHAN(MAGV,TEN,NGSINH,PHAI)
	values ('007',N'Vy','2000-02-14',N'Nữ')
	Insert Into NGUOITHAN(MAGV,TEN,NGSINH,PHAI)
	values ('008',N'Nam','1991-05-06',N'Nam')
	Insert Into NGUOITHAN(MAGV,TEN,NGSINH,PHAI)
	values ('009',N'An','1996-08-19',N'Nam')
	Insert Into NGUOITHAN(MAGV,TEN,NGSINH,PHAI)
	values ('010',N'Nguyệt','2006-01-14',N'Nữ')
	go
	
--Nhập data cho bảng GV_DT
	Insert Into GV_DT(MAGV,DIENTHOAI)
	values ('001','0838912112')
	Insert Into GV_DT(MAGV,DIENTHOAI)
	values ('001','0903123123')
	Insert Into GV_DT(MAGV,DIENTHOAI)
	values ('002','0913454545')
	Insert Into GV_DT(MAGV,DIENTHOAI)
	values ('003','0838121212')
	Insert Into GV_DT(MAGV,DIENTHOAI)
	values ('003','0903656565')
	Insert Into GV_DT(MAGV,DIENTHOAI)
	values ('003','0937125125')
	Insert Into GV_DT(MAGV,DIENTHOAI)
	values ('006','0937888888')
	Insert Into GV_DT(MAGV,DIENTHOAI)
	values ('008','0653717171')
	Insert Into GV_DT(MAGV,DIENTHOAI)
	values ('008','0913232323')
	go
	
--Nhập data cho bảng BOMON
	Insert Into BOMON(MABM,TENBM,PHONG,DIENTHOAI,MAKHOA)
	values (N'CNTT',N'Công nghệ tri thức','B15','0838126126',N'CNTT')
	Insert Into BOMON(MABM,TENBM,PHONG,DIENTHOAI,MAKHOA)
	values (N'HHC',N'Hóa hữu cơ','B44','0838222222',N'HH')
	Insert Into BOMON(MABM,TENBM,PHONG,DIENTHOAI,MAKHOA)
	values (N'HL',N'Hóa Lý','B42','0838878787',N'HH')
	Insert Into BOMON(MABM,TENBM,PHONG,DIENTHOAI,TRUONGBM,MAKHOA,NGAYNHANCHUC)
	values (N'HPT',N'Hóa phân tích','B43','0838777777','007',N'HH','2007-10-15')
	Insert Into BOMON(MABM,TENBM,PHONG,DIENTHOAI,TRUONGBM,MAKHOA,NGAYNHANCHUC)
	values (N'HTTT',N'Hệ thống thông tin','B13','0838125125','002',N'CNTT','2004-09-20')
	Insert Into BOMON(MABM,TENBM,PHONG,DIENTHOAI,TRUONGBM,MAKHOA,NGAYNHANCHUC)
	values (N'MMT',N'Mạng máy tính','B16','0838676767','001',N'CNTT','2005-05-15')
	Insert Into BOMON(MABM,TENBM,PHONG,DIENTHOAI,MAKHOA)
	values (N'SH',N'Sinh hóa','B33','0838898989',N'SH')
	Insert Into BOMON(MABM,TENBM,PHONG,DIENTHOAI,MAKHOA)
	values (N'VLĐT',N'Vật lý điện tử','B23','0838234234',N'VL')
	Insert Into BOMON(MABM,TENBM,PHONG,DIENTHOAI,TRUONGBM,MAKHOA,NGAYNHANCHUC)
	values (N'VLUD',N'Vật lý ứng dụng','B24','0838454545','005',N'VL','2006-02-18')
	Insert Into BOMON(MABM,TENBM,PHONG,DIENTHOAI,TRUONGBM,MAKHOA,NGAYNHANCHUC)
	values (N'VS',N'Vi Sinh','B32','0838909090','004',N'SH','2007-01-01')
	go
	
--Cập nhật thêm dữ liệu cho bảng GIAOVIEN
	update GIAOVIEN
	set MABM = 'MMT'
	where (MAGV = '001')
	update GIAOVIEN
	set MABM = 'HTTT'
	where (MAGV = '002')
	update GIAOVIEN
	set MABM = 'HTTT'
	where (MAGV = '003')
	update GIAOVIEN
	set MABM = 'VS'
	where (MAGV = '004')
	update GIAOVIEN
	set MABM = N'VLĐT'
	where (MAGV = '005')
	update GIAOVIEN
	set MABM = 'VS'
	where (MAGV = '006')
	update GIAOVIEN
	set MABM = 'HPT'
	where (MAGV = '007')
	update GIAOVIEN
	set MABM = 'HPT'
	where (MAGV = '008')
	update GIAOVIEN
	set MABM = 'MMT'
	where (MAGV = '009')
	update GIAOVIEN
	set MABM = 'HPT'
	where (MAGV = '010')
	GO	


/* Các từ khóa basic:
     *: Lấy tất cả dữ liệu
    DISTINCT: lấy dữ liệu không trùng lặp
	AS: đổi tên  -> cú pháp <tên Column> AS 'Tên thay thế'          
	TOP <n>: lấy dữ liệu thứ n đầu tiên
*/







































--  phân quyền


create login vantan with password = 'vantan123'
go

create user vantan
go

grant all on GIAOVIEN to vantan
go

grant select, update, delete on KHOA to vantan
go

grant create table , create function , backup database to vantan
go

revoke delete on KHOA from vantan
go	






































































































--                                                           TRUY VẤN SQL

--   Xuất ra thông tin giáo viên mà tên bắt đầu bằng chữ l
SELECT * FROM dbo.GIAOVIEN
WHERE HOTEN like 'l%'

--   sắp xếp giảm dần
SELECT MAGV FROM dbo.GIAOVIEN
ORDER BY MAGV DESC

--   sắp xếp tăng dần
SELECT MAGV FROM dbo.GIAOVIEN
ORDER BY MAGV ASC

--   lấy ra top 5 phần tử
SELECT TOP(5) * FROM dbo.GIAOVIEN 


--   Đếm số lượng người thân của Giáo viên có mã GV là 007
SELECT COUNT(*) AS N'Số lượng người thân'
FROM dbo.GIAOVIEN, dbo.NGUOITHAN
WHERE GIAOVIEN.MAGV = '007'
AND GIAOVIEN.MAGV = NGUOITHAN.MAGV


--   Lấy ra những giáo viên lớn hơn 40 tuổi. Trong câu này ta sử dụng thêm hàm
​​​​​​​SELECT * FROM dbo.GIAOVIEN
WHERE YEAR(GETDATE()) - YEAR(NGSINH) > 40


--   Lấy ra họ tên, năm sinh, tuổi của các giáo viên nhỏ hơn 40 tuổi
SELECT HOTEN, NGSINH, YEAR(GETDATE()) - YEAR(NGSINH) AS 'TUOI' FROM dbo.GIAOVIEN
WHERE YEAR(GETDATE()) - YEAR(NGSINH) <= 40


--   Lấy ra Mã GV, tên GV và tên khoa tương ứng mà giáo viên đó làm việc. (Gợi ý: Bộ môn nằm trong khoa)
SELECT gv.MAGV, gv.HOTEN, k.TENKHOA FROM dbo.GIAOVIEN AS GV,dbo.BOMON AS BM, dbo.KHOA AS K
WHERE GV.MABM=BM.MABM AND BM.MAKHOA=K.MAKHOA


--   Lấy ra tất cả thông tin của giáo viên là trưởng bộ môn
​​​​​​​SELECT GV.* FROM dbo.GIAOVIEN AS GV, dbo.BOMON AS BM    -- GV.*: lấy tất cả thông tin của bảng giáo viên  
WHERE BM.TRUONGBM = GV.MAGV



--   Xuất ra thông tin giáo viên và Giáo viên quản lý chủ nhiệm của người đó
SELECT GV1.HOTEN, GV2.HOTEN AS 'GV QUẢN LÝ'
FROM dbo.GIAOVIEN AS GV1, dbo.GIAOVIEN AS GV2
WHERE GV1.GVQLCM = GV2.MAGV


--   Xuất ra số lượng giáo viên của khoa CNTT
SELECT COUNT(*) FROM dbo.GIAOVIEN AS GV, dbo.BOMON AS BM, dbo.KHOA AS K
WHERE gv.MABM = bm.MABM
AND bm.MAKHOA = k.MAKHOA
AND k.MAKHOA = 'CNTT'


--   Xuất ra thông tin giáo viên và đề tài người đó tham gia khi mà kết quả là đạt
SELECT GV.*
FROM dbo.GIAOVIEN AS GV, dbo.THAMGIADT AS TG
WHERE GV.MAGV = TG.MAGV AND TG.KETQUA = N'Đạt'

 


--   Xuất ra thông tin đề tài (mã DT, tên DT) và tên giáo viên chủ nhiệm đề tài đó
SELECT DT.MADT,DT.TENDT, GV.HOTEN
FROM dbo.GIAOVIEN AS GV 
INNER JOIN dbo.DETAI AS DT ON DT.GVCNDT = GV.MAGV



-- Kiểm tra xem giáo viên 001 có phải là giáo viên quản lý chuyên môn hay không
-- Lấy ra danh sách các mã giáo viên QLCM
-- Kiểm tra mã GV tồn tại trong danh sách đó
SELECT * FROM dbo.GIAOVIEN
WHERE MAGV = '001'
/* 001 tồn tại trong danh sách*/
AND MAGV IN 
(
	SELECT GVQLCM FROM dbo.GIAOVIEN
)

-- truy vấn lồng trong from
SELECT * FROM
dbo.GIAOVIEN, (SELECT * FROM dbo.DETAI) AS DT




--                                                         TRUY VẤN LỒNG

-- 1. Xuất ra danh sách giáo viên tham gia nhiều hơn một đề tài

-- Lấy ra tất cả thông tin của Giáo viên 
SELECT * FROM dbo.GIAOVIEN AS GV
-- khi mà số lượng đề tài giáo viên đó tham gia > 1
WHERE 1 <
(
	SELECT COUNT(*) FROM dbo.THAMGIADT
	WHERE MAGV = GV.MAGV
)



-- 2. Xuất ra thông tin của khoa mà có nhiều hơn 2 giáo viên
-- Lấy được danh sách bộ môn nằm trong khoa hiện tại

SELECT * FROM dbo.KHOA AS K
WHERE 2 < 
(
	SELECT COUNT(*) FROM dbo.BOMON AS BM, dbo.GIAOVIEN AS GV
	WHERE BM.MAKHOA = k.MAKHOA
	AND bm.MABM = gv.MABM
)




--   KIỂU DỮ LIỆU TỰ ĐỊNH NGHĨA 
EXEC sp_addtype 'Nname', 'nvarchar(100)', 'not null'

CREATE TABLE example
(
 -- Nname: thay cho kiểu dữ liệu nvarchar(100)
    Ten Nname,  
	DiaChi nvarchar(200)
)
GO


--   Declare và sử dụng biến
-- tạo ra một biến kiểu char lưu mã giáo viên lương thấp nhất
DECLARE @MinSalaryMAGV CHAR(10)

SELECT @MinSalaryMAGV = MAGV FROM dbo.GIAOVIEN WHERE LUONG = (SELECT Min(Luong) FROM dbo.GIAOVIEN)

SELECT YEAR(GETDATE()) - YEAR(NGSINH) FROM dbo.GIAOVIEN
WHERE MAGV = @MinSalaryMAGV



--   xuất ra số lượng người thân của giáo viên '001'
DECLARE @MAGV CHAR(10) = '001'
SELECT * FROM dbo.NGUOITHAN WHERE MAGV = @MAGV



--   xuất ra tên của giáo viên có tên thấp nhất
DECLARE @MinLuong INT
DECLARE @TenGV NVARCHAR(100)

SELECT @MinLuong = MIN(Luong) FROM dbo.GIAOVIEN
SELECT @TenGV = HoTen FROM dbo.GIAOVIEN WHERE LUONG = @MinLuong

PRINT @TenGV   -- xuất giá trị ra màn hình



--   else if
-- nếu lương của @MaGV > @LuongTrungBinh
-- Xuất ra lớn hơn
-- ngược lại
-- nhỏ hơn

DECLARE @LuongTrungBinh INT
DECLARE @SoLuongGiaoVien INT

SELECT @SoLuongGiaoVien = COUNT(*) FROM dbo.GIAOVIEN
SELECT @LuongTrungBinh = SUM(Luong)/@SoLuongGiaoVien FROM dbo.GIAOVIEN 

DECLARE @MaGV CHAR(10) = '002'
DECLARE @LuongMaGV INT = 0

SELECT @LuongMaGV = Luong FROM dbo.GIAOVIEN WHERE MAGV = @MaGV

PRINT @LuongMaGV
PRINT @LuongTrungBinh
if @LuongMaGV > @LuongTrungBinh
    PRINT N'Lớn hơn'
else
    PRINT N'Nhỏ hơn'

	SELECT * FROM dbo.GIAOVIEN

-- Vòng lặp
DECLARE @i INT = 0
DECLARE @n INT = 10000

WHILE (@i < @n) 
BEGIN
    Insert BOMON(MABM,TENBM,PHONG,DIENTHOAI,MAKHOA)
	values (@i,@i,'B15','000000000',N'CNTT')
	SET @i += 1
END
GO

--  PROC
-- example 1
CREATE PROC USP_Test
@MaGV NVARCHAR(10), @Luong INT   -- có paramter truyền vào sài nó sẽ gọn hơn
AS
BEGIN
    SELECT* FROM dbo.GIAOVIEN WHERE MAGV = @MaGV AND LUONG = @Luong
END
GO

EXEC dbo.USP_Test @MaGV = N'', @Luong = 0
EXEC dbo.USP_Test N'', 0
EXECUTE dbo.USP_Test @MaGV = N'', @Luong =	 0
EXECUTE dbo.USP_Test N'', 0
GO


-- example 2
CREATE PROC USP_SelectGiaoVien
AS SELECT * FROM dbo.GIAOVIEN
GO

EXEC dbo.USP_SelectGiaoVien  -- tái sử dụng lại câu truy vấn bằng cách ngắn hơn



-- function
-- example 1
-- tạo function KO CÓ parameter
CREATE FUNCTION UF_SelectAllGiaoVien()
RETURNS TABLE 
AS RETURN SELECT * FROM dbo.GIAOVIEN
GO

-- sử dụng
SELECT * FROM UF_SelectAllGiaoVien()

-- tạo function với parameter
CREATE FUNCTION UF_SelectLuongGiaoVien(@MaGV char(10))
RETURNS INT
AS
BEGIN
    DECLARE @Luong INT
	SELECT @Luong = Luong FROM dbo.GIAOVIEN WHERE MAGV = @MaGV
	RETURN @Luong
END

-- sử dụng đi kèm dbo
SELECT dbo.UF_SelectLuongGiaoVien(MaGV) FROM dbo.GIAOVIEN



-- sửa function
alter FUNCTION UF_SelectLuongGiaoVien(@MaGV char(10))
RETURNS INT
AS
BEGIN
    DECLARE @Luong INT
	SELECT @Luong = Luong FROM dbo.GIAOVIEN WHERE MAGV = @MaGV
	RETURN @Luong
END


-- hủy function hay store
DROP PROC USP_SelectAllGiaoVien
DROP FUNCTION UF_SelectAllGiaoVien



-- example 2
CREATE FUNCTION UF_IsOdd(@Num int)
RETURNS NVARCHAR(20)
BEGIN
    IF (@Num % 2 = 0)
	    RETURN N'Số chẳn'
    ELSE 
	    RETURN N'Số lẻ'
    RETURN N'không xác định'
END

-- example 3

CREATE FUNCTION UF_AgeOfYear(@Year date)
RETURNS INT
BEGIN
    RETURN YEAR(GETDATE()) - YEAR(@Year)
END

SELECT dbo.UF_AgeOfYear(NgSinh), dbo.dbo.UF_IsOdd(dbo.UF_AgeOfYear(NgSinh)) FROM dbo.GIAOVIEN




-- Trigger

-- Trigger sẽ được gọi mỗi khi có thao tác thay đổi thông tin bảng
-- Inserted: Chứa những trường đã INSERT | UPDATE vào bảng
-- Deleted: Chứa những trường đã xóa khỏi bảng
-- example 1
CREATE TRIGGER UTG_InsertGiaoVien
ON dbo.GIAOVIEN
FOR INSERT , UPDATE
AS
BEGIN
     -- ROLLBACK TRAN
	 PRINT 'Trigger'
END
GO

INSERT dbo.GIAOVIEN
          (MAGV,
		  HOTEN,
		  LUONG,
		  PHAI,
		  NGSINH,
		  DIACHI
		  )
	values ('011',
			N'Nguyễn Hoài An Nhan',
			2000.0,
			N'Nu',
			'1973-02-15',
			N'25/3 Lạc Long Quân Q.10,TP HCM'
			)

-- example 2
CREATE TRIGGER UTG_AbortOlderThan40
ON dbo.GIAOVIEN
FOR DELETE
AS
BEGIN
    DECLARE @Count INT = 0

	SELECT @Count = COUNT(*) FROM Deleted
	WHERE YEAR(GETDATE()) - YEAR(Deleted.NGSINH) > 40

	IF(@Count > 0)
	BEGIN
	    PRINT N'Không được xóa người hơn 40 tuổi'
		ROLLBACK TRAN
	END
END
GO
-- test 
select * from dbo.GIAOVIEN  

-- LÚC truy vấn máy sẽ thông báo -> N'Không được xóa người hơn 40 tuổi' và ra bug trigger
































