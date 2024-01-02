CREATE TABLE TaiKhoanDangNhap (
  MaSo VARCHAR(20)  PRIMARY KEY,
  Ho VARCHAR(20) NOT NULL,
  TenDem VARCHAR(20) NOT NULL,
  Ten VARCHAR(20) NOT NULL,
  NgaySinh DATE NOT NULL,
  GioiTinh CHAR(20) NOT NULL,
  SoCCCD VARCHAR(20) NOT NULL,
  UserName VARCHAR(20) NOT NULL,
  MatKhau VARCHAR(20) NOT NULL
);
-- check
CREATE TABLE SoDienThoai (
  MaSoTaiKhoan VARCHAR(20) NOT NULL,
  SoDienThoai VARCHAR(20) NOT NULL,
  PRIMARY KEY (MaSoTaiKhoan, SoDienThoai),
  FOREIGN KEY (MaSoTaiKhoan) REFERENCES TaiKhoanDangNhap(MaSo)
);

CREATE TABLE Email (
  MaSoTaiKhoan VARCHAR(20) NOT NULL,
  Email VARCHAR(255) NOT NULL,
  PRIMARY KEY (MaSoTaiKhoan, Email),
  FOREIGN KEY (MaSoTaiKhoan) REFERENCES TaiKhoanDangNhap(MaSo)
);

CREATE TABLE ChuDichVu (
  MaSoTaiKhoan VARCHAR(20) ,
  PRIMARY KEY (MaSoTaiKhoan),
  FOREIGN KEY (MaSoTaiKhoan) REFERENCES TaiKhoanDangNhap(MaSo)
);

CREATE TABLE NhanVien (
  MaSoTaiKhoan VARCHAR(20) ,
  ThoiGianLamViec TIME NOT NULL,
  NgayBatDauLam DATE NOT NULL,
  MaNhanVienQuanLy VARCHAR(20),
  PRIMARY KEY (MaSoTaiKhoan),
  FOREIGN KEY (MaSoTaiKhoan) REFERENCES TaiKhoanDangNhap(MaSo),
  FOREIGN KEY (MaNhanVienQuanLy) REFERENCES NhanVien(MaSoTaiKhoan)
);

CREATE TABLE KhachHang (
  MaSoTaiKhoan VARCHAR(20),
  CapBac VARCHAR(20) NOT NULL,
  PRIMARY KEY (MaSoTaiKhoan),
  FOREIGN KEY (MaSoTaiKhoan) REFERENCES TaiKhoanDangNhap(MaSo)
);

CREATE TABLE TaiKhoanNganHang (
  SoTaiKhoan VARCHAR(20) NOT NULL,
  TenNganHang VARCHAR(50) NOT NULL,
  MaKhachHang VARCHAR(20) NOT NULL,
  TrangThai VARCHAR(20) NOT NULL,
  PRIMARY KEY (SoTaiKhoan),
  FOREIGN KEY (MaKhachHang) REFERENCES KhachHang(MaSoTaiKhoan)
);

CREATE TABLE DonHang (
  MaDonHang VARCHAR(20) ,
  TinhTrangDonHang VARCHAR(20) NOT NULL,
  HinhThucThanhToan VARCHAR(20) NOT NULL,
  MaKhachHang VARCHAR(20) NOT NULL,
  NgayGiaoDich DATE NOT NULL,
  TaiKhoanNganHang VARCHAR(20) NOT NULL,
  MaNhanVienHoTro VARCHAR(20) NOT NULL,
  PRIMARY KEY (MaDonHang),
  FOREIGN KEY (MaKhachHang) REFERENCES KhachHang(MaSoTaiKhoan),
  FOREIGN KEY (TaiKhoanNganHang) REFERENCES TaiKhoanNganHang(SoTaiKhoan),
  FOREIGN KEY (MaNhanVienHoTro) REFERENCES NhanVien(MaSoTaiKhoan)
);

CREATE TABLE NhaCungCapDichVu (
  MaDichVu VARCHAR(20) ,
  MaChuDichVu VARCHAR(20) NOT NULL,
  LoaiDichVu VARCHAR(50) NOT NULL,
  PRIMARY KEY (MaDichVu),
  FOREIGN KEY (MaChuDichVu) REFERENCES ChuDichVu(MaSoTaiKhoan)
);

CREATE TABLE HangHangKhong (
  MaSoThue VARCHAR(20) NOT NULL,
  TenHang VARCHAR(50) NOT NULL,
  MoTa VARCHAR(255) ,
  SoDienThoaiTuVanVien VARCHAR(20) NOT NULL,
  MaDichVu VARCHAR(20) NOT NULL,
  PRIMARY KEY (MaSoThue),
  FOREIGN KEY (MaDichVu) REFERENCES NhaCungCapDichVu(MaDichVu)
);

