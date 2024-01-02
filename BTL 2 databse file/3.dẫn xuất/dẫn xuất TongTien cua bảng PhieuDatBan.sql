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

-- Add a computed column for SoLuongGheConLai in the KhoangChuyenBay table
ALTER TABLE PhieuNhaHang
ADD TongTien AS dbo.CalculateTotalPaidAmountPhieuNhaHang(MaDatCho);


select * from PhieuNhaHang


