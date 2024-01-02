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