CREATE TABLE ChuyenBay (
  MaSo VARCHAR(20) NOT NULL,
  Ngay DATE NOT NULL,
  ThoiGianXuatPhat DATETIME NOT NULL,
  ThoiGianHaCanh DATETIME NOT NULL,
  DiaDiemXuatPhat VARCHAR(50) NOT NULL,
  DiaDiemHaCanh VARCHAR(50) NOT NULL,
  MaSoThueCuaHangHangKhong VARCHAR(20) NOT NULL,
  PRIMARY KEY (MaSo),
  FOREIGN KEY (MaSoThueCuaHangHangKhong) REFERENCES HangHangKhong(MaSoThue)
);

CREATE TABLE KhoangTrenChuyenBay (
  MaSoMayBay VARCHAR(20) NOT NULL,
  LoaiKhoang VARCHAR(20) NOT NULL,
  GiaKhoang DECIMAL(10,2) NOT NULL,
  SoLuongGheToiDaCungCap INT NOT NULL,
  MoTa VARCHAR(255) ,
  PRIMARY KEY (MaSoMayBay, LoaiKhoang),
  FOREIGN KEY (MaSoMayBay) REFERENCES ChuyenBay(MaSo)
);

CREATE TABLE VeDatMayBay (
  MaDatVe VARCHAR(20) ,
  MaDonHang VARCHAR(20) NOT NULL,
  MaSoChuyenBay VARCHAR(20) NOT NULL,
  PRIMARY KEY (MaDatVe),
  FOREIGN KEY (MaDonHang) REFERENCES DonHang(MaDonHang),
  FOREIGN KEY (MaSoChuyenBay) REFERENCES ChuyenBay(MaSo)
);

CREATE TABLE NguoiThamGiaChuyenBay (
  MaKhachHang VARCHAR(255) ,
  HoVaTen VARCHAR(40) NOT NULL,
  SoDienThoai VARCHAR(20) NOT NULL,
  Email VARCHAR(255) NOT NULL,
  SoCCCD VARCHAR(20) NOT NULL,
  NgaySinh DATE NOT NULL,
  MaVeMayBay VARCHAR(20) NOT NULL,
  MaSoMayBay VARCHAR(20) NOT NULL,
  LoaiKhoang VARCHAR(20) NOT NULL,
  MoTa VARCHAR(255),
  PRIMARY KEY (MaKhachHang),
  FOREIGN KEY (MaVeMayBay) REFERENCES VeDatMayBay(MaDatVe) ON DELETE CASCADE,
  FOREIGN KEY (MaSoMayBay, LoaiKhoang) REFERENCES KhoangTrenChuyenBay(MaSoMayBay, LoaiKhoang)
);

CREATE TABLE HanhLy (
  MaSoMayBay VARCHAR(20) NOT NULL,
  LoaiHanhLyKyGui VARCHAR(20) NOT NULL,
  ChiTiet VARCHAR(255) NOT NULL,
  GiaCa DECIMAL(10,2) NOT NULL,
  PRIMARY KEY (MaSoMayBay, LoaiHanhLyKyGui),
  FOREIGN KEY (MaSoMayBay) REFERENCES ChuyenBay(MaSo),
);
CREATE TABLE GuiHanhLy (
  MaSoMayBay VARCHAR(20) NOT NULL,
  LoaiHanhLyKyGui VARCHAR(20) NOT NULL,
  MaNguoiThamGiaChuyenBay VARCHAR(255) NOT NULL,
  SoLuong INT NOT NULL,
  PRIMARY KEY (MaSoMayBay, LoaiHanhLyKyGui,MaNguoiThamGiaChuyenBay),
  FOREIGN KEY (MaSoMayBay,LoaiHanhLyKyGui) REFERENCES HanhLy(MaSoMayBay,LoaiHanhLyKyGui),
  FOREIGN KEY (MaNguoiThamGiaChuyenBay) REFERENCES NguoiThamGiaChuyenBay(MaKhachHang)
);
CREATE TABLE KhachSan (
  MaSoThue VARCHAR(20) NOT NULL,
  TenKhachSan VARCHAR(50) NOT NULL,
  DiaChi VARCHAR(50) NOT NULL,
  ThanhPho VARCHAR(20) NOT NULL,
  SoDienThoaiLeTan VARCHAR(20) NOT NULL,
  MaDichVu VARCHAR(20) NOT NULL,
  PRIMARY KEY (MaSoThue),
  FOREIGN KEY (MaDichVu) REFERENCES NhaCungCapDichVu(MaDichVu)
);

CREATE TABLE Phong (
  MaSoThueKhachSan VARCHAR(20) NOT NULL,
  LoaiPhong VARCHAR(20) NOT NULL,
  Ngay DATE NOT NULL,
  SoLuongCungCap INT NOT NULL,
  MoTa VARCHAR(255) ,
  GiaPhong DECIMAL(10,2) NOT NULL,
  PRIMARY KEY (MaSoThueKhachSan, LoaiPhong, Ngay),
  FOREIGN KEY (MaSoThueKhachSan) REFERENCES KhachSan(MaSoThue)
);

