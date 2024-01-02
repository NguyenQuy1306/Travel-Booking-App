CREATE FUNCTION dbo.CalculateToTalLeftAmountPhong(@MaSoThueKhachSan VARCHAR(20),@LoaiPhong VARCHAR(20),@Ngay DATE)
RETURNS INT
AS
BEGIN
    DECLARE @TotalLeftAmount INT;
    SELECT @TotalLeftAmount = ISNULL(a.SoLuongCungCap, 0) - ISNULL(b.SoLuong, 0)
    FROM Phong AS a left join ChonPhong as b on a.MaSoThueKhachSan=b.MaSoThueKhachSan AND a.LoaiPhong=b.LoaiPhong AND a.Ngay=b.Ngay
    WHERE a.MaSoThueKhachSan = @MaSoThueKhachSan AND a.LoaiPhong=@LoaiPhong AND a.Ngay=@Ngay
    RETURN ISNULL(@TotalLeftAmount, 0);
END;

-- Add a computed column for SoLuongGheConLai in the KhoangChuyenBay table
ALTER TABLE Phong
ADD SoLuongPhongConLai AS dbo.CalculateToTalLeftAmountPhong(MaSoThueKhachSan, LoaiPhong,Ngay);
