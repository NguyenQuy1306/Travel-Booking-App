CREATE FUNCTION dbo.CalculateSeatLeftAmount(@MaSoMayBay VARCHAR(20), @LoaiKhoang VARCHAR(20))
RETURNS INT
AS
BEGIN
    DECLARE @TotalLeftAmount INT;
	DECLARE @SoLuongGheToiDaCungCap INT
    SELECT @TotalLeftAmount = ISNULL(a.SoLuongGheToiDaCungCap, a.SoLuongGheToiDaCungCap) - ISNULL(Count(*), 0)
    FROM KhoangTrenChuyenBay AS a
    JOIN NguoiThamGiaChuyenBay AS b ON a.LoaiKhoang = b.LoaiKhoang AND a.MaSoMayBay = b.MaSoMayBay
    WHERE a.MaSoMayBay = @MaSoMayBay AND a.LoaiKhoang = @LoaiKhoang
    GROUP BY a.MaSoMayBay, a.LoaiKhoang,a.SoLuongGheToiDaCungCap;
	select @SoLuongGheToiDaCungCap = c.SoLuongGheToiDaCungCap from KhoangTrenChuyenBay as c where c.MaSoMayBay=@MaSoMayBay AND c.LoaiKhoang=@LoaiKhoang;
    RETURN ISNULL(@TotalLeftAmount, @SoLuongGheToiDaCungCap);
END;

-- Add a computed column for SoLuongGheConLai in the KhoangTrenChuyenBay table
ALTER TABLE KhoangTrenChuyenBay
ADD SoLuongGheConLai AS dbo.CalculateSeatLeftAmount(MaSoMayBay, LoaiKhoang);
