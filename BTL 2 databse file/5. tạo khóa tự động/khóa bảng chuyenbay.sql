CREATE TRIGGER instead_of_insert_ChuyenBay
ON ChuyenBay
INSTEAD OF INSERT
AS
BEGIN
    -- Custom logic to generate MaSo and handle the insert
    DECLARE @nextID INT;
    DECLARE @prefix VARCHAR(2);

    -- Lấy giá trị mã số tăng dần tiếp theo cho mỗi hàng
    SELECT @nextID = COALESCE(MAX(CAST(SUBSTRING(MaSo, 3, LEN(MaSo) - 2) AS INT)), 0) + ROW_NUMBER() OVER (ORDER BY (SELECT NULL))
    FROM ChuyenBay;
   -- SELECT TOP 1 @prefix = LEFT(MaSo, 2)
   -- FROM INSERTED;

    -- Chèn dữ liệu mới và cập nhật MaSo
    INSERT INTO ChuyenBay ( ThoiGianXuatPhat, ThoiGianHaCanh, DiaDiemXuatPhat, DiaDiemHaCanh, MaSoThueCuaHangHangKhong, MaSo)
    SELECT  ThoiGianXuatPhat, ThoiGianHaCanh, DiaDiemXuatPhat, DiaDiemHaCanh, MaSoThueCuaHangHangKhong, 'CB'  + RIGHT('000' + CAST(@nextID AS VARCHAR(3)), 3)
    FROM INSERTED;
END;
go
