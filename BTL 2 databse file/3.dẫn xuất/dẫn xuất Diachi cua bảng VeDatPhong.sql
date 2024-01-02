-- Create the function for calculating the remaining seat amount
CREATE FUNCTION dbo.DiaChiVeDatPhong(@MaDatPhong VARCHAR(20))
RETURNS VARCHAR
AS
BEGIN
    DECLARE @DiaChi VARCHAR(50);
    SELECT @DiaChi = d.DiaChi
    FROM VeDatPhong AS a join ChonPhong as b on a.MaDatPhong=b.MaDatPhong
	JOIN Phong as c on b.MaSoThueKhachSan=c.MaSoThueKhachSan AND b.LoaiPhong=c.LoaiPhong AND b.Ngay=c.Ngay
	JOIN KhachSan as d on d.MaSoThue=c.MaSoThueKhachSan
    WHERE a.MaDatPhong = @MaDatPhong
    RETURN ISNULL(@DiaChi, '');
END;

-- Add a computed column for SoLuongGheConLai in the KhoangChuyenBay table
ALTER TABLE VeDatPhong
ADD DiaChi AS dbo.DiaChiVeDatPhong(MaDatPhong);

select * from VeDatPhong