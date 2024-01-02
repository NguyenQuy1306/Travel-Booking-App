CREATE OR ALTER PROCEDURE TimPhongKhachSan (@DateCheckIn DATE,@DateCheckOut DATE, @City VARCHAR(20))
AS
BEGIN
   declare @period INT=DATEDIFF(DAY, @DateCheckIn, @DateCheckOut); 
   SELECT P.MaSoThueKhachSan, K.TenKhachSan, K.DiaChi, K.ThanhPho, P.LoaiPhong, P.MoTa, P.GiaPhong, min(P.SoLuongCungCap) as SoLuongCungCap
   FROM KhachSan K, Phong P
   WHERE K.MaSoThue = P.MaSoThueKhachSan and P.Ngay >= @DateCheckIn AND  P.Ngay <= @DateCheckOut and K.ThanhPho = @City
   GROUP BY  P.MaSoThueKhachSan, K.TenKhachSan, K.DiaChi, K.ThanhPho, P.LoaiPhong, P.MoTa, P.GiaPhong
   having count(*)> @period
   ORDER BY P.GiaPhong ASC
END
go
