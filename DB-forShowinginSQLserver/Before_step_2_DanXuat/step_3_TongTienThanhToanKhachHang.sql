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
ADD TienDaThanhToan AS dbo.CalculateTotalAmountPaid(MaSoTaiKhoan);
-- select * from KhachHang
-- select * from DonHang
go
