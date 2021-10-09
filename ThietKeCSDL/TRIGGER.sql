/*                                                            Trigger                                                                            */

update: inserted(mới) , deleted(cũ)
inserted: dữ liệu chuẩn bị thêm vào (mới)
deleted: dữ liệu chuẩn bị xóa đi (cũ)


Bài 1:

Câu 1. Tạo trigger khi update hoặc insert dữ liệu của bảng TONKHO, cột SLCuoi được tính
theo công thức SLCuoi = SLDau + TongSLN – TongSLX

CREATE TRIGGER TR_SLCUOI ON TONKHO
FOR UPDATE, INSERT
AS
  BEGIN	
     UPDATE TONKHO SET SLCUOI = SLDAU + TONGSLN – TONGSLX	
     FROM TONKHO AS a, DELECTED AS b, INSERTED AS c
     WHERE a.(NAMTHANG, MAVTU) = b.(NAMTHANG, MAVTU) AND a.(NAMTHANG, MAVTU) = c.(NAMTHANG, MAVTU)
  END
    



Câu 2. Tạo trigger khi update cột SLNhap của bảng CTPNHAP thì cột TongSLN của
bảng TONKHO được cập nhật theo.

create trigger tr_Update_SLN_CTPNhap on CTPNhap for  Update 
as 
begin
	update TonKho set TSLNhap = a.TSLNhap + b.SLNhap - c.SLNhap
	from TonKho as a, INSERTED as b, DELETED as c
	where TonKho.MAVT = Inserted.Mavt 
	and TonKho.MAVT = Delected.Mavt 
end



Câu 3. Tạo trigger khi update cột SLXuat của bảng CTPXUAT thì cột TongSLX của
bảng TONKHO được cập nhật theo.

create trigger tr_Update_SLX_CTPXuat on CTPXuat for  Update 
as 
begin
	update TonKho set TSLXuat = a.TSLXuat + b.SLXuat - c.SLXuat
	from TonKho as a, INSERTED as b, DELETED as c
	where TonKho.MAVT = Inserted.Mavt
	and TonKho.MAVT = Delected.Mavt 
end





Câu 4. Tạo trigger khi update hoặc insert cột SLNhap của bảng CTPNHAP thì tổng số lượng
nhập <= tổng số lượng đặt của bảng CTDONDH.


Create Trigger tr_SLNHAP on CTPNHAP
for Update, Insert 
As
    if ( Select Sum(CTPNHAP. SLNhap)
       from CTPNHAP inner join INSERTED 
       on CTPNHAP. MaVTu = INSERT. MaVTu) <= ( Select Sum(SLDat)
                                               from CTDONDH inner join INSERTED 
                                               on CTDONDH. MaVTu = INSERTED. MaVTu )
    Begin 
    print N'TỔNG SỐ LƯỢNG NHẬP BÉ HƠN SỐ LƯỢNG ĐẶT HÀNG'
    RollBack Tran 
    end





Câu 5. Tạo trigger khi delete một CTPNHAP thì cột TongSLN của bảng TONKHO được cập
nhật tương ứng.

Create Trigger tr_CTPNHAP on CTPNHAP 
for Deleted
As
  begin
   Update TONKHO Set a.TongSLN = a.TongSLN + b.SLNHAP
   From  TONKHO as a ,DELETED as b 
   Where a.MAVTU = b.MAVTU
  end






Bài 2:
Cho CSDL gồm các quan hệ sau:
HANGHOA (MaH, TenH, Mota)
GIABAN (MaGia, MucGia, DVT, NgayAD, MaH)
ChitietDonhang (MaCTDH, MaH, MaHD, DVT, Mucgia, Soluong, Thanhtien)
HOADON (MaHD, NgayLap, MaKH, MaNV, Tongtien, Chietkhau)
KhachHang (MaKH, TenKH, DiaChi, Dienthoai, Loaithe, Ngaycapthe)
Nhanvien (MaNV, TenNV, Diachi, Dienthoai)

5. Viết 1 trigger tự động cập nhật trường Tongtien, Chietkhau trong quan hệ
HOADON khi thêm mới hay cập nhật một bản ghi trong ChitietDonhang.
Biết rằng :
Tongtien=Tổng các Thanhtien của từng mặt hàng trong ChitietDonhang
Chietkhau = Tongtien * n
Trong đó : 
n = 2% nếu khách hàng có thẻ « SoftCard » ;
n = 4% nếu khách hàng có thẻ « SilverCard » ;
n = 5% nếu khách hàng có thẻ « GoldednCard » ;
n = 4% nếu khách hàng có thẻ « DiamondCard » ;
create trigger tr_HOADON_Tongtien_chietkhau
on HOADON
for insert, update
as
begin
	declare @MaHD char(10)
	declare @Tongtien float
	declare @loaithe char(20)

	select @MaHD = MaHD from inserted
	
	select @Tongtien = sum(Thanhtien)
	from ChitietDonHang
	where MaHD = @MaHD

	update HOADON set Tongtien = @Tongtien
	where MaHD = @MaHD

	select @loaithe = Kh.Loaithe
	from inserted i inner join KhachHang KH ON i.MaKH = KH.MaKH

	IF @loaithe = 'SoftCard'
	begin
		update HOADON
		set Chieckhau = Tongtien * 2 / 100
		where MaHD = @MaHD
	end
	else IF @loaithe IN ('SilverCard', 'DiamondCard')
	begin
		update HOADON
		set Chieckhau = Tongtien * 4 / 100
		where MaHD = @MaHD
	end
	else
	begin
		update HOADON set Chieckhau = Tongtien * 5 / 100
		where MaHD = @MaHD
	end
