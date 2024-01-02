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

-- Add a computed column for SoLuongGheConLai in the KhoangChuyenBay table
ALTER TABLE VeDatPhong
ADD TongTien AS dbo.CalculateTotalPaidAmountVeDatPhong(MaDatPhong);

select * from VeDatPhong