CREATE TABLE VeDatPhong (
  MaDatPhong VARCHAR(20) ,
  MaDonHang VARCHAR(20) NOT NULL,
  PRIMARY KEY (MaDatPhong),
  FOREIGN KEY (MaDonHang) REFERENCES DonHang(MaDonHang)
);

CREATE TABLE ChonPhong (
  MaSoThueKhachSan VARCHAR(20) NOT NULL,
  LoaiPhong VARCHAR(20) NOT NULL,
  Ngay DATE NOT NULL,
  MaDatPhong VARCHAR(20) NOT NULL, 
  SoLuong INT NOT NULL,
  PRIMARY KEY (MaSoThueKhachSan, LoaiPhong, Ngay, MaDatPhong),
  FOREIGN KEY (MaSoThueKhachSan, LoaiPhong, Ngay) REFERENCES Phong(MaSoThueKhachSan, LoaiPhong, Ngay),
  FOREIGN KEY (MaDatPhong) REFERENCES VeDatPhong(MaDatPhong)
);

CREATE TABLE NhaHang (
  MaSoThue VARCHAR(20) NOT NULL,
  TenNhaHang VARCHAR(50) NOT NULL,
  DiaChi VARCHAR(50) NOT NULL,
  MoTa VARCHAR(255) ,
  SoDienThoaiQuanLy VARCHAR(20) NOT NULL,
  MaDichVu VARCHAR(20) NOT NULL,
  PRIMARY KEY (MaSoThue),
  FOREIGN KEY (MaDichVu) REFERENCES NhaCungCapDichVu(MaDichVu)
);

CREATE TABLE Ban (
  MaSoThueNhaHang VARCHAR(20) NOT NULL,
  LoaiBan VARCHAR(20) NOT NULL,
  ThoiGian DATE NOT NULL,
  SoLuongCungCap INT NOT NULL,
  SoLuongNguoiToiDa1Ban INT NOT NULL,
  MoTa VARCHAR(255) ,
  Gia DECIMAL(10,2) NOT NULL,
  PRIMARY KEY (MaSoThueNhaHang, LoaiBan, ThoiGian),
  FOREIGN KEY (MaSoThueNhaHang) REFERENCES NhaHang(MaSoThue)
);

CREATE TABLE PhieuNhaHang (
  MaDatCho VARCHAR(20) ,
  MaDonHang VARCHAR(20) NOT NULL,
  PRIMARY KEY (MaDatCho),
  FOREIGN KEY (MaDonHang) REFERENCES DonHang(MaDonHang)
);

CREATE TABLE ChonBan (
  MaSoThueNhaHang VARCHAR(20) NOT NULL,
  LoaiBan VARCHAR(20) NOT NULL,
  ThoiGian DATE NOT NULL,
  MaDatCho VARCHAR(20) NOT NULL,
  SoLuong INT NOT NULL,
  PRIMARY KEY (MaSoThueNhaHang, LoaiBan, ThoiGian, MaDatCho),
  FOREIGN KEY (MaSoThueNhaHang, LoaiBan, ThoiGian) REFERENCES Ban(MaSoThueNhaHang, LoaiBan, ThoiGian),
  FOREIGN KEY (MaDatCho) REFERENCES PhieuNhaHang(MaDatCho)
);


-- Hello 123
--1.1.2
---1.2.1 Thủ tục
----------
ALTER TABLE TaiKhoanDangNhap
ADD CHECK (GioiTinh IN ('F', 'M'))

ALTER TABLE KhoangTrenChuyenBay
ADD CHECK (SoLuongGheToiDaCungCap > 0);

ALTER TABLE GuiHanhLy
ADD CHECK (SoLuong > 0);

ALTER TABLE Phong
ADD CHECK (SoLuongCungCap > 0);

ALTER TABLE ChonPhong
ADD CHECK (SoLuong > 0);

ALTER TABLE Ban
ADD CHECK (SoLuongCungCap > 0);

ALTER TABLE Ban
ADD CHECK (SoLuongNguoiToiDa1Ban > 0);

ALTER TABLE ChonBan
ADD CHECK (SoLuong > 0);

go

