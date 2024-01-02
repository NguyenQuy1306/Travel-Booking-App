CREATE TRIGGER instead_of_insert_PhieuNhaHang
ON PhieuNhaHang
INSTEAD OF INSERT
AS
BEGIN
    -- Custom logic to generate MaSo and handle the insert
    DECLARE @nextID INT;

    -- Lấy giá trị mã số tăng dần tiếp theo cho mỗi hàng
    SELECT @nextID = COALESCE(MAX(CAST(SUBSTRING(MaDatCho, 4, LEN(MaDatCho) - 3) AS INT)), 0) + ROW_NUMBER() OVER (ORDER BY (SELECT NULL))
    FROM PhieuNhaHang;

    -- Chèn dữ liệu mới và cập nhật MaSo
    INSERT INTO PhieuNhaHang (MaDonHang,MaDatCho)
    SELECT MaDonHang, 'VDC'  + RIGHT('000' + CAST(@nextID AS VARCHAR(3)), 3)
    FROM INSERTED;
END;
