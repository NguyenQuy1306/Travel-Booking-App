

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
