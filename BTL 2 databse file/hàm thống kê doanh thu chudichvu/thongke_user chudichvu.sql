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
        b.NgayGiaoDich BETWEEN @StartDate AND @EndDate AND b.TinhTrangDonHang='Da thanh toan'
		GROUP BY a.MaSoTaiKhoan,c.Ho,c.TenDem,c.Ten
    ORDER BY
        SoTienKhachHangDaThanhToan DESC
);
