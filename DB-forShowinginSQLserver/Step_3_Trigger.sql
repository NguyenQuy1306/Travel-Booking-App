-- Create a trigger to update customer level based on TongTien

drop trigger if exists So_Luong_Khach_Tren1Ve 
go
drop trigger if exists Tr_UpdateCustomerLevel 
go

drop trigger if exists delete_NguoiThamGiaChuyenBay

CREATE TRIGGER Tr_UpdateCustomerLevel
ON DonHang
AFTER UPDATE
AS
BEGIN
  SET NOCOUNT ON;

  UPDATE KhachHang
  SET CapBac = 
      CASE 
        WHEN a.TienDaThanhToan > 10000000 THEN 'VIP 2'
        WHEN a.TienDaThanhToan > 3000000 THEN 'VIP 1'
        ELSE 'Normal'
      END
  FROM KhachHang as a join DonHang as b on a.MaSoTaiKhoan=b.MaKhachHang
  WHERE b.TinhTrangDonHang='Da thanh toan'
  
END;
--test: UPDATE DonHang SET TinhTrangDonHang = 'Da thanh toan' WHERE MaDonHang = 'DH004';

go

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
go

CREATE TRIGGER delete_NguoiThamGiaChuyenBay
ON dbo.NguoiThamGiaChuyenBay
AFTER DELETE 
AS 
BEGIN 
    IF EXISTS (
		select * from VeDatMayBay FULL OUTER JOIN NguoiThamGiaChuyenBay on VeDatMayBay.MaDatVe = NguoiThamGiaChuyenBay.MaVeMayBay
		where VeDatMayBay.TongTien = 0
	)
	BEGIN 
		DELETE FROM dbo.VeDatMayBay
		WHERE MaDatVe IN ( select MaVeMayBay from deleted)
	END
END;

