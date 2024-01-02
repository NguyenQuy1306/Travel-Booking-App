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
select * from KhachHang
select * from DonHang
select * from KhoangTrenChuyenBay

  -- Update customer level based on total order amount
