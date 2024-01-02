-- THỦ TỤC 1 : Insert NguoiThamGiaChuyenBay
select * from NguoiThamGiaChuyenBay
select * from VeDatMayBay
select * from KhoangTrenChuyenBay
-- 5 dòng này sẽ là insert thành công
exec InsertNguoiThamGiaChuyenBay 'Nguyen Phi Hoang' , '0901130412' , 'nph@gmail.com' , '987134492003' , '2003-09-05' ,  'V002' , 'CB002' , 'Business'
exec InsertNguoiThamGiaChuyenBay 'Nguyen Van Hoang' , '0901130456' , 'nvh@gmail.com' , '987564492003' , '2003-09-10' ,  'V002' , 'CB002' , 'Business'
exec InsertNguoiThamGiaChuyenBay 'Nguyen Gia Phong' , '0901130412' , 'ngp@gmail.com' , '987651792003' , '2003-10-04' ,  'V001' , 'CB001' , 'Business'
exec InsertNguoiThamGiaChuyenBay 'Nguyen Gia Quy' , '0901130401' , 'ngq@gmail.com' , '987134492003' , '2003-08-04' ,  'V001' , 'CB001' , 'Business'
exec InsertNguoiThamGiaChuyenBay 'Hoang Gia Bao' , '0914748951' , 'hgb@gmail.com' , '987654652003' , '2003-05-06' ,  'V001' , 'CB001' , 'Business'

-- những dòng sau đây sẽ là lỗi
exec InsertNguoiThamGiaChuyenBay 'Hoang Gia B12' , '0914748951' , 'hgb@gmail.com' , '987654652003' , '2003-05-06' ,  'V001' , 'CB001' , 'Business'
	-- lỗi tên không có số
exec InsertNguoiThamGiaChuyenBay '' , '0914748951' , 'hgb@gmail.com' , '987654652003' , '2003-05-06' ,  'V001' , 'CB001' , 'Business'
	-- lỗi tên không được để trống
exec InsertNguoiThamGiaChuyenBay 'Nguyen Van A' , '091474895101232' , 'hgb@gmail.com' , '987654652003' , '2003-05-06' ,  'V001' , 'CB001' , 'Business'
	-- lỗi sđth quá 11 chữ số
exec InsertNguoiThamGiaChuyenBay 'Nguyen Van B' , '09147' , 'hgb@gmail.com' , '987654652003' , '2003-05-06' ,  'V001' , 'CB001' , 'Business'
	-- lỗi sđth ít hơn 7 chữ số
exec InsertNguoiThamGiaChuyenBay 'Hoang Gia Bao' , '' , 'hgb@gmail.com' , '987654652003' , '2003-05-06' ,  'V001' , 'CB001' , 'Business'
	-- lỗi sđth không được trống
exec InsertNguoiThamGiaChuyenBay 'Hoang Gia Bao' , '09147489517' , 'hgb@gmail.com' , '987654652003' , '2025-05-06' ,  'V001' , 'CB001' , 'Business'
	-- lỗi ngày sinh là tương lai
exec InsertNguoiThamGiaChuyenBay 'Hoang Gia Bao' , '09147489517' , 'hgb@gmail.com' , '987654652003' , '2023-05-06' ,  'V001' , 'CB001' , 'Business'
	-- lỗi đứa trẻ nhỏ hơn 3 tuổi, thêm vào mô tả    -> Mô tả đâu đéo thấy
exec InsertNguoiThamGiaChuyenBay 'Hoang Gia Bao' , '09147489517' , 'hgb@gmail.com' , '987654652003' , '' ,  'V001' , 'CB001' , 'Business'
	-- lỗi mô tả để trống
exec InsertNguoiThamGiaChuyenBay 'Hoang Gia Bao' , '0914748951' , 'hgb@gmail.com' , '9876546520031' , '2003-05-06' ,  'V001' , 'CB001' , 'Business'
	-- lỗi mô tả khác 12 chữ số
exec InsertNguoiThamGiaChuyenBay 'Hoang Gia Bao' , '0914748951' , 'hgb@gmail.com' , '' , '2003-05-06' ,  'V001' , 'CB001' , 'Business'
	-- lỗi cccd không được để trống nếu trên 18 tuổi
exec InsertNguoiThamGiaChuyenBay 'Hoang Gia Bao' , '0914748951' , 'hgb@gmail.com' , '' , '2023-05-06' ,  'V001' , 'CB001' , 'Business'
	-- thể hiện đứa trẻ ít hơn 3 tuổi, không cần cccd
exec InsertNguoiThamGiaChuyenBay 'Hoang Gia Bao' , '0914748951' , 'hgbgmail.com' , '987654652003' , '2003-05-06' ,  'V001' , 'CB001' , 'Business'
	-- lỗi sai format gmail

select * from NguoiThamGiaChuyenBay

-- THỦ TỤC 2 : Update NguoiThamGiaChuyenBay

delete from NguoiThamGiaChuyenBay
select * from NguoiThamGiaChuyenBay

exec UpdateNguoiThamGiaChuyenBay 'NTGCB001' , 'Hoang Gia B12' , '0914748951' , 'hgb@gmail.com' , '987654652003' , '2003-05-06' ,  'V001' , 'CB001' , 'Business'
	-- lỗi tên không có số
exec UpdateNguoiThamGiaChuyenBay 'NTGCB001' , '' , '0914748951' , 'hgb@gmail.com' , '987654652003' , '2003-05-06' ,  'V001' , 'CB001' , 'Business'
	-- lỗi tên không được để trống
exec UpdateNguoiThamGiaChuyenBay 'NTGCB001' , 'Hoang Gia Bao' , '09147489511215312' , 'hgb@gmail.com' , '987654652003' , '2003-05-06' ,  'V001' , 'CB001' , 'Business'
	-- lỗi sđth > 11 số
exec UpdateNguoiThamGiaChuyenBay 'NTGCB001' , 'Hoang Gia Bao' , '09112' , 'hgb@gmail.com' , '987654652003' , '2003-05-06' ,  'V001' , 'CB001' , 'Business'
	-- lỗi sđth < 7 số
exec UpdateNguoiThamGiaChuyenBay 'NTGCB001' , 'Hoang Gia Bao' , '' , 'hgb@gmail.com' , '987654652003' , '2003-05-06' ,  'V001' , 'CB001' , 'Business'
	-- lỗi sđth không để trống
exec UpdateNguoiThamGiaChuyenBay 'NTGCB001' , 'Hoang Gia Bao' , '09147489517' , 'hgb@gmail.com' , '987654652003' , '2025-05-06' ,  'V001' , 'CB001' , 'Business'
	-- lỗi ngày sinh tương lai
exec UpdateNguoiThamGiaChuyenBay 'NTGCB001' , 'Hoang Gia Bao' , '09147489517' , 'hgb@gmail.com' , '987654652003' , '2023-05-06' ,  'V001' , 'CB001' , 'Business'
	-- lỗi đứa trẻ 3 tuổi
exec UpdateNguoiThamGiaChuyenBay 'NTGCB001' , 'Hoang Gia Bao' , '09147489517' , 'hgb@gmail.com' , '987654652003' , '' ,  'V001' , 'CB001' , 'Business'
	-- lỗi cccd trống
exec UpdateNguoiThamGiaChuyenBay 'NTGCB001' , 'Hoang Gia Bao' , '0914748951' , 'hgb@gmail.com' , '9876546520031' , '2003-05-06' ,  'V001' , 'CB001' , 'Business'
	-- lỗi cccd khác 12 chữ số
exec UpdateNguoiThamGiaChuyenBay 'NTGCB001' , 'Hoang Gia Bao' , '0914748951' , 'hgb@gmail.com' , '' , '2003-05-06' ,  'V001' , 'CB001' , 'Business'
	-- lỗi cccd không được trống
