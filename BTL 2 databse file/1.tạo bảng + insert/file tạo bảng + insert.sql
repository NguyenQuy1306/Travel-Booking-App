CREATE TABLE TaiKhoanDangNhap (
  MaSo VARCHAR(20)  PRIMARY KEY,
  Ho VARCHAR(20) NOT NULL,
  TenDem VARCHAR(20) NOT NULL,
  Ten VARCHAR(20) NOT NULL,
  NgaySinh DATE NOT NULL,
  GioiTinh CHAR(20) NOT NULL,
  SoCCCD VARCHAR(20) NOT NULL,
  TenDangNhap VARCHAR(20) NOT NULL,
  MatKhau VARCHAR(20) NOT NULL
);
-- check
CREATE TABLE SoDienThoai (
  MaSoTaiKhoan VARCHAR(20) NOT NULL,
  SoDienThoai VARCHAR(20) NOT NULL,
  PRIMARY KEY (MaSoTaiKhoan, SoDienThoai),
  FOREIGN KEY (MaSoTaiKhoan) REFERENCES TaiKhoanDangNhap(MaSo)
);

CREATE TABLE Email (
  MaSoTaiKhoan VARCHAR(20) NOT NULL,
  Email VARCHAR(255) NOT NULL,
  PRIMARY KEY (MaSoTaiKhoan, Email),
  FOREIGN KEY (MaSoTaiKhoan) REFERENCES TaiKhoanDangNhap(MaSo)
);

CREATE TABLE ChuDichVu (
  MaSoTaiKhoan VARCHAR(20) ,
  PRIMARY KEY (MaSoTaiKhoan),
  FOREIGN KEY (MaSoTaiKhoan) REFERENCES TaiKhoanDangNhap(MaSo)
);

CREATE TABLE NhanVien (
  MaSoTaiKhoan VARCHAR(20) ,
  ThoiGianLamViec TIME NOT NULL,
  NgayBatDauLam DATE NOT NULL,
  MaNhanVienQuanLy VARCHAR(20),
  PRIMARY KEY (MaSoTaiKhoan),
  FOREIGN KEY (MaSoTaiKhoan) REFERENCES TaiKhoanDangNhap(MaSo),
  FOREIGN KEY (MaNhanVienQuanLy) REFERENCES NhanVien(MaSoTaiKhoan)
);

CREATE TABLE KhachHang (
  MaSoTaiKhoan VARCHAR(20),
  CapBac VARCHAR(20) NOT NULL,
  PRIMARY KEY (MaSoTaiKhoan),
  FOREIGN KEY (MaSoTaiKhoan) REFERENCES TaiKhoanDangNhap(MaSo)
);

CREATE TABLE TaiKhoanNganHang (
  SoTaiKhoan VARCHAR(20) NOT NULL,
  TenNganHang VARCHAR(50) NOT NULL,
  MaKhachHang VARCHAR(20) NOT NULL,
  TrangThai VARCHAR(20) NOT NULL,
  PRIMARY KEY (SoTaiKhoan),
  FOREIGN KEY (MaKhachHang) REFERENCES KhachHang(MaSoTaiKhoan)
);

CREATE TABLE DonHang (
  MaDonHang VARCHAR(20) ,
  TinhTrangDonHang VARCHAR(20) NOT NULL,
  HinhThucThanhToan VARCHAR(20) NOT NULL,
  MaKhachHang VARCHAR(20) NOT NULL,
  NgayGiaoDich DATE NOT NULL,
  TaiKhoanNganHang VARCHAR(20) NOT NULL,
  MaNhanVienHoTro VARCHAR(20) NOT NULL,
  PRIMARY KEY (MaDonHang),
  FOREIGN KEY (MaKhachHang) REFERENCES KhachHang(MaSoTaiKhoan),
  FOREIGN KEY (TaiKhoanNganHang) REFERENCES TaiKhoanNganHang(SoTaiKhoan),
  FOREIGN KEY (MaNhanVienHoTro) REFERENCES NhanVien(MaSoTaiKhoan)
);

