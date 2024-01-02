---Nếu chạy trong tất cả file trong folder autokey ở trên rồi thì khỏi chạy lại file này

CREATE OR ALTER PROCEDURE InsertAndGetAutoKey_VeDatMayBay
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

/*
EXEC InsertAndGetAutoKey_VeDatMayBay @MaDonHang = 'DH001', @MaSoChuyenBay = 'CB002'
GO
*/

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

/*
EXEC InsertAndGetAutoKey_DonHang @MaKhachHang = 'TK001'
GO
*/

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

EXEC InsertAndGetAutoKey_VeDatPhong @MaDonHang = 'DH001'
GO
