CREATE TRIGGER instead_of_insert_TaiKhoanDangNhap
ON TaiKhoanDangNhap
INSTEAD OF INSERT
AS
BEGIN
    -- Custom logic to generate MaSo and handle the insert
    DECLARE @nextID INT;

    -- Lấy giá trị mã số tăng dần tiếp theo cho mỗi hàng
    SELECT @nextID = COALESCE(MAX(CAST(SUBSTRING(td.MaSo, 3, LEN(td.MaSo) - 2) AS INT)), 0) + ROW_NUMBER() OVER (ORDER BY (SELECT NULL))
    FROM TaiKhoanDangNhap td
    CROSS JOIN INSERTED;

    -- Chèn dữ liệu mới và cập nhật MaSo
    INSERT INTO TaiKhoanDangNhap (Ho, TenDem, Ten, NgaySinh, GioiTinh, SoCCCD, MaSo, TenDangNhap , MatKhau)
    SELECT Ho, TenDem, Ten, NgaySinh, GioiTinh, SoCCCD, 'TK' + RIGHT('000' + CAST(@nextID AS VARCHAR(3)), 3), TenDangNhap,MatKhau
    FROM INSERTED;
END;