CREATE TRIGGER instead_of_insert_TaiKhoanDangNhap
ON TaiKhoanDangNhap
INSTEAD OF INSERT
AS
BEGIN
    -- Custom logic to generate MaSo and handle the insert
    DECLARE @nextID INT;

    -- Lấy giá trị mã số tăng dần tiếp theo cho mỗi hàng
    SELECT @nextID = COALESCE(MAX(CAST(SUBSTRING(td.MaSo, 3, LEN(td.MaSo) - 2) AS INT)), 0) + ROW_NUMBER() OVER (ORDER BY (SELECT NULL))
    FROM TaiKhoanDangNhap td
    CROSS JOIN INSERTED;

    -- Chèn dữ liệu mới và cập nhật MaSo
    INSERT INTO TaiKhoanDangNhap (Ho, TenDem, Ten, NgaySinh, GioiTinh, SoCCCD, MaSo, TenDangNhap , MatKhau)
    SELECT Ho, TenDem, Ten, NgaySinh, GioiTinh, SoCCCD, 'TK' + RIGHT('000' + CAST(@nextID AS VARCHAR(3)), 3), TenDangNhap,MatKhau
    FROM INSERTED;
END;
go



CREATE TRIGGER instead_of_insert_ChuyenBay
ON ChuyenBay
INSTEAD OF INSERT
AS
BEGIN
    -- Custom logic to generate MaSo and handle the insert
    DECLARE @nextID INT;
    DECLARE @prefix VARCHAR(2);

    -- Lấy giá trị mã số tăng dần tiếp theo cho mỗi hàng
    SELECT @nextID = COALESCE(MAX(CAST(SUBSTRING(MaSo, 3, LEN(MaSo) - 2) AS INT)), 0) + ROW_NUMBER() OVER (ORDER BY (SELECT NULL))
    FROM ChuyenBay;
   -- SELECT TOP 1 @prefix = LEFT(MaSo, 2)
   -- FROM INSERTED;

    -- Chèn dữ liệu mới và cập nhật MaSo
    INSERT INTO ChuyenBay (Ngay, ThoiGianXuatPhat, ThoiGianHaCanh, DiaDiemXuatPhat, DiaDiemHaCanh, MaSoThueCuaHangHangKhong, MaSo)
    SELECT Ngay, ThoiGianXuatPhat, ThoiGianHaCanh, DiaDiemXuatPhat, DiaDiemHaCanh, MaSoThueCuaHangHangKhong, 'CB'  + RIGHT('000' + CAST(@nextID AS VARCHAR(3)), 3)
    FROM INSERTED;
END;
go



CREATE TRIGGER instead_of_insert_NguoiThamGiaChuyenBay
ON NguoiThamGiaChuyenBay
INSTEAD OF INSERT
AS
BEGIN
    -- Custom logic to generate MaSo and handle the insert
    DECLARE @nextID INT;
    DECLARE @prefix VARCHAR(2);

    -- Lấy giá trị mã số tăng dần tiếp theo cho mỗi hàng
    SELECT @nextID = COALESCE(MAX(CAST(SUBSTRING(MaKhachHang, 6, LEN(MaKhachHang) - 5) AS INT)), 0) + ROW_NUMBER() OVER (ORDER BY (SELECT NULL))
    FROM NguoiThamGiaChuyenBay;
   -- SELECT TOP 1 @prefix = LEFT(MaSo, 2)
   -- FROM INSERTED;

    -- Chèn dữ liệu mới và cập nhật MaSo
    INSERT INTO NguoiThamGiaChuyenBay (HoVaTen, SoDienThoai, Email, SoCCCD, NgaySinh, MaVeMayBay, MaSoMayBay,LoaiKhoang,MaKhachHang)
    SELECT HoVaTen, SoDienThoai, Email, SoCCCD, NgaySinh, MaVeMayBay, MaSoMayBay,LoaiKhoang, 'NTGCB'  + RIGHT('000' + CAST(@nextID AS VARCHAR(3)), 3)
    FROM INSERTED;
END;
go



CREATE TRIGGER instead_of_insert_PhieuNhaHang
ON PhieuNhaHang
INSTEAD OF INSERT
AS
BEGIN
    -- Custom logic to generate MaSo and handle the insert
    DECLARE @nextID INT;

    -- Lấy giá trị mã số tăng dần tiếp theo cho mỗi hàng
    SELECT @nextID = COALESCE(MAX(CAST(SUBSTRING(MaDatCho, 4, LEN(MaDatCho) - 3) AS INT)), 0) + ROW_NUMBER() OVER (ORDER BY (SELECT NULL))
    FROM PhieuNhaHang;

    -- Chèn dữ liệu mới và cập nhật MaSo
    INSERT INTO PhieuNhaHang (MaDonHang,MaDatCho)
    SELECT MaDonHang, 'VDC'  + RIGHT('000' + CAST(@nextID AS VARCHAR(3)), 3)
    FROM INSERTED;
END;

go

CREATE TRIGGER instead_of_insert_Service
ON NhaCungCapDichVu
INSTEAD OF INSERT
AS
BEGIN
    DECLARE @nextID INT;

    SELECT @nextID = COALESCE(MAX(CAST(SUBSTRING(MaDichVu, 3, LEN(MaDichVu) - 2) AS INT)), 0) + ROW_NUMBER() OVER (ORDER BY (SELECT NULL))
    FROM NhaCungCapDichVu;

    INSERT INTO NhaCungCapDichVu (MaChuDichVu, LoaiDichVu, MaDichVu)
    SELECT MaChuDichVu, LoaiDichVu, 'DV' + RIGHT('000' + CAST(@nextID AS VARCHAR(3)), 3)
    FROM INSERTED;
