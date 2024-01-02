CREATE OR ALTER PROCEDURE InsertAndGetAutoKey_VeDatPhong
(
    @MaDonHang VARCHAR(20)
)
AS
BEGIN
     DECLARE @nextID INT;

    -- Lấy giá trị mã số tăng dần tiếp theo cho mỗi hàng
    SELECT @nextID = COALESCE(MAX(CAST(SUBSTRING(MaDatPhong, 4, LEN(MaDatPhong) - 3) AS INT)), 0) + ROW_NUMBER() OVER (ORDER BY (SELECT NULL))
    FROM VeDatPhong;

	SELECT 'VDP'  + RIGHT('000' + CAST(@nextID AS VARCHAR(3)), 3)

    -- Chèn dữ liệu mới và cập nhật MaSo
    INSERT INTO VeDatPhong (MaDonHang,MaDatPhong)
    VALUES( @MaDonHang, 'VDP'  + RIGHT('000' + CAST(@nextID AS VARCHAR(3)), 3));
END;