CREATE TABLE NhaCungCapDichVu (
  MaDichVu VARCHAR(20) ,
  MaChuDichVu VARCHAR(20) NOT NULL,
  LoaiDichVu VARCHAR(50) NOT NULL,
  PRIMARY KEY (MaDichVu),
  FOREIGN KEY (MaChuDichVu) REFERENCES ChuDichVu(MaSoTaiKhoan)
);

CREATE TABLE HangHangKhong (
  MaSoThue VARCHAR(20) NOT NULL,
  TenHang VARCHAR(50) NOT NULL,
  MoTa VARCHAR(255) ,
  SoDienThoaiTuVanVien VARCHAR(20) NOT NULL,
  MaDichVu VARCHAR(20) NOT NULL,
  PRIMARY KEY (MaSoThue),
  FOREIGN KEY (MaDichVu) REFERENCES NhaCungCapDichVu(MaDichVu)
);

CREATE TABLE ChuyenBay (
  MaSo VARCHAR(20) NOT NULL,
  ThoiGianXuatPhat DATETIME NOT NULL,
  ThoiGianHaCanh DATETIME NOT NULL,
  DiaDiemXuatPhat VARCHAR(50) NOT NULL,
  DiaDiemHaCanh VARCHAR(50) NOT NULL,
  MaSoThueCuaHangHangKhong VARCHAR(20) NOT NULL,
  PRIMARY KEY (MaSo),
  FOREIGN KEY (MaSoThueCuaHangHangKhong) REFERENCES HangHangKhong(MaSoThue)
);

CREATE TABLE KhoangTrenChuyenBay (
  MaSoMayBay VARCHAR(20) NOT NULL,
  LoaiKhoang VARCHAR(20) NOT NULL,
  GiaKhoang DECIMAL(10,2) NOT NULL,
  SoLuongGheToiDaCungCap INT NOT NULL,
  MoTa VARCHAR(255) ,
  PRIMARY KEY (MaSoMayBay, LoaiKhoang),
  FOREIGN KEY (MaSoMayBay) REFERENCES ChuyenBay(MaSo)
);

CREATE TABLE VeDatMayBay (
  MaDatVe VARCHAR(20) ,
  MaDonHang VARCHAR(20) NOT NULL,
  MaSoChuyenBay VARCHAR(20) NOT NULL,
  PRIMARY KEY (MaDatVe),
  FOREIGN KEY (MaDonHang) REFERENCES DonHang(MaDonHang),
  FOREIGN KEY (MaSoChuyenBay) REFERENCES ChuyenBay(MaSo)
);

CREATE TABLE NguoiThamGiaChuyenBay (
  MaKhachHang VARCHAR(255) ,
  HoVaTen VARCHAR(40) NOT NULL,
  SoDienThoai VARCHAR(20) NOT NULL,
  Email VARCHAR(255) NOT NULL,
  SoCCCD VARCHAR(20) NOT NULL,
  NgaySinh DATE NOT NULL,
  MaVeMayBay VARCHAR(20) NOT NULL,
  MaSoMayBay VARCHAR(20) NOT NULL,
  LoaiKhoang VARCHAR(20) NOT NULL,
  MoTa VARCHAR(255)
  PRIMARY KEY (MaKhachHang),
  FOREIGN KEY (MaVeMayBay) REFERENCES VeDatMayBay(MaDatVe) ON DELETE CASCADE,
  FOREIGN KEY (MaSoMayBay, LoaiKhoang) REFERENCES KhoangTrenChuyenBay(MaSoMayBay, LoaiKhoang)
);

CREATE TABLE HanhLy (
  MaSoMayBay VARCHAR(20) NOT NULL,
  LoaiHanhLyKyGui VARCHAR(20) NOT NULL,
  ChiTiet VARCHAR(255) NOT NULL,
  GiaCa DECIMAL(10,2) NOT NULL,
  PRIMARY KEY (MaSoMayBay, LoaiHanhLyKyGui),
  FOREIGN KEY (MaSoMayBay) REFERENCES ChuyenBay(MaSo),
);
CREATE TABLE GuiHanhLy (
  MaSoMayBay VARCHAR(20) NOT NULL,
  LoaiHanhLyKyGui VARCHAR(20) NOT NULL,
  MaNguoiThamGiaChuyenBay VARCHAR(255) NOT NULL,
  SoLuong INT NOT NULL,
  PRIMARY KEY (MaSoMayBay, LoaiHanhLyKyGui,MaNguoiThamGiaChuyenBay),
  FOREIGN KEY (MaSoMayBay,LoaiHanhLyKyGui) REFERENCES HanhLy(MaSoMayBay,LoaiHanhLyKyGui),
  FOREIGN KEY (MaNguoiThamGiaChuyenBay) REFERENCES NguoiThamGiaChuyenBay(MaKhachHang)
);
CREATE TABLE KhachSan (
  MaSoThue VARCHAR(20) NOT NULL,
  TenKhachSan VARCHAR(50) NOT NULL,
  DiaChi VARCHAR(50) NOT NULL,
  ThanhPho VARCHAR(20) NOT NULL,
  SoDienThoaiLeTan VARCHAR(20) NOT NULL,
  MaDichVu VARCHAR(20) NOT NULL,
  PRIMARY KEY (MaSoThue),
  FOREIGN KEY (MaDichVu) REFERENCES NhaCungCapDichVu(MaDichVu)
);

CREATE TABLE Phong (
  MaSoThueKhachSan VARCHAR(20) NOT NULL,
  LoaiPhong VARCHAR(20) NOT NULL,
  Ngay DATE NOT NULL,
  SoLuongCungCap INT NOT NULL,
  MoTa VARCHAR(255),
  GiaPhong DECIMAL(10,2) NOT NULL,
  PRIMARY KEY (MaSoThueKhachSan, LoaiPhong, Ngay),
  FOREIGN KEY (MaSoThueKhachSan) REFERENCES KhachSan(MaSoThue)
);

CREATE TABLE VeDatPhong (
  MaDatPhong VARCHAR(20) ,
  MaDonHang VARCHAR(20) NOT NULL,
  PRIMARY KEY (MaDatPhong),
  FOREIGN KEY (MaDonHang) REFERENCES DonHang(MaDonHang)
);

CREATE TABLE ChonPhong (
  MaSoThueKhachSan VARCHAR(20) NOT NULL,
  LoaiPhong VARCHAR(20) NOT NULL,
  Ngay DATE NOT NULL,
  MaDatPhong VARCHAR(20) NOT NULL, 
  SoLuong INT NOT NULL,
  PRIMARY KEY (MaSoThueKhachSan, LoaiPhong, Ngay, MaDatPhong),
  FOREIGN KEY (MaSoThueKhachSan, LoaiPhong, Ngay) REFERENCES Phong(MaSoThueKhachSan, LoaiPhong, Ngay),
  FOREIGN KEY (MaDatPhong) REFERENCES VeDatPhong(MaDatPhong)
);

CREATE TABLE NhaHang (
  MaSoThue VARCHAR(20) NOT NULL,
  TenNhaHang VARCHAR(50) NOT NULL,
  DiaChi VARCHAR(50) NOT NULL,
  MoTa VARCHAR(255) ,
  SoDienThoaiQuanLy VARCHAR(20) NOT NULL,
  MaDichVu VARCHAR(20) NOT NULL,
  PRIMARY KEY (MaSoThue),
  FOREIGN KEY (MaDichVu) REFERENCES NhaCungCapDichVu(MaDichVu)
);

CREATE TABLE Ban (
  MaSoThueNhaHang VARCHAR(20) NOT NULL,
  LoaiBan VARCHAR(20) NOT NULL,
  ThoiGian DATETIME NOT NULL,
  SoLuongCungCap INT NOT NULL,
  SoLuongNguoiToiDa1Ban INT NOT NULL,
  MoTa VARCHAR(255) ,
  Gia DECIMAL(10,2) NOT NULL,
  PRIMARY KEY (MaSoThueNhaHang, LoaiBan, ThoiGian),
  FOREIGN KEY (MaSoThueNhaHang) REFERENCES NhaHang(MaSoThue)
);

CREATE TABLE PhieuNhaHang (
  MaDatCho VARCHAR(20) ,
  MaDonHang VARCHAR(20) NOT NULL,
  PRIMARY KEY (MaDatCho),
  FOREIGN KEY (MaDonHang) REFERENCES DonHang(MaDonHang)
);

