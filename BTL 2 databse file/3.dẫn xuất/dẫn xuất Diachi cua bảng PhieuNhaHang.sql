-- Create the function for calculating the remaining seat amount
CREATE FUNCTION dbo.DiaChiPhieuNhaHang(@MaDatCho VARCHAR(20))
RETURNS VARCHAR
AS
BEGIN
    DECLARE @DiaChi VARCHAR(50);
    SELECT @DiaChi = d.DiaChi
    FROM PhieuNhaHang AS a join ChonBan as b on a.MaDatCho=b.MaDatCho
	JOIN Ban as c on b.MaSoThueNhaHang=c.MaSoThueNhaHang AND b.LoaiBan=c.LoaiBan AND b.ThoiGian=c.ThoiGian
	JOIN NhaHang as d on d.MaSoThue=c.MaSoThueNhaHang
    WHERE a.MaDatCho = @MaDatCho
    RETURN ISNULL(@DiaChi, '');
END;

-- Add a computed column for SoLuongGheConLai in the KhoangChuyenBay table
ALTER TABLE PhieuNhaHang
ADD DiaChi AS dbo.DiaChiPhieuNhaHang(MaDatCho);

select * from PhieuNhaHang