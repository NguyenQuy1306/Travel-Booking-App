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
ADD CHECK (SoLuong > 0);

ALTER TABLE Phong
ADD CHECK (SoLuongCungCap >= 0);

ALTER TABLE ChonPhong
ADD CHECK (SoLuong > 0);

ALTER TABLE Ban
ADD CHECK (SoLuongCungCap >= 0);

ALTER TABLE Ban
ADD CHECK (SoLuongNguoiToiDa1Ban > 0);

ALTER TABLE ChonBan
ADD CHECK (SoLuong > 0);