exec UpdateNguoiThamGiaChuyenBay 'NTGCB001' , 'Hoang Gia Bao' , '0914748951' , 'hgb@gmail.com' , '' , '2023-05-06' ,  'V001' , 'CB001' , 'Business'
	-- đứa trẻ 3 tuổi không cần cccd
exec UpdateNguoiThamGiaChuyenBay 'NTGCB001' , 'Hoang Gia Bao' , '0914748951' , 'hgbgmail.com' , '987654652003' , '2003-05-06' ,  'V001' , 'CB001' , 'Business'
	-- lỗi sai format gmail


-- THỦ TỤC 3 : Delete NguoiThamGiaChuyenBay

select * from NguoiThamGiaChuyenBay

exec InsertNguoiThamGiaChuyenBay 'Hoang Gia Bao' , '0914748951' , 'hgb@gmail.com' , '987654652003' , '2003-05-06' ,  'V001' , 'CB001' , 'Business'
exec InsertNguoiThamGiaChuyenBay 'Pham Ba Hoang' , '0901130502' , 'pbh@yahoo.com' , '987654112003' , '2003-01-01' ,  'V001' , 'CB001' , 'Business'
exec InsertNguoiThamGiaChuyenBay 'Trinh Van Han' , '0901130457' , 'tvh@gmail.com' , '987654492003' , '2003-09-04' ,  'V001' , 'CB001' , 'Business'
-- xóa người trần thị B
exec DeleteNguoiThamGiaChuyenBay 'NTGCB001'  -- ma cua nguoi dau tien, chay bang NguoiThamGiaChuyenBay de lay ma roi thu xoa
select * from NguoiThamGiaChuyenBay


-- TRIGGER 1 : Cập nhật dữ liệu cấp bậc
select * from DonHang
select* from KhachHang
-- tạo  mã đơn hàng 
exec InsertAndGetAutoKey_DonHang 'TK002'

-- tạo  vé đặt máy bay
exec InsertAndGetAutoKey_VeDatMayBay 'DH002' , 'CB001'

-- tạo  vedatphong
exec InsertAndGetAutoKey_VeDatPhong 'DH002' 
-- tạo  phieunhahang cho DH002
insert into PhieuNhaHang ( MaDonHang ) 
values
('DH002');
------ check
select* from DonHang
select* from PhieuNhaHang
select * from VeDatMayBay
select * from VeDatPhong

---------
--- check lại xem mavemaybay, madatphong,madatcho ở DH002 là vé bao nhiêu
---- insert người tham gia chuyên bay với madatvemaybay tương ứng vừa tạo ở trên.
insert NguoiThamGiaChuyenBay ( HoVaTen , SoDienThoai , Email , SoCCCD , NgaySinh , MaVeMayBay , MaSoMayBay , LoaiKhoang )
values
('Hoang Gia Khanh' , '0914748941' , 'hgbb@gmail.com' , '987654652003' , '2003-05-06' ,  'V047' , 'CB001' , 'Business');
insert NguoiThamGiaChuyenBay ( HoVaTen , SoDienThoai , Email , SoCCCD , NgaySinh , MaVeMayBay , MaSoMayBay , LoaiKhoang )
values
('Pham Ba Dang' , '0901130512' , 'pbhb@yahoo.com' , '987654112003' , '2003-01-01' ,  'V047' , 'CB001' , 'Business');
insert NguoiThamGiaChuyenBay ( HoVaTen , SoDienThoai , Email , SoCCCD , NgaySinh , MaVeMayBay , MaSoMayBay , LoaiKhoang )
values
('Trinh Van Hoang' , '0901130467' , 'tvbh@gmail.com' , '987654492003' , '2003-09-04' ,  'V047' , 'CB001' , 'Business');