END;
GO


﻿CREATE OR ALTER PROCEDURE InsertAndGetAutoKey_VeDatMayBay
(
    @MaDonHang VARCHAR(20),
    @MaSoChuyenBay VARCHAR(20)
)
AS
BEGIN
    DECLARE @NextID INT;

    WITH CTE AS (
        SELECT 
            COALESCE(MAX(CAST(SUBSTRING(MaDatVe, 2, LEN(MaDatVe) - 1) AS INT)), 0) + ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) AS NextID
        FROM VeDatMayBay
    )
    SELECT @NextID = NextID FROM CTE;

	SELECT 'V00' + CAST(@NextID AS VARCHAR(3));

    INSERT INTO VeDatMayBay (MaDonHang, MaSoChuyenBay, MaDatVe)
    VALUES (
        @MaDonHang,
        @MaSoChuyenBay,
        'V00' + CAST(@NextID AS VARCHAR(3))
    );
END;
GO

CREATE OR ALTER PROCEDURE InsertAndGetAutoKey_DonHang
(
    @MaKhachHang VARCHAR(255)
)
AS
BEGIN
    DECLARE @nextID INT;
	DECLARE @BankAccount VARCHAR(20);
	DECLARE @Assitant VARCHAR(20);
	DECLARE @Bank VARCHAR(20);

    -- Lấy giá trị mã số tăng dần tiếp theo cho mỗi hàng
    SELECT @nextID = COALESCE(MAX(CAST(SUBSTRING(td.MaDonHang, 3, LEN(td.MaDonHang) - 2) AS INT)), 0) + ROW_NUMBER() OVER (ORDER BY (SELECT NULL))
    FROM DonHang td
    SELECT 'DH' + RIGHT('000' + CAST(@nextID AS VARCHAR(3)), 3);


    SELECT TOP 1 @BankAccount = N.SoTaiKhoan, @Bank = N.TenNganHang FROM TaiKhoanNganHang N WHERE N.MaKhachHang = @MaKhachHang 
	SELECT TOP 1 @Assitant = NhanVien.MaSoTaiKhoan FROM NhanVien

    INSERT INTO DonHang(TinhTrangDonHang, HinhThucThanhToan, MaKhachHang, NgayGiaoDich, TaiKhoanNganHang, MaNhanVienHoTro, MaDonHang)
    VALUES ('Chua xac nhan',@Bank , @MaKhachHang, GETDATE(), @BankAccount, @Assitant, 'DH' + RIGHT('000' + CAST(@nextID AS VARCHAR(3)), 3));
END;
GO

CREATE OR ALTER PROCEDURE InsertAndGetAutoKey_VeDatPhong
(
    @MaDonHang VARCHAR(20)
)
AS
BEGIN
     DECLARE @nextID INT;

    -- Lấy giá trị mã số tăng dần tiếp theo cho mỗi hàng
    SELECT @nextID = COALESCE(MAX(CAST(SUBSTRING(MaDatPhong, 4, LEN(MaDatPhong) - 3) AS INT)), 0) + ROW_NUMBER() OVER (ORDER BY (SELECT NULL))
    FROM VeDatPhong;

	SELECT 'VDP'  + RIGHT('000' + CAST(@nextID AS VARCHAR(3)), 3)

    -- Chèn dữ liệu mới và cập nhật MaSo
    INSERT INTO VeDatPhong (MaDonHang,MaDatPhong)
    VALUES( @MaDonHang, 'VDP'  + RIGHT('000' + CAST(@nextID AS VARCHAR(3)), 3));
END;
GO



-- FE xử lý tự lấy masovemaybay, loaikhong nó đã chọn.	
 -- mã vé thì khi người dùng click chọn chuyến bay -> generate maxvemaybay sau đó lấy mã này lên rồi đưa vào thủ tục insert nguoithamgia

 drop procedure if exists InsertNguoiThamGiaChuyenBay
 go
 drop procedure if exists UpdateNguoiThamGiaChuyenBay 
 go
 drop procedure if exists DeleteNguoiThamGiaChuyenBay 
 go

CREATE PROCEDURE InsertNguoiThamGiaChuyenBay
    @HoVaTen VARCHAR(40),
    @SoDienThoai VARCHAR(11),
    @Email VARCHAR(255),
    @SoCCCD VARCHAR(12),
    @NgaySinh DATE,
    @MaVeMayBay VARCHAR(20),
    @MaSoMayBay VARCHAR(20),
    @LoaiKhoang VARCHAR(20)
