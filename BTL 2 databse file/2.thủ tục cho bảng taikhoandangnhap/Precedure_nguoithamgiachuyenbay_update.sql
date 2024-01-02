drop procedure UpdateNguoiThamGiaChuyenBay
CREATE PROCEDURE UpdateNguoiThamGiaChuyenBay
    @MaKhachHang VARCHAR(255),
    @HoVaTen VARCHAR(40),
    @SoDienThoai VARCHAR(30),
    @Email VARCHAR(255),
    @SoCCCD VARCHAR(30),
    @NgaySinh DATE,
    @MaVeMayBay VARCHAR(20),
    @MaSoMayBay VARCHAR(20),
    @LoaiKhoang VARCHAR(20)
AS
BEGIN
    -- Kiểm tra dữ liệu hợp lệ
    -- Kiểm tra dữ liệu HoVaTen không được bỏ trống
    IF LTRIM(RTRIM(@HoVaTen)) = ''
    BEGIN
        RAISERROR('Chưa nhập họ và tên', 16, 1);
        RETURN;
    END

     -- Kiểm tra dữ liệu HoVaTen chỉ chứa các chữ cái
     IF @HoVaTen LIKE '%[^a-zA-Z ]%'
    BEGIN
        RAISERROR('Ho va ten khong hop le', 16, 1);
        RETURN;
    END

    -- Kiểm tra dữ liệu SoDienThoai không được bỏ trống
    IF LTRIM(RTRIM(@SoDienThoai)) = ''
    BEGIN
        RAISERROR('Chưa nhập số điện thoại', 16, 1);
        RETURN;
    END
     
    -- Kiểm tra dữ liệu SoDienThoai có độ dài từ 7 đến 11 và chỉ chứa các chữ số
    IF LEN(@SoDienThoai) < 7 Or LEN(@SoDienThoai) > 11
    BEGIN
        RAISERROR('Số điện thoại không hợp lệ.', 16, 1);
        RETURN;
    END


    -- Kiểm tra dữ liệu NgaySinh không thể là ngày của tương lai
     IF @NgaySinh > GETDATE()
    BEGIN
        RAISERROR('Ngày sinh không thể là tương lai', 16, 1);
        RETURN;
    END

	-- Kiểm tra dữ liệu NgaySinh không được bỏ trống
	IF @NgaySinh IS  NULL OR @NgaySinh = ''
    BEGIN
        RAISERROR('Chưa nhập ngày sinh', 16, 1);
        RETURN;
    END
     
     -- Kiểm tra dữ liệu NgaySinh có tuổi bé hơn 3 hay không
    IF DATEDIFF(YEAR, @NgaySinh, GETDATE()) < 3
    BEGIN
        RAISERROR('Vui lòng thêm thông tin của đứa bé trong phần mô tả của người giám hộ', 16, 1);
        RETURN;
    END

    -- Kiểm tra SoCCCD
    IF DATEDIFF(YEAR, @NgaySinh, GETDATE()) >= 18
    BEGIN
        IF @SoCCCD IS NULL OR LTRIM(RTRIM(@SoCCCD)) = ''
        BEGIN
            RAISERROR('CCCD không được để trống', 16, 1);
            RETURN;
        END
        ELSE IF LEN(@SoCCCD) <> 12
        BEGIN
            RAISERROR('Căn cước công dân không hợp lệ đối với trên 18 tuổi', 16, 1);
            RETURN;
        END
    END
    
    -- Kiểm tra định dạng email
    IF NOT (CHARINDEX('@', @Email) > 0 AND CHARINDEX('.', @Email, CHARINDEX('@', @Email)) > 0)
    BEGIN
        RAISERROR('Địa chỉ email không hợp lệ.', 16, 1);
        RETURN;
    END

    -- Kiểm tra các ràng buộc khác nếu cần
    -- ...

    -- Thực hiện cập nhật dữ liệu
     UPDATE NguoiThamGiaChuyenBay
     SET HoVaTen = @HoVaTen,
        SoDienThoai = @SoDienThoai,
        Email = @Email,
        SoCCCD = @SoCCCD,
        NgaySinh = @NgaySinh,
        MaVeMayBay = @MaVeMayBay,
        MaSoMayBay = @MaSoMayBay,
        LoaiKhoang = @LoaiKhoang
    WHERE MaKhachHang = @MaKhachHang;
END;

go
