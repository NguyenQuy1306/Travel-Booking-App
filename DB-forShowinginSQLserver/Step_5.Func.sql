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
        c.Ten,sum(b.TongTien) as SoTienKhachHangDaThanhToan
    FROM
        KhachHang as a join DonHang as b on a.MaSoTaiKhoan=b.MaKhachHang
		join TaiKhoanDangNhap as c on c.MaSo=a.MaSoTaiKhoan
    WHERE
        b.NgayGiaoDich BETWEEN @StartDate AND @EndDate AND b.TinhTrangDonHang='Da thanh toan'
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
        MONTH(c.ThoiGianXuatPhat) AS Thang,
        SUM(b.TongTien) AS TongDoanhThuThang
    FROM
        DonHang as a join VeDatMayBay as b on b.MaDonHang=a.MaDonHang AND a.TinhTrangDonHang='Da thanh toan'
		join ChuyenBay as c on b.MaSoChuyenBay=c.MaSo
		join HangHangKhong as d on c.MaSoThueCuaHangHangKhong=d.MaSoThue
		join NhaCungCapDichVu as e on d.MaDichVu=e.MaDichVu
		join ChuDichVu as f on f.MaSoTaiKhoan=e.MaChuDichVu
    WHERE
        YEAR(c.ThoiGianXuatPhat) = @namthongke AND TinhTrangDonHang='Da thanh toan' AND e.MaChuDichVu=@machudichvu AND d.TenHang=@tenhangmaybay
    GROUP BY
        MONTH(c.ThoiGianXuatPhat)
);
--select * from DonHang join DonHang 
--select * from VeDatMayBay

--select * from DonHang join DonHang 
--select * from VeDatMayBay

--select * from ThongKeDoanhThu12Thang('TK003','AirAsia','2023')
--select * from HangHangKhong