CREATE TABLE ChonBan (
  MaSoThueNhaHang VARCHAR(20) NOT NULL,
  LoaiBan VARCHAR(20) NOT NULL,
  ThoiGian DATETIME NOT NULL,
  MaDatCho VARCHAR(20) NOT NULL,
  SoLuong INT NOT NULL,
  PRIMARY KEY (MaSoThueNhaHang, LoaiBan, ThoiGian, MaDatCho),
  FOREIGN KEY (MaSoThueNhaHang, LoaiBan, ThoiGian) REFERENCES Ban(MaSoThueNhaHang, LoaiBan, ThoiGian),
  FOREIGN KEY (MaDatCho) REFERENCES PhieuNhaHang(MaDatCho)
);


--1.1.2
---1.2.1 Thủ tục
----------
ALTER TABLE TaiKhoanDangNhap
ADD CHECK (GioiTinh IN ('F', 'M'))

ALTER TABLE KhoangTrenChuyenBay
ADD CHECK (SoLuongGheToiDaCungCap > 0);

ALTER TABLE GuiHanhLy
ADD CHECK (SoLuong >= 0);

ALTER TABLE Phong
ADD CHECK (SoLuongCungCap > 0);

ALTER TABLE ChonPhong
ADD CHECK (SoLuong >= 0);

ALTER TABLE Ban
ADD CHECK (SoLuongCungCap > 0);

ALTER TABLE Ban
ADD CHECK (SoLuongNguoiToiDa1Ban > 0);

ALTER TABLE ChonBan
ADD CHECK (SoLuong >= 0);

