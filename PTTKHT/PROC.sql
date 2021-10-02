
/************************************************  stored procedure   ******************************************************/

EXAMPLE 1

LOP (MaLop, TenLop, MaKhoa)
KHOA (
DIEMTHI (
GIANGVIEN (


// Tạo stored procedure dùng để thêm dữ liệu vào bảng LOP
CREATE PROC sp_ThemLop (
         @MaLop NVARCHAR(50),
         @TenLop NVARCHAR(50),
         @MaKhoa NVARCHAR(50)  )
AS 
INSERT INTO Lop VALUES(@MaLop, @TenLop, @MaKhoa)
GO


// Tạo stored procedure dùng để thêm dữ liệu vào bảng GIANGVIEN
CREATE PROC sp_GiangVien (
         @MaGv NVARCHAR(50),
         @TenGv NVARCHAR(50),
         @ChuyenNganh NVARCHAR(50),
         @MaKhoa NVARCHAR(50)  )
AS 
INSERT INTO GiangVien VALUES (@MaGv, @TenGv, @ChuyenNganh, @MaKhoa)
GO



// Tạo stored procedure dùng để cập nhật tên khoa
CREATE PROC Sp_CapNhapTenKhoa( 
         @MaKhoa NVARCHAR(15)
         @TenKhoa NVARCHAR(50))
AS 
UPDATE KHOA SET TenKhoa = @TenKhoa
WHERE MaKhoa = @MaKhoa



// Tạo stored procedure dùng để cập nhật điểm của sinh viên
CREATE PROC Sp_CapNhatDiem (
        @MaSv NVARCHAR(50),
        @MaMh NVARCHAR(50), 
        @LanThi INT, 
        @DiemThi FLOAT)
AS 
     UPDATE DIEMTHI SET DiemThi = @DiemThi 
     WHERE 
           MaSv = @MaSv AND MaMh = @MaMh AND LanThi = @LanThi















EXAMPLE 2

// Lấy ra HoTen, GT, QQ từ bảng sinh viên 
sắp xếp tăng dần theo họ tên nếu học bằng null thì đưa ra quê quán
SV (MASV, HOTEN, GT, QQ)

SELECT HOTEN, GT, QQ
FROM SV
ORDER BY (
    CASE 
    WHEN HOTEN IS NULL THEN QQ 
    ELSE HOTEN 
    END
 );











 EXAMPLE 3

 VATTU (MAVTU, TENVTU, DONVITINH, PHANTRAM)
 CTPXUAT (MAPX, MAVTU, SLXUAT, DGIAXUAT)
 DONDH (SoDH, NgayDH, MaNhaCC)
 CTDONDH (SoDH, MaVTu, SLDat)
 TONKHO (NAMTHANG, MAVTU, SLDAU, TONGSLN, TONGSLX,SLCuoi)



// Câu 1. Tạo SP dùng để thêm một đơn đặt hàng.
CREATE PROC sp_ThemDonDatHang(
         @SoDH  NVARCHAR(50),
         @NgayDH  DATE,
         @MaNhaCC  NVARCHAR(50) )
AS 
BEGIN
    INSERT  INTO  DONDH  VALUES(@SoDH, @NgayDH, @MaNhaCC)
END
GO





// Câu 2. Tạo SP dùng để thêm một chi tiết đơn đặt hàng.
CREATE PROC sp_ThemChiTietDonHang (
         @SoDH  NVARCHAR(50),
         @MaVTu  NVARCHAR(50),
         @SLDat  INT  )
AS 
BEGIN
    INSERT  INTO  CTDONDT  VALUES (@SoDH,  @MaVTu,  @SLDat )
END
GO






// Câu 3. Tạo Stored procedure (SP) cho biết tổng số lượng cuối của vật tư với mã vật tư là tham số vào.
CREATE PROC  sp_TongSLVatTu (@MaVT NVARCHAR(100) )
AS 
BEGIN
     DECLARE  @SLCuoi  INT
     SELECT @SLCuoi  =  SUM(SLCuoi)  FROM  TONKHO  WHERE  MaVT  =  @MaVT
     PRINT “Tong so luong cuoi cua ma vat tu la:  ” + @SLCuoi
END
GO





// Câu 4 .Tạo SP cho biết tổng tiền xuất của vật tư với mã vật tư là tham số vào.
CREATE PROC sp_TongTienXuat (@MaVT NVARCHAR(50) )
AS 
BEGIN
      DECLARE  @TienXuat  INT
      SELECT @ TienXuat  =  SUM(SLXuat * DonGia)  FROM  CTPXUAT  WHERE  MaVT = @MaVT
      PRINT “Tong tien xuat cua ma vat tu la:  ” + @ TienXuat
END
GO






// Câu 5. Tạo SP cho biết tổng số lượng đặt theo số đơn hàng với số đơn hàng là tham số vào.
CREATE PROC sp_TongSLDat ( @SoDH NVARCHAR(100) )
AS 
BEGIN
        DECLARE  @SLDat  INT
        SELECT @SLDat =  SUM(SLDat)  FROM  CTDONDH
        PRINT “Tong so luong dat cua so don hang la:  ” + @SLDat
END
GO