-- Thêm dữ liệu đặt phòng với MaDatPhong tương ứng ở trên.
insert ChonPhong ( MaSoThueKhachSan , LoaiPhong , Ngay , MaDatPhong , SoLuong )
values
('K001' , 'Normal - 2 person' , '2024-01-01' , 'VDP001' , 2 );

-- Thêm dữ liệu đặt bàn với MaDatCho tương ứng ở trên.
insert ChonBan ( MaSoThueNhaHang , LoaiBan , ThoiGian , MaDatCho , SoLuong )
values
('N001' , 'Party' , '2024-01-01' , 'VDC002' ,  2);

select * from DonHang
-- Check lại khachhang mới tongtiendathanhtoan vẫn là 0. 
select * from KhachHang
--Giả sử khách hàng thanh toán để check capbac.
update DonHang
set
 TinhTrangDonHang = 'Da thanh toan'
where DonHang.MaKhachHang = 'TK002';
select * from KhachHang

-- TRIGGER 2 : kiểm tra số lượng nguoithamgiachuyenbay trên 1 vé đặt <= 9

select * from NguoiThamGiaChuyenBay
select * from VeDatMayBay
-- 10 dòng insert, để kiểm tra trigger
 INSERT INTO NguoiThamGiaChuyenBay ( HoVaTen, SoDienThoai, Email, SoCCCD, NgaySinh, MaVeMayBay, MaSoMayBay, LoaiKhoang)
VALUES
  ( 'Hoang Gia Bao', '0914748951', 'hgb@gmail.com', '111122223331', '1995-03-08', 'V001', 'CB002', 'Economy');
   INSERT INTO NguoiThamGiaChuyenBay ( HoVaTen, SoDienThoai, Email, SoCCCD, NgaySinh, MaVeMayBay, MaSoMayBay, LoaiKhoang)
VALUES
  ( 'Pham Ba Hoang', '0914748961', 'pbh@gmail.com', '111122223332', '1995-03-18', 'V001', 'CB002', 'Economy');
   INSERT INTO NguoiThamGiaChuyenBay ( HoVaTen, SoDienThoai, Email, SoCCCD, NgaySinh, MaVeMayBay, MaSoMayBay, LoaiKhoang)
VALUES
  ( 'Trinh Van Han', '0914748971', 'tvh@gmail.com', '111122223333', '1995-03-28', 'V001', 'CB002', 'Economy');
   INSERT INTO NguoiThamGiaChuyenBay ( HoVaTen, SoDienThoai, Email, SoCCCD, NgaySinh, MaVeMayBay, MaSoMayBay, LoaiKhoang)
VALUES
  ( 'Nguyen Ngoc Quy', '0901234567', 'nnq@gmail.com', '111122223334', '1995-04-08', 'V001', 'CB002', 'Economy');
   INSERT INTO NguoiThamGiaChuyenBay ( HoVaTen, SoDienThoai, Email, SoCCCD, NgaySinh, MaVeMayBay, MaSoMayBay, LoaiKhoang)
VALUES
  ( 'Hoang Gia Han', '0901234515', 'hgh@gmail.com', '111122223335', '1995-04-18', 'V001', 'CB002', 'Economy');
   INSERT INTO NguoiThamGiaChuyenBay ( HoVaTen, SoDienThoai, Email, SoCCCD, NgaySinh, MaVeMayBay, MaSoMayBay, LoaiKhoang)
VALUES
  ( 'Hoang Gia Quy', '0901234152', 'hgq@gmail.com', '111122223336', '1995-04-28', 'V001', 'CB002', 'Economy');
   INSERT INTO NguoiThamGiaChuyenBay ( HoVaTen, SoDienThoai, Email, SoCCCD, NgaySinh, MaVeMayBay, MaSoMayBay, LoaiKhoang)
VALUES
  ( 'Pham Ba Quy', '0995234567', 'pbq@gmail.com', '111122223337', '1995-05-08', 'V001', 'CB002', 'Economy');
   INSERT INTO NguoiThamGiaChuyenBay ( HoVaTen, SoDienThoai, Email, SoCCCD, NgaySinh, MaVeMayBay, MaSoMayBay, LoaiKhoang)
