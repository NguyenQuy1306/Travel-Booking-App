CREATE OR ALTER PROCEDURE InsertAndGetAutoKey_VeDatMayBay
(
    @MaDonHang VARCHAR(20),
    @MaSoChuyenBay VARCHAR(20)
)
AS
BEGIN
    DECLARE @NextID INT;

    WITH CTE AS (
        SELECT 
            COALESCE(MAX(CAST(SUBSTRING(MaDatVe, 2, LEN(MaDatVe) - 1) AS INT)), 0) + ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) AS NextID
        FROM VeDatMayBay
    )
    SELECT @NextID = NextID FROM CTE;

	SELECT 'V'  + RIGHT('000' + CAST(@nextID AS VARCHAR(3)), 3)

    INSERT INTO VeDatMayBay (MaDonHang, MaSoChuyenBay, MaDatVe)
    VALUES (
        @MaDonHang,
        @MaSoChuyenBay,
        'V'  + RIGHT('000' + CAST(@nextID AS VARCHAR(3)), 3)
    );
END;