end

1. Lập báo cáo doanh thu trong năm 2019 của từng mặt hàng.

select HH.MaH, HH.TenH, sum(CTDH.Soluong) AS 'SL', sum(CTDH.Thanhtien) AS 'TT'
from ChitietDonHang CTDH inner join HANGHOA HH ON CTDH.MaH = HH.MaH 
	inner join HOADON HD ON CTDH.MaHD = HD.MaHD
where Year(HD.NgayLap) = 2021 
group by HH.MaH, HH.TenH


2. Đưa ra danh sách những nhân viên có doanh thu bán hàng tháng 12/2019
từ 20 triệu trở lên

select NV.MaNV, NV.TenNV, sum(Tongtien) AS 'Doanh thu ban hang'
from HOADON HD inner join Nhanvien NV ON HD.MaNV = NV.MaNV
where MONTH(HD.NgayLap) = 11 AND YEAR(HD.NgayLap) = 2021
group by NV.MaNV, NV.TenNV
having sum(Tongtien) >= 0



3. Tính tổng doanh số mua hàng tính từ ngày cấp thẻ đến ngày hiện tại của
mỗi khách hàng được cấp thẻ « SoftCard ». Thời gian tính từ ngày cấp
thẻ đến ngày hiện tại phải &lt;= 1 năm. Chi tiết hiển thị các khách hàng có
tổng doanh số mua hàng &gt;= 5.000.000

select KH.MaKH, KH.TenKH, sum(HD.Tongtien) as 'Doanh so mua'
from HOADON HD inner join KhachHang KH ON HD.MaKH = KH.MaKH
where HD.NgayLap BETWEEN KH.Ngaycapthe AND GETDATE() 
AND DATEDIFF(day, KH.Ngaycapthe, GETDATE()) < 365 
AND KH.Loaithe = 'SoftCard'
group by KH.MaKH, KH.TenKH
having sum(HD.Tongtien) >= 0




4. Thống kê doanh thu bán hàng theo từng năm của 5 năm trở lại đây.

select YEAR(NgayLap), SUM(Tongtien) AS 'doanh so'
from HOADON
group by YEAR(NgayLap)
having  DATEDIFF(year, YEAR(NgayLap), YEAR(GETDATE())) < 5 AND SUM(Tongtien) >= 0



5. Viết 1 trigger tự động cập nhật trường Tongtien, Chietkhau trong quan hệ
HOADON khi thêm mới hay cập nhật một bản ghi trong ChitietDonhang.
Biết rằng :
Tongtien=Tổng các Thanhtien của từng mặt hàng trong ChitietDonhang
Chietkhau = Tongtien * n
Trong đó : 
n = 2% nếu khách hàng có thẻ « SoftCard » ;
n = 4% nếu khách hàng có thẻ « SilverCard » ;
n = 5% nếu khách hàng có thẻ « GoldednCard » ;
n = 4% nếu khách hàng có thẻ « DiamondCard » ;

create trigger tr_HOADON_Tongtien_chietkhau
on HOADON
for insert, update
as
begin
	declare @MaHD char(10)
	declare @Tongtien float
	declare @loaithe char(20)

	select @MaHD = MaHD from inserted
	
	select @Tongtien = sum(Thanhtien)
	from ChitietDonHang
	where MaHD = @MaHD

	update HOADON set Tongtien = @Tongtien
	where MaHD = @MaHD

	select @loaithe = Kh.Loaithe
	from inserted i inner join KhachHang KH ON i.MaKH = KH.MaKH

	IF @loaithe = 'SoftCard'
	begin
		update HOADON set Chieckhau = Tongtien * 2 / 100
		where MaHD = @MaHD
	end
	else IF @loaithe IN ('SilverCard', 'DiamondCard')
	begin
		update HOADON set Chieckhau = Tongtien * 4 / 100
		where MaHD = @MaHD
	end
	else
	begin
		update HOADON set Chieckhau = Tongtien * 5 / 100
		where MaHD = @MaHD
	end
end




6. Viết trigger tự động cập nhật trường Mucgia và Thanhtien của bảng
ChitietDonhang khi thêm mới hay cập nhật một bản ghi.

create trigger tr_CTHD_Mucgia_Thanhtien
on ChitietDonhang
for insert, update
as
begin
        declare @MaH char(10),
	        @MaCTHD char(10),
	        @Mucgia float
	      

	select @MaCTHD = MaCTDH, @MaH = MaH from inserted

	select @Mucgia = MucGia
	from GIABAN
	where MaH = @MaH
        For each row
        begin
	   update ChitietDonHang set Mucgia = @Mucgia, Thanhtien = Soluong * @Mucgia
	   where MaCTDH = @MaCTHD
        end
end



7. Viết thủ tục với tham số đầu vào là @MaHang, @DVT, @Ngayban,
tham số đầu ra là tổng số lượng đã bán của mặt hàng đã cho (hoặc tham
số đầu ra là mức giá bán của mã hàng đó)

create proc sp_Cau7(@MaHang char(10), @DVT char(10), @Ngayban date)
as
begin
	select HH.MaH, HH.TenH, sum(CTHD.Soluong)
	from ChitietDonHang CTHD inner join HOADON HD ON CTHD.MaHD = HD.MaHD inner join HANGHOA HH ON CTHD.MaH = HH.MaH
	where HD.NgayLap = @Ngayban AND CTHD.DVT = @DVT
	group by HH.MaH, HH.TenH
end










