CREATE PROCEDURE DeleteNguoiThamGiaChuyenBay
    @MaKhachHang VARCHAR(255)
AS
BEGIN
    -- Thực hiện xóa dữ liệu
    DELETE FROM NguoiThamGiaChuyenBay
    WHERE MaKhachHang = @MaKhachHang;
END;
