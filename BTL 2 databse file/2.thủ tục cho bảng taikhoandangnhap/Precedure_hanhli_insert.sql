
CREATE PROCEDURE InsertHanhLy
    @MaSoMayBay VARCHAR(20),
    @LoaiHanhLyKyGui VARCHAR(20),
	@MaNguoiThamGiaChuyenBay VARCHAR(255),
	@SoLuong INT
AS
BEGIN
    IF @SoLuong < 0
    BEGIN
        RAISERROR('Số lượng hành lý phải là số không âm.', 16, 1);
        RETURN;
    END
    -- Thực hiện thêm dữ liệu
    INSERT INTO GuiHanhLy( MaSoMayBay, LoaiHanhLyKyGui, MaNguoiThamGiaChuyenBay, SoLuong)
    VALUES ( @MaSoMayBay, @LoaiHanhLyKyGui, @MaNguoiThamGiaChuyenBay, @SoLuong);
END;