/*
-- :)) nhap dữ liệu phải ghi lại câu insert chán quá
-- Dữ liệu cho bảng TaiKhoanDangNhap
INSERT INTO TaiKhoanDangNhap(Ho,TenDem,Ten,NgaySinh,GioiTinh,SoCCCD) VALUES
( 'Nguyen', 'Van', 'A', '1990-01-15', 'M', '123456789082');

INSERT INTO TaiKhoanDangNhap(Ho,TenDem,Ten,NgaySinh,GioiTinh,SoCCCD) VALUES
( 'Tran', 'Thi', 'B', '1985-05-20', 'F', '987654321091');
INSERT INTO TaiKhoanDangNhap(Ho,TenDem,Ten,NgaySinh,GioiTinh,SoCCCD) VALUES
( 'Nguyen', 'Ngoc', 'C', '1995-06-26', 'F', '987654321048');
INSERT INTO TaiKhoanDangNhap(Ho,TenDem,Ten,NgaySinh,GioiTinh,SoCCCD) VALUES
( 'Tran', 'Van', 'D', '2024-01-15', 'F', '123');
EXEC UpdateTaiKhoanDangNhap
	@Maso='TK008',
    @Ho = 'Tran',
    @TenDem = 'Van',
    @Ten = 'D',
    @NgaySinh = '2023-01-15',
    @GioiTinh = 'F',
    @SoCCCD = '999999999999';
	EXEC InsertTaiKhoanDangNhap
    @Ho = 'Tran',
    @TenDem = 'Van',
    @Ten = 'quy',
    @NgaySinh = '2023-01-15',
    @GioiTinh = 'F',
    @SoCCCD = '121111135511';
select * from TaiKhoanDangNhap
EXEC DeleteTaiKhoanDangNhap
 @MaSo ='TK007'



INSERT INTO SoDienThoai (MaSoTaiKhoan, SoDienThoai)
VALUES
  ('TK001', '0901234567'),
  ('TK001', '0912345678'),
  ('TK002', '0987654321');

-- Sample data for Email
INSERT INTO Email (MaSoTaiKhoan, Email)
VALUES
  ('TK001', 'nguyena@gmail.com'),
  ('TK002', 'tranb@yahoo.com'),
  ('TK003', 'lecv@gmail.com');

-- Sample data for ChuDichVu
INSERT INTO ChuDichVu (MaSoTaiKhoan)
VALUES
  ('TK001'),
  ('TK003');

-- Sample data for NhanVien
INSERT INTO NhanVien (MaSoTaiKhoan, ThoiGianLamViec, NgayBatDauLam, MaNhanVienQuanLy)
VALUES
  ('TK001', '08:00:00', '2022-01-10', NULL),
  ('TK003', '09:30:00', '2021-12-05', 'TK001');

-- Sample data for KhachHang
INSERT INTO KhachHang (MaSoTaiKhoan, CapBac)
VALUES
  ('TK002', 'VIP'),
  ('TK003', 'Regular');

-- Sample data for TaiKhoanNganHang
INSERT INTO TaiKhoanNganHang (SoTaiKhoan, TenNganHang, MaKhachHang)
VALUES
  ('1234567890', 'ACB', 'TK002'),
  ('9876543210', 'Vietcombank', 'TK003');

INSERT INTO DonHang ( TinhTrangDonHang, HinhThucThanhToan, MaKhachHang, NgayGiaoDich, TaiKhoanNganHang, MaNhanVienHoTro)
VALUES
  ( 'Đã thanh toán', 'Credit Card', 'TK002', '2023-01-20', '1234567890', 'TK001');
  INSERT INTO DonHang ( TinhTrangDonHang, HinhThucThanhToan, MaKhachHang, NgayGiaoDich, TaiKhoanNganHang, MaNhanVienHoTro)
VALUES
  ( 'Chưa thanh toán', 'Cash', 'TK003', '2023-02-15', '9876543210', 'TK003');
  select*from DonHang
  -- Sample data for NhaCungCapDichVu
INSERT INTO NhaCungCapDichVu (MaDichVu, MaChuDichVu, LoaiDichVu)
VALUES
  ('DV001', 'TK001', 'Flight Booking'),
  ('DV002', 'TK003', 'Hotel Booking');

-- Sample data for HangHangKhong
INSERT INTO HangHangKhong (MaSoThue, TenHang, MoTa, SoDienThoaiTuVanVien, MaDichVu)
VALUES
  ('H001', 'Vietnam Airlines', 'National Flag Carrier', '0909876543', 'DV001'),
  ('H002', 'AirAsia', 'Low-cost Carrier', '0912345678', 'DV001');
  -- Sample data for ChuyenBay
INSERT INTO ChuyenBay ( Ngay, ThoiGianXuatPhat, ThoiGianHaCanh, DiaDiemXuatPhat, DiaDiemHaCanh, MaSoThueCuaHangHangKhong)
VALUES
  ( '2023-03-01', '2023-03-01 08:00:00', '2023-03-01 10:00:00', 'Hanoi', 'Ho Chi Minh City', 'H001');
  INSERT INTO ChuyenBay ( Ngay, ThoiGianXuatPhat, ThoiGianHaCanh, DiaDiemXuatPhat, DiaDiemHaCanh, MaSoThueCuaHangHangKhong)
VALUES
  ( '2023-03-02', '2023-03-02 12:00:00', '2023-03-02 14:00:00', 'Ho Chi Minh City', 'Hanoi', 'H002');
  select* from VeDatMayBay
-- Sample data for KhoangTrenChuyenBay
INSERT INTO KhoangTrenChuyenBay (MaSoMayBay, LoaiKhoang, GiaKhoang, SoLuongGheToiDaCungCap, MoTa)
VALUES
  ('CB001', 'Business', 2000000, 20, 'Spacious seats with premium services'),
  ('CB001', 'Economy', 800000, 150, 'Standard seating with in-flight entertainment'),
  ('CB002', 'Business', 1800000, 18, 'Comfortable seats with extra legroom'),
  ('CB002', 'Economy', 700000, 160, 'Affordable seating for budget travelers');

  INSERT INTO VeDatMayBay (MaDonHang, MaSoChuyenBay)
VALUES
  ( 'DH001', 'CB001');
  INSERT INTO VeDatMayBay ( MaDonHang, MaSoChuyenBay)
VALUES
  ( 'DH002', 'CB002');
  delete from VeDatMayBay
    select* from VeDatMayBay

--Sample data for NguoiThamGiaChuyenBay
INSERT INTO NguoiThamGiaChuyenBay ( HoVaTen, SoDienThoai, Email, SoCCCD, NgaySinh, MaVeMayBay, MaSoMayBay, LoaiKhoang)
VALUES
  ( 'Tran Thi B', '0987654321', 'tranb@yahoo.com', '987654321098', '1988-10-20', 'V001', 'CB001', 'Business');
  INSERT INTO NguoiThamGiaChuyenBay ( HoVaTen, SoDienThoai, Email, SoCCCD, NgaySinh, MaVeMayBay, MaSoMayBay, LoaiKhoang)
VALUES
  ( 'Le Van C', '0901234567', 'lecv@gmail.com', '111122223333', '1995-03-08', 'A002', 'CB002', 'Economy');
  delete from NguoiThamGiaChuyenBay
    select* from NguoiThamGiaChuyenBay
-- Sample data for HanhLy
INSERT INTO HanhLy (MaSoMayBay, LoaiHanhLyKyGui, ChiTiet, GiaCa)
VALUES
  ('CB001', 'Hand Carry', 'Small bag with personal items', 0),
  ('CB002', 'Checked Bag', 'Medium-sized suitcase', 500000);
  INSERT INTO GuiHanhLy(MaSoMayBay, LoaiHanhLyKyGui, MaNguoiThamGiaChuyenBay , SoLuong)
VALUES
  ('CB001', 'Hand Carry',  'NTGCB001', 2),
  ('CB002', 'Checked Bag', 'NTGCB002', 1);
  INSERT INTO KhachSan (MaSoThue, TenKhachSan, DiaChi, SoDienThoaiLeTan, MaDichVu)
VALUES
  ('KS001', 'Luxury Hotel', '123 Main Street, City A', '0123456789', 'DV002'),
  ('KS002', 'Budget Inn', '456 Side Street, City B', '0987654321', 'DV002');

-- Sample data for Phong
INSERT INTO Phong (MaSoThueKhachSan, LoaiPhong, Ngay, SoLuongCungCap, MoTa, GiaPhong)
VALUES
  ('KS001', 'Suite', '2023-03-01', 5, 'Spacious suite with a view', 1500000),
  ('KS001', 'Standard', '2023-03-01', 10, 'Basic room for budget travelers', 500000),
  ('KS002', 'Single', '2023-03-02', 8, 'Compact room for solo travelers', 300000);

-- Sample data for VeDatPhong
INSERT INTO VeDatPhong ( MaDonHang)
VALUES
  ( 'DH001');
  INSERT INTO VeDatPhong ( MaDonHang)
VALUES
  ( 'DH002');
      select* from VeDatPhong
-- Sample data for ChonPhong
INSERT INTO ChonPhong (MaSoThueKhachSan, LoaiPhong, Ngay, MaDatPhong, SoLuong)
VALUES
  ('KS001', 'Suite', '2023-03-01', 'VDP001', 2),
  ('KS001', 'Standard', '2023-03-01', 'VDP002', 1),
  ('KS002', 'Single', '2023-03-02', 'VDP002', 3);
-- Sample data for NhaHang
INSERT INTO NhaHang (MaSoThue, TenNhaHang, DiaChi, MoTa, SoDienThoaiQuanLy, MaDichVu)
VALUES
  ('NH001', 'Fine Dining Restaurant', '789 High Street, City C', 'Elegant dining experience', '0123456789', 'DV002'),
  ('NH002', 'Street Food Corner', '012 Street Food Alley, City D', 'Casual street food experience', '0987654321', 'DV002');

-- Sample data for Ban
INSERT INTO Ban (MaSoThueNhaHang, LoaiBan, ThoiGian, SoLuongCungCap, SoLuongNguoiToiDa1Ban, MoTa, Gia)
VALUES
  ('NH001', 'VIP', '2023-03-01', 5, 8, 'Exclusive VIP area with personalized service', 2000000),
  ('NH001', 'Regular', '2023-03-01', 10, 6, 'Standard dining area for regular customers', 800000),
  ('NH002', 'Outdoor', '2023-03-02', 8, 4, 'Open-air seating for a relaxed atmosphere', 500000);

-- Sample data for PhieuNhaHang
INSERT INTO PhieuNhaHang ( MaDonHang)
VALUES
  ( 'DH001');
  INSERT INTO PhieuNhaHang ( MaDonHang)
VALUES
  ( 'DH002');
  -- Sample data for ChonBan
INSERT INTO ChonBan (MaSoThueNhaHang, LoaiBan, ThoiGian, MaDatCho, SoLuong)
VALUES
  ('NH001', 'VIP', '2023-03-01', 'VDC001', 1),
  ('NH001', 'Regular', '2023-03-01', 'VDC002', 2),
  ('NH002', 'Outdoor', '2023-03-02', 'VDC002', 1);

delete from ChonBan
  select * from DonHang







   INSERT INTO NguoiThamGiaChuyenBay ( HoVaTen, SoDienThoai, Email, SoCCCD, NgaySinh, MaVeMayBay, MaSoMayBay, LoaiKhoang)
VALUES
  ( 'Le Van C', '0901234567', 'lecv@gmail.com', '111122223333', '1995-03-08', 'A002', 'CB002', 'Economy');
   INSERT INTO NguoiThamGiaChuyenBay ( HoVaTen, SoDienThoai, Email, SoCCCD, NgaySinh, MaVeMayBay, MaSoMayBay, LoaiKhoang)
VALUES
  ( 'Le Van C', '0901234567', 'lecv@gmail.com', '111122223333', '1995-03-08', 'A002', 'CB002', 'Economy');
   INSERT INTO NguoiThamGiaChuyenBay ( HoVaTen, SoDienThoai, Email, SoCCCD, NgaySinh, MaVeMayBay, MaSoMayBay, LoaiKhoang)
VALUES
  ( 'Le Van C', '0901234567', 'lecv@gmail.com', '111122223333', '1995-03-08', 'A002', 'CB002', 'Economy');
   INSERT INTO NguoiThamGiaChuyenBay ( HoVaTen, SoDienThoai, Email, SoCCCD, NgaySinh, MaVeMayBay, MaSoMayBay, LoaiKhoang)
VALUES
  ( 'Le Van C', '0901234567', 'lecv@gmail.com', '111122223333', '1995-03-08', 'A002', 'CB002', 'Economy');
   INSERT INTO NguoiThamGiaChuyenBay ( HoVaTen, SoDienThoai, Email, SoCCCD, NgaySinh, MaVeMayBay, MaSoMayBay, LoaiKhoang)
VALUES
  ( 'Le Van C', '0901234567', 'lecv@gmail.com', '111122223333', '1995-03-08', 'A002', 'CB002', 'Economy');
   INSERT INTO NguoiThamGiaChuyenBay ( HoVaTen, SoDienThoai, Email, SoCCCD, NgaySinh, MaVeMayBay, MaSoMayBay, LoaiKhoang)
VALUES
  ( 'Le Van C', '0901234567', 'lecv@gmail.com', '111122223333', '1995-03-08', 'A002', 'CB002', 'Economy');
   INSERT INTO NguoiThamGiaChuyenBay ( HoVaTen, SoDienThoai, Email, SoCCCD, NgaySinh, MaVeMayBay, MaSoMayBay, LoaiKhoang)
VALUES
  ( 'Le Van C', '0901234567', 'lecv@gmail.com', '111122223333', '1995-03-08', 'A002', 'CB002', 'Economy');
   INSERT INTO NguoiThamGiaChuyenBay ( HoVaTen, SoDienThoai, Email, SoCCCD, NgaySinh, MaVeMayBay, MaSoMayBay, LoaiKhoang)
VALUES
  ( 'Le Van C', '0901234567', 'lecv@gmail.com', '111122223333', '1995-03-08', 'A002', 'CB002', 'Economy');

     INSERT INTO NguoiThamGiaChuyenBay ( HoVaTen, SoDienThoai, Email, SoCCCD, NgaySinh, MaVeMayBay, MaSoMayBay, LoaiKhoang)
VALUES
  ( 'Le Van C', '0901234567', 'lecv@gmail.com', '111122223333', '1995-03-08', 'A002', 'CB002', 'Economy');
     INSERT INTO NguoiThamGiaChuyenBay ( HoVaTen, SoDienThoai, Email, SoCCCD, NgaySinh, MaVeMayBay, MaSoMayBay, LoaiKhoang)
VALUES
  ( 'Le Van C', '0901234567', 'lecv@gmail.com', '111122223333', '1995-03-08', 'A002', 'CB002', 'Economy');
     INSERT INTO NguoiThamGiaChuyenBay ( HoVaTen, SoDienThoai, Email, SoCCCD, NgaySinh, MaVeMayBay, MaSoMayBay, LoaiKhoang)
VALUES
  ( 'Le Van C', '0901234567', 'lecv@gmail.com', '111122223333', '1995-03-08', 'A002', 'CB002', 'Economy');



  EXEC UpdateTaiKhoanDangNhap
	@Maso='TK008',
    @Ho = 'Tran',
    @TenDem = 'Van',
    @Ten = 'D',
    @NgaySinh = '2023-01-15',
    @GioiTinh = 'F',
    @SoCCCD = '999999999999';
	EXEC InsertTaiKhoanDangNhap
    @Ho = 'Tran',
    @TenDem = 'Van',
    @Ten = 'quy',
    @NgaySinh = '2023-01-15',
    @GioiTinh = 'F',
    @SoCCCD = '121111135511';
  select * from NguoiThamGiaChuyenBay
  select * from DonHang
  delete from NguoiThamGiaChuyenBay;
  delete from HanhLy
  INSERT INTO GuiHanhLy (MaSoMayBay, LoaiHanhLyKyGui,MaNguoiThamGiaChuyenBay , SoLuong)
VALUES
  ('CB001', 'Hand Carry',  'NTGCB001' ,2),
  ('CB002', 'Checked Bag',   'NTGCB002',10),
  ('CB002', 'Checked Bag',  'NTGCB003',1);

    INSERT INTO GuiHanhLy(MaSoMayBay, LoaiHanhLyKyGui, MaNguoiThamGiaChuyenBay , SoLuong)
VALUES
  ('CB001', 'Hand Carry',  'NTGCB001', 2),
  ('CB002', 'Checked Bag', 'NTGCB002', 10);
    select * from GuiHanhLy
	  delete  from GuiHanhLy


select* from VeDatMayBay join DonHang on VeDatMayBay.MaDonHang=DonHang.MaDonHang
DECLARE @machudichvu VARCHAR(20) = 'TK001';
DECLARE @tenhangmaybay VARCHAR(50) = 'Vietnam Airlines';
DECLARE @namthongke INT = 2023;
---testthongke
SELECT * FROM ThongKeDoanhThu12Thang('TK001','VietNam Airlines',2023);
--thongketopuser:
SELECT *
FROM dbo.GetTopPayments(10, '2023-01-01', '2023-01-20');
select* from KhachHang
select* from DonHang

SELECT
        *
    FROM
        DonHang as a join VeDatMayBay as b on b.MaDonHang=a.MaDonHang AND a.TinhTrangDonHang='Đã thanh toán'
		join ChuyenBay as c on b.MaSoChuyenBay=c.MaSo
		join HangHangKhong as d on c.MaSoThueCuaHangHangKhong=d.MaSoThue
		join NhaCungCapDichVu as e on d.MaDichVu=e.MaDichVu
		join ChuDichVu as f on f.MaSoTaiKhoan=e.MaChuDichVu
		where YEAR(a.NgayGiaoDich)=2023 AND e.MaChuDichVu='TK001' AND d.TenHang='Vietnam Airlines'

		    SELECT
        MONTH(a.NgayGiaoDich) AS Thang,
        SUM(b.TongTien) AS TongDoanhThuThang
    FROM
        DonHang as a join VeDatMayBay as b on b.MaDonHang=a.MaDonHang AND a.TinhTrangDonHang='Đã thanh toán'
		join ChuyenBay as c on b.MaSoChuyenBay=c.MaSo
		join HangHangKhong as d on c.MaSoThueCuaHangHangKhong=d.MaSoThue
		join NhaCungCapDichVu as e on d.MaDichVu=e.MaDichVu
		join ChuDichVu as f on f.MaSoTaiKhoan=e.MaChuDichVu
    		where YEAR(a.NgayGiaoDich)=2023 AND e.MaChuDichVu='TK001' AND d.TenHang='Vietnam Airlines'

    GROUP BY
        MONTH(a.NgayGiaoDich)
*/