AS
BEGIN
    -- Kiểm tra dữ liệu hợp lệ
    IF DATEDIFF(YEAR, @NgaySinh, GETDATE()) < 18
    BEGIN
        RAISERROR('Tuổi người tham gia chuyến bay phải lớn hơn hoặc bằng 18.', 16, 1);
        RETURN;
    END

    -- Kiểm tra định dạng số điện thoại
    IF LEN(@SoDienThoai) <> 11 OR @SoDienThoai NOT LIKE '[0-9]%'
    BEGIN
        RAISERROR('Số điện thoại không hợp lệ.', 16, 1);
        RETURN;
    END

    -- Kiểm tra định dạng email
    IF NOT (CHARINDEX('@', @Email) > 0 AND CHARINDEX('.', @Email, CHARINDEX('@', @Email)) > 0)
    BEGIN
        RAISERROR('Địa chỉ email không hợp lệ.', 16, 1);
        RETURN;
    END

    -- Kiểm tra các ràng buộc khác nếu cần
    -- ...

    -- Thực hiện thêm dữ liệu
    INSERT INTO NguoiThamGiaChuyenBay ( HoVaTen, SoDienThoai, Email, SoCCCD, NgaySinh, MaVeMayBay, MaSoMayBay, LoaiKhoang)
    VALUES ( @HoVaTen, @SoDienThoai, @Email, @SoCCCD, @NgaySinh, @MaVeMayBay, @MaSoMayBay, @LoaiKhoang);
END;

go

CREATE PROCEDURE UpdateNguoiThamGiaChuyenBay
    @MaKhachHang VARCHAR(255),
    @HoVaTen VARCHAR(40),
    @SoDienThoai VARCHAR(11),
    @Email VARCHAR(255),
    @SoCCCD VARCHAR(12),
    @NgaySinh DATE,
    @MaVeMayBay VARCHAR(20),
    @MaSoMayBay VARCHAR(20),
    @LoaiKhoang VARCHAR(20)
AS
BEGIN
    -- Kiểm tra dữ liệu hợp lệ
    IF DATEDIFF(YEAR, @NgaySinh, GETDATE()) < 18
    BEGIN
        RAISERROR('Tuổi người tham gia chuyến bay phải lớn hơn hoặc bằng 18.', 16, 1);
        RETURN;
    END

    -- Kiểm tra định dạng số điện thoại
    IF LEN(@SoDienThoai) <> 11 OR @SoDienThoai NOT LIKE '[0-9]%'
    BEGIN
        RAISERROR('Số điện thoại không hợp lệ.', 16, 1);
        RETURN;
    END

    -- Kiểm tra định dạng email
    IF NOT (CHARINDEX('@', @Email) > 0 AND CHARINDEX('.', @Email, CHARINDEX('@', @Email)) > 0)
    BEGIN
        RAISERROR('Địa chỉ email không hợp lệ.', 16, 1);
        RETURN;
    END

    -- Kiểm tra các ràng buộc khác nếu cần
    -- ...

    -- Thực hiện cập nhật dữ liệu
    UPDATE NguoiThamGiaChuyenBay
    SET HoVaTen = @HoVaTen,
        SoDienThoai = @SoDienThoai,
        Email = @Email,
        SoCCCD = @SoCCCD,
        NgaySinh = @NgaySinh,
        MaVeMayBay = @MaVeMayBay,
        MaSoMayBay = @MaSoMayBay,
        LoaiKhoang = @LoaiKhoang
    WHERE MaKhachHang = @MaKhachHang;
END;

go

CREATE PROCEDURE DeleteNguoiThamGiaChuyenBay
    @MaKhachHang VARCHAR(255)
AS
BEGIN
    -- Thực hiện xóa dữ liệu
    DELETE FROM NguoiThamGiaChuyenBay
    WHERE MaKhachHang = @MaKhachHang;
END;

go
-- Create the function for calculating the remaining seat amount
CREATE FUNCTION dbo.CalculateTotalPaidAmountPhieuNhaHang(@MaDatCho VARCHAR(20))
RETURNS INT
AS
BEGIN
    DECLARE @TotalAmount INT;
    SELECT @TotalAmount=SUM(c.Gia)
    FROM PhieuNhaHang AS a
    JOIN ChonBan AS b ON a.MaDatCho = b.MaDatCho 
	JOIN Ban as c on b.MaSoThueNhaHang=c.MaSoThueNhaHang AND b.LoaiBan=c.LoaiBan AND b.ThoiGian=c.ThoiGian
    WHERE a.MaDatCho = @MaDatCho
    GROUP BY a.MaDatCho;
    RETURN ISNULL(@TotalAmount, 0);
END;
go

-- Add a computed column for SoLuongGheConLai in the KhoangChuyenBay table
ALTER TABLE PhieuNhaHang
ADD TongTien AS dbo.CalculateTotalPaidAmountPhieuNhaHang(MaDatCho);
go

