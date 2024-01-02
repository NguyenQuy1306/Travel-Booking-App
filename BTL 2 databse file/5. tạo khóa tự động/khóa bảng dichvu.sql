CREATE TRIGGER instead_of_insert_Service
ON NhaCungCapDichVu
INSTEAD OF INSERT
AS
BEGIN
    DECLARE @nextID INT;

    SELECT @nextID = COALESCE(MAX(CAST(SUBSTRING(MaDichVu, 3, LEN(MaDichVu) - 2) AS INT)), 0) + ROW_NUMBER() OVER (ORDER BY (SELECT NULL))
    FROM NhaCungCapDichVu;

    INSERT INTO NhaCungCapDichVu (MaChuDichVu, LoaiDichVu, MaDichVu)
    SELECT MaChuDichVu, LoaiDichVu, 'DV' + RIGHT('000' + CAST(@nextID AS VARCHAR(3)), 3)
    FROM INSERTED;
END;
