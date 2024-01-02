CREATE TRIGGER instead_of_insert_NguoiThamGiaChuyenBay
ON NguoiThamGiaChuyenBay
INSTEAD OF INSERT
AS
BEGIN
    -- Custom logic to generate MaSo and handle the insert
    DECLARE @nextID INT;
    DECLARE @prefix VARCHAR(2);

    -- Lấy giá trị mã số tăng dần tiếp theo cho mỗi hàng
    SELECT @nextID = COALESCE(MAX(CAST(SUBSTRING(MaKhachHang, 6, LEN(MaKhachHang) - 5) AS INT)), 0) + ROW_NUMBER() OVER (ORDER BY (SELECT NULL))
    FROM NguoiThamGiaChuyenBay;
   -- SELECT TOP 1 @prefix = LEFT(MaSo, 2)
   -- FROM INSERTED;

    -- Chèn dữ liệu mới và cập nhật MaSo
    INSERT INTO NguoiThamGiaChuyenBay (HoVaTen, SoDienThoai, Email, SoCCCD, NgaySinh, MaVeMayBay, MaSoMayBay,LoaiKhoang,MaKhachHang)
    SELECT HoVaTen, SoDienThoai, Email, SoCCCD, NgaySinh, MaVeMayBay, MaSoMayBay,LoaiKhoang, 'NTGCB'  + RIGHT('000' + CAST(@nextID AS VARCHAR(3)), 3)
    FROM INSERTED;
END;