-- Create the function for calculating the remaining seat amount
CREATE FUNCTION dbo.CalculateTotalPaidAmountVeDatPhong(@MaDatPhong VARCHAR(20))
RETURNS INT
AS
BEGIN
    DECLARE @TotalAmount INT;
    SELECT @TotalAmount=SUM(c.GiaPhong)
    FROM VeDatPhong AS a
    JOIN ChonPhong AS b ON a.MaDatPhong = b.MaDatPhong 
	JOIN Phong as c on b.MaSoThueKhachSan=c.MaSoThueKhachSan AND b.LoaiPhong=c.LoaiPhong AND b.Ngay=c.Ngay
    WHERE a.MaDatPhong = @MaDatPhong
    GROUP BY a.MaDatPhong;
    RETURN ISNULL(@TotalAmount, 0);
END;
go
-- Add a computed column for SoLuongGheConLai in the KhoangChuyenBay table
ALTER TABLE VeDatPhong
ADD TongTien AS dbo.CalculateTotalPaidAmountVeDatPhong(MaDatPhong);
go

-- Create the function for calculating the remaining seat amount
-- Create the function for calculating the remaining seat amount
CREATE FUNCTION dbo.CalculateTotalPaidAmountVeMayBay(@MaVe VARCHAR(20))
RETURNS INT
AS
BEGIN
    DECLARE @TotalAmount INT;
    SELECT @TotalAmount=COALESCE(SUM(c.GiaKhoang), 0) + COALESCE(SUM(e.GiaCa * d.SoLuong), 0)
    FROM VeDatMayBay AS a
    JOIN NguoiThamGiaChuyenBay AS b ON a.MaDatVe = b.MaVeMayBay
    JOIN KhoangTrenChuyenBay as c on b.MaSoMayBay=c.MaSoMayBay AND b.LoaiKhoang=c.LoaiKhoang
    FULL OUTER JOIN GuiHanhLy as d on b.MaKhachHang=d.MaNguoiThamGiaChuyenBay 
    FULL OUTER JOIN HanhLy as e on d.LoaiHanhLyKyGui=e.LoaiHanhLyKyGui AND d.MaSoMayBay=e.MaSoMayBay
    WHERE a.MaDatVe = @MaVe AND a.MaDatVe is not null
    GROUP BY a.MaDatVe;
    RETURN ISNULL(@TotalAmount, 0);
END;
go

ALTER TABLE VeDatMayBay
ADD TongTien AS dbo.CalculateTotalPaidAmountVeMayBay(MaDatVe);
go

----------- Tong tien cua một đơn hàng

CREATE FUNCTION dbo.CalculateTotalAmount(@MaDonHang VARCHAR(20))
RETURNS INT
AS
BEGIN
    DECLARE @TotalAmount INT;

    SELECT @TotalAmount = SUM(b.TongTien) + SUM(c.TongTien) +SUM(d.TongTien)
    FROM DonHang AS a
    JOIN VeDatPhong AS b ON a.MaDonHang = b.MaDonHang
    JOIN PhieuNhaHang AS c ON a.MaDonHang = c.MaDonHang
	JOIN VeDatMayBay as d  ON a.MaDonHang =d.MaDonHang
    WHERE a.MaDonHang = @MaDonHang
    GROUP BY a.MaDonHang, a.MaKhachHang;
    RETURN ISNULL(@TotalAmount, 0);
END;
go

ALTER TABLE DonHang
ADD TongTien AS dbo.CalculateTotalAmount(MaDonHang);
go

-- Create a function for calculating the total amount for a KhachHang
CREATE FUNCTION dbo.CalculateTotalAmountPaid(@MaKhachHang VARCHAR(20))
RETURNS INT
AS
BEGIN
    DECLARE @TotalAmount INT;

    SELECT @TotalAmount = sum(b.TongTien)
    FROM KhachHang AS a
    JOIN DonHang AS b ON a.MaSoTaiKhoan = b.MaKhachHang
    WHERE a.MaSoTaiKhoan = @MaKhachHang AND b.TinhTrangDonHang='Ðã thanh toán'
    GROUP BY a.MaSoTaiKhoan;
    RETURN ISNULL(@TotalAmount,0);
END;
go
-- Add a computed column for TongTien in the KhachHang table
ALTER TABLE KhachHang
ADD TienThanhThanhToan AS dbo.CalculateTotalAmountPaid(MaSoTaiKhoan);
-- select * from KhachHang
-- select * from DonHang
go
-- Create a trigger to update customer level based on TongTien

drop trigger if exists So_Luong_Khach_Tren1Ve 
go
drop trigger if exists Tr_UpdateCustomerLevel 
go

