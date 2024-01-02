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


ALTER TABLE VeDatMayBay
ADD TongTien AS dbo.CalculateTotalPaidAmountVeMayBay(MaDatVe);
select * from VeDatMayBay
--select * from GuiHanhLy
