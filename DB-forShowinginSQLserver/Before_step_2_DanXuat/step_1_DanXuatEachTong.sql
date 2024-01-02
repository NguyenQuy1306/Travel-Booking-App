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
-- select * from VeDatMayBay
--select * from GuiHanhLy