CREATE TRIGGER Tr_UpdateCustomerLevel
ON dbo.KhachHang
AFTER INSERT, UPDATE
AS
BEGIN
    SET NOCOUNT ON;
    UPDATE KhachHang
    SET CapBac = CASE 
        WHEN KhachHang.TienThanhThanhToan > 3000000 THEN 'VIP 2'
        WHEN KhachHang.TienThanhThanhToan > 10000 THEN 'VIP 1'
        ELSE 'Normal'
      END
    FROM KhachHang
    INNER JOIN INSERTED ON KhachHang.MaSoTaiKhoan = INSERTED.MaSoTaiKhoan;
END;
go

CREATE TRIGGER So_Luong_Khach_Tren1Ve
ON dbo.NguoiThamGiaChuyenBay  
AFTER INSERT
AS 
BEGIN
    DECLARE @max_passengers_per_MaVe INT = 9;

    IF EXISTS (
        SELECT 1
        FROM (
            SELECT MaVeMayBay, COUNT(*) AS PassengerCount
            FROM NguoiThamGiaChuyenBay
            GROUP BY MaVeMayBay
        ) AS VeCounts
        WHERE PassengerCount > @max_passengers_per_MaVe
    )
    BEGIN
        DELETE FROM dbo.NguoiThamGiaChuyenBay
        WHERE MaKhachHang IN (SELECT MaKhachHang FROM INSERTED);
        RAISERROR('Số hành khách vượt cùng loại vé đã quá 9 người.', 16, 1);
    END;
END;
go
CREATE OR ALTER PROCEDURE SoluongNguoiBayTheoNgay @Date DATE
AS
BEGIN
   SELECT C.MaSo, K.LoaiKhoang, COUNT(*) AS SoLuongGhe
   FROM Chuyenbay C, KhoangTrenChuyenBay K, NguoiThamGiaChuyenBay N
   WHERE CONVERT(DATE, C.ThoiGianXuatPhat) = @Date 
      and C.MaSo = K.MaSoMayBay 
      and K.MaSoMayBay = N.MaSoMayBay 
      and K.LoaiKhoang = N.LoaiKhoang
   GROUP BY C.MaSo, K.LoaiKhoang
   ORDER BY SoLuongGhe DESC
END

-- exec SoluongNguoiBayTheoNgay @Date = '2023-03-02'
GO

CREATE OR ALTER PROCEDURE TimPhongKhachSan (@Date DATE, @City VARCHAR(20))
AS
BEGIN
   SELECT K.TenKhachSan, P.LoaiPhong, P.SoLuongCungCap, P.GiaPhong
   FROM KhachSan K, Phong P
   WHERE K.MaSoThue = P.MaSoThueKhachSan 
   and P.Ngay = @Date 
   and K.ThanhPho = @City
   ORDER BY P.GiaPhong ASC
END
GO
CREATE FUNCTION GetTopPayments
(
    @TopCount INT,
    @StartDate DATE,
    @EndDate DATE
)
RETURNS TABLE
AS
RETURN
(
    SELECT TOP (@TopCount)
        c.Ho,
        c.TenDem,
        c.Ten,sum(b.tongtien) as SoTienKhachHangDaThanhToan
    FROM
        KhachHang as a join DonHang as b on a.MaSoTaiKhoan=b.MaKhachHang
		join TaiKhoanDangNhap as c on c.MaSo=a.MaSoTaiKhoan
    WHERE
        b.NgayGiaoDich BETWEEN @StartDate AND @EndDate AND b.TinhTrangDonHang='Đã thanh toán'
		GROUP BY a.MaSoTaiKhoan,c.Ho,c.TenDem,c.Ten
    ORDER BY
        SoTienKhachHangDaThanhToan DESC
);
GO



CREATE FUNCTION ThongKeDoanhThu12Thang(@machudichvu VARCHAR(20),@tenhangmaybay VARCHAR(50),@namthongke INT)
RETURNS TABLE
AS
RETURN
(
    SELECT
        MONTH(a.NgayGiaoDich) AS Thang,
        SUM(b.TongTien) AS TongDoanhThuThang
    FROM
        DonHang as a join VeDatMayBay as b on b.MaDonHang=a.MaDonHang AND a.TinhTrangDonHang='Đã thanh toán'
		join ChuyenBay as c on b.MaSoChuyenBay=c.MaSo
		join HangHangKhong as d on c.MaSoThueCuaHangHangKhong=d.MaSoThue
		join NhaCungCapDichVu as e on d.MaDichVu=e.MaDichVu
		join ChuDichVu as f on f.MaSoTaiKhoan=e.MaChuDichVu
    WHERE
        YEAR(a.NgayGiaoDich) = @namthongke AND TinhTrangDonHang='Đã thanh toán' AND e.MaChuDichVu=@machudichvu AND d.TenHang=@tenhangmaybay
    GROUP BY
        MONTH(a.NgayGiaoDich)
);
--select * from DonHang join DonHang 
--select * from VeDatMayBay
