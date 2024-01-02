CREATE TRIGGER So_Luong_Khach_Tren1Ve
ON dbo.NguoiThamGiaChuyenBay  
AFTER INSERT
AS 
BEGIN
    DECLARE @max_passengers_per_MaVe INT = 9;

    IF EXISTS (
        SELECT 1
        FROM (
            SELECT MaVeMayBay, COUNT(*) AS PassengerCount
            FROM NguoiThamGiaChuyenBay
            GROUP BY MaVeMayBay
        ) AS VeCounts
        WHERE PassengerCount > @max_passengers_per_MaVe
    )
    BEGIN
        DELETE FROM dbo.NguoiThamGiaChuyenBay
        WHERE MaKhachHang IN (SELECT MaKhachHang FROM INSERTED);
        RAISERROR('Số hành khách vượt cùng loại vé đã quá 9 người.', 16, 1);
    END;
END;