VALUES
  ( 'Pham Ba Han', '0901218567', 'pghan@gmail.com', '111122223338', '1995-05-18', 'V001', 'CB002', 'Economy');

     INSERT INTO NguoiThamGiaChuyenBay ( HoVaTen, SoDienThoai, Email, SoCCCD, NgaySinh, MaVeMayBay, MaSoMayBay, LoaiKhoang)
VALUES
  ( 'Pham Ba Bao', '0901231467', 'pbb@gmail.com', '111122223339', '1995-05-28', 'V001', 'CB002', 'Economy');
     INSERT INTO NguoiThamGiaChuyenBay ( HoVaTen, SoDienThoai, Email, SoCCCD, NgaySinh, MaVeMayBay, MaSoMayBay, LoaiKhoang)
VALUES
  ( 'Trinh Van Quy', '0901034567', 'tvq@gmail.com', '111122223340', '1995-06-08', 'V001', 'CB002', 'Economy');


-- THỦ TỤC : Tìm phòng khách sạn
--có thể chạy lệnh delete mà kh conflict và  data cũ 2 bảng kh còn dùng nữa
select * from KhachSan
select * from Phong

------ Khách sạn K003 ( trường hợp có thể đặt liên tiếp 3 ngày)
 INSERT INTO KhachSan ( MaSoThue , TenKhachSan , DiaChi , ThanhPho , SoDienThoaiLeTan , MaDichVu )
VALUES
  ('K004', 'VIP Hotel', 'Đường 123 Main ','Binh Duong', '0123456789', 'DV002');
  INSERT INTO Phong (MaSoThueKhachSan, LoaiPhong, Ngay, SoLuongCungCap, MoTa, GiaPhong)
VALUES
  ('K004', 'Suite', '2024-01-01', 5, 'Spacious suite with a view', 1500000),
  ('K004', 'Standard', '2024-01-01', 10, 'Basic room for budget travelers', 500000),
  ('K004', 'Single', '2024-01-01', 8, 'Compact room for solo travelers', 300000),
   ('K004', 'Suite', '2024-01-02', 2, 'Spacious suite with a view', 1500000),
    ('K004', 'Suite', '2024-01-03', 5, 'Spacious suite with a view', 1500000);
------ Khách sạn K004 ( trường hợp không thể đặt liên tiếp 3 ngày)
 INSERT INTO KhachSan ( MaSoThue , TenKhachSan , DiaChi , ThanhPho , SoDienThoaiLeTan , MaDichVu )
VALUES
  ('K005', 'Lotus Hotel', '123 Main Street','TPHCM', '09999999987','DV002');
  INSERT INTO Phong (MaSoThueKhachSan, LoaiPhong, Ngay, SoLuongCungCap, MoTa, GiaPhong)
VALUES
  ('K005', 'Suite', '2024-01-01', 5, 'Spacious suite with a view', 1500000),
    ('K005', 'Suite', '2023-01-03', 5, 'Spacious suite with a view', 1500000);

--Gọi thủ tục
---1 OUTPUT != Rỗng . Trả về số lượng phòng của của mỗi loại phòng mà 3 ngày đều cung cấp.
DECLARE @DateCheckIn DATE = '2024-01-01';
DECLARE @DateCheckOut DATE = '2024-01-03';
DECLARE @City VARCHAR(20) = 'Binh Duong';
EXEC TimPhongKhachSan @DateCheckIn, @DateCheckOut, @City;
---2: OUTPUT = Rỗng
DECLARE @DateCheckIn DATE = '2024-01-01';
DECLARE @DateCheckOut DATE = '2024-01-03';
DECLARE @City VARCHAR(20) = 'TPHCM';
EXEC TimPhongKhachSan @DateCheckIn, @DateCheckOut, @City;

