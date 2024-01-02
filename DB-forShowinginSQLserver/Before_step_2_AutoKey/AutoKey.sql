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
    INSERT INTO ChuyenBay ( ThoiGianXuatPhat, ThoiGianHaCanh, DiaDiemXuatPhat, DiaDiemHaCanh, MaSoThueCuaHangHangKhong, MaSo)
    SELECT  ThoiGianXuatPhat, ThoiGianHaCanh, DiaDiemXuatPhat, DiaDiemHaCanh, MaSoThueCuaHangHangKhong, 'CB'  + RIGHT('000' + CAST(@nextID AS VARCHAR(3)), 3)
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

	SELECT 'V'  + RIGHT('000' + CAST(@nextID AS VARCHAR(3)), 3)

    INSERT INTO VeDatMayBay (MaDonHang, MaSoChuyenBay, MaDatVe)
    VALUES (
        @MaDonHang,
        @MaSoChuyenBay,
        'V'  + RIGHT('000' + CAST(@nextID AS VARCHAR(3)), 3)
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
    SELECT 'DH'  + RIGHT('000' + CAST(@nextID AS VARCHAR(3)), 3)


    SELECT TOP 1 @BankAccount = N.SoTaiKhoan, @Bank = N.TenNganHang FROM TaiKhoanNganHang N WHERE N.MaKhachHang = @MaKhachHang 
	SELECT TOP 1 @Assitant = NhanVien.MaSoTaiKhoan FROM NhanVien

    INSERT INTO DonHang(TinhTrangDonHang, HinhThucThanhToan, MaKhachHang, NgayGiaoDich, TaiKhoanNganHang, MaNhanVienHoTro, MaDonHang)
    VALUES ('Chua thanh toan',@Bank , @MaKhachHang, GETDATE(), @BankAccount, @Assitant, 'DH' + RIGHT('000' + CAST(@nextID AS VARCHAR(3)), 3));
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


/*
EXEC InsertAndGetAutoKey_VeDatMayBay @MaDonHang = 'DH001', @MaSoChuyenBay = 'CB002'
GO

EXEC InsertAndGetAutoKey_DonHang @MaKhachHang = 'TK001'
GO

EXEC InsertAndGetAutoKey_VeDatPhong @MaDonHang = 'DH001'
GO
*/



/*
CREATE TRIGGER instead_of_insert_DonHang
ON DonHang
INSTEAD OF INSERT
AS
BEGIN
    -- Custom logic to generate MaDonHang and handle the insert
    DECLARE @nextID INT;

    -- Lấy giá trị mã số tăng dần tiếp theo cho mỗi hàng
    SELECT @nextID = COALESCE(MAX(CAST(SUBSTRING(td.MaDonHang, 3, LEN(td.MaDonHang) - 2) AS INT)), 0) + ROW_NUMBER() OVER (ORDER BY (SELECT NULL))
    FROM DonHang td
    CROSS JOIN INSERTED;

    -- Chèn dữ liệu mới và cập nhật MaDonHang
    INSERT INTO DonHang(TinhTrangDonHang, HinhThucThanhToan, MaKhachHang,NgayGiaoDich,TaiKhoanNganHang,MaNhanVienHoTro,  MaDonHang)
    SELECT TinhTrangDonHang, HinhThucThanhToan, MaKhachHang,NgayGiaoDich,TaiKhoanNganHang,MaNhanVienHoTro, 'DH' + RIGHT('000' + CAST(@nextID AS VARCHAR(3)), 3)
    FROM INSERTED;
END;
go
*/

/*
CREATE TRIGGER instead_of_insert_VeDatMayBay
ON VeDatMayBay
INSTEAD OF INSERT
AS
BEGIN
    -- Custom logic to generate MaDatVe and handle the insert
    DECLARE @nextID INT;
    DECLARE @prefix VARCHAR(1);
    DECLARE @flightNumber INT;
    DECLARE @origin CHAR(1);
    DECLARE @destination CHAR(1);

    -- Lấy giá trị mã số tăng dần tiếp theo cho mỗi hàng
    SELECT @nextID = COALESCE(MAX(CAST(SUBSTRING(MaDatVe, 2, LEN(MaDatVe) - 1) AS INT)), 0) + ROW_NUMBER() OVER (ORDER BY (SELECT NULL))
    FROM VeDatMayBay;

    -- Lấy thông tin từ bảng ChuyenBay
    SELECT TOP 1
        @prefix = LEFT(a.TenHang, 1)
    FROM INSERTED i
    INNER JOIN ChuyenBay ch ON i.MaSoChuyenBay = ch.MaSo
    INNER JOIN HangHangKhong a ON ch.MaSoThueCuaHangHangKhong = a.MaSoThue;

    -- Chèn dữ liệu mới và cập nhật MaVeMayBay
    INSERT INTO VeDatMayBay (MaDonHang, MaSoChuyenBay, MaDatVe)
    SELECT MaDonHang, MaSoChuyenBay, @prefix +  + RIGHT('000' + CAST(@nextID AS VARCHAR(3)), 3)
    FROM INSERTED;
END;
go
*/

/*
CREATE TRIGGER instead_of_insert_VeDatPhong
ON VeDatPhong
INSTEAD OF INSERT
AS
BEGIN
    -- Custom logic to generate MaSo and handle the insert
    DECLARE @nextID INT;

    -- Lấy giá trị mã số tăng dần tiếp theo cho mỗi hàng
    SELECT @nextID = COALESCE(MAX(CAST(SUBSTRING(MaDatPhong, 4, LEN(MaDatPhong) - 3) AS INT)), 0) + ROW_NUMBER() OVER (ORDER BY (SELECT NULL))
    FROM VeDatPhong;

    -- Chèn dữ liệu mới và cập nhật MaSo
    INSERT INTO VeDatPhong (MaDonHang,MaDatPhong)
    SELECT MaDonHang, 'VDP'  + RIGHT('000' + CAST(@nextID AS VARCHAR(3)), 3)
    FROM INSERTED;
END;
go
*/
