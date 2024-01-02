-- Create the function for calculating the remaining seat amount
CREATE FUNCTION dbo.CalculateToTalLeftAmountBan(@MaSoThueNhaHang VARCHAR(20),@LoaiBan VARCHAR(20),@ThoiGian DATE)
RETURNS INT
AS
BEGIN
    DECLARE @TotalLeftAmount INT;
    SELECT @TotalLeftAmount = ISNULL(a.SoLuongCungCap, 0) - ISNULL(b.SoLuong, 0)
    FROM Ban AS a left join ChonBan as b on a.MaSoThueNhaHang=b.MaSoThueNhaHang AND a.LoaiBan=b.LoaiBan AND a.ThoiGian=b.ThoiGian
    WHERE a.MaSoThueNhaHang = @MaSoThueNhaHang AND a.LoaiBan=@LoaiBan AND a.ThoiGian=@ThoiGian
    RETURN ISNULL(@TotalLeftAmount, 0);
END;

-- Add a computed column for SoLuongGheConLai in the KhoangChuyenBay table
ALTER TABLE Ban
ADD SoLuongBanConLai AS dbo.CalculateToTalLeftAmountBan(MaSoThueNhaHang, LoaiBan,ThoiGian);
