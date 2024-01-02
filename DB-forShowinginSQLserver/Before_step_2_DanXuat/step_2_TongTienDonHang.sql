
----------- Tong tien cua một đơn hàng

CREATE FUNCTION dbo.CalculateTotalAmount(@MaDonHang VARCHAR(20))
RETURNS INT
AS
BEGIN
    DECLARE @TotalAmount1 INT;
	DECLARE @TotalAmount2 INT;
	DECLARE @TotalAmount3 INT;
    SELECT @TotalAmount1= ISNULL(SUM(b.TongTien),0)
    FROM DonHang AS a
	LEFT  JOIN VeDatPhong AS b ON a.MaDonHang = b.MaDonHang
		WHERE A.MaDonHang=@MaDonHang

    GROUP BY a.MaDonHang;

	 SELECT @TotalAmount2= ISNULL(SUM(c.TongTien),0) 
    FROM DonHang AS a
    LEFT JOIN PhieuNhaHang AS c ON a.MaDonHang = c.MaDonHang
		WHERE A.MaDonHang=@MaDonHang
    GROUP BY a.MaDonHang;

	 SELECT @TotalAmount3=ISNULL(SUM(d.TongTien),0)
    FROM DonHang AS a
	LEFT JOIN VeDatMayBay as d  ON a.MaDonHang =d.MaDonHang
	WHERE A.MaDonHang=@MaDonHang
    GROUP BY a.MaDonHang;


    RETURN ISNULL(@TotalAmount1+@TotalAmount2+@TotalAmount3, 0);
END;

ALTER TABLE DonHang
ADD TongTien AS dbo.CalculateTotalAmount(MaDonHang);
go

