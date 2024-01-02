-- ================================================
-- Template generated from Template Explorer using:
-- Create Trigger (New Menu).SQL
--
-- Use the Specify Values for Template Parameters 
-- command (Ctrl-Shift-M) to fill in the parameter 
-- values below.
--
-- See additional Create Trigger templates for more
-- examples of different Trigger statements.
--
-- This block of comments will not be included in
-- the definition of the function.
-- ================================================
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE TRIGGER So_luong_hanh_ly_max
   ON  GuiHanhLy
   AFTER INSERT
AS 
BEGIN
  DECLARE @max_passengers_per_MaVe INT = 9;
  IF EXISTS (
      SELECT 1
      FROM (
          SELECT MaSoMayBay,MaNguoiThamGiaChuyenBay, sum(SoLuong) AS PassengerCount
          FROM GuiHanhLy
          GROUP BY MaSoMayBay,MaNguoiThamGiaChuyenBay
      ) AS VeCounts
      WHERE PassengerCount > @max_passengers_per_MaVe
  )

  BEGIN
DELETE FROM b
FROM GuiHanhLy as b
WHERE EXISTS  (
    SELECT a.MaSoMayBay, a.MaNguoiThamGiaChuyenBay
    FROM GuiHanhLy as a
    WHERE a.MaSoMayBay = b.MaSoMayBay
      AND a.MaNguoiThamGiaChuyenBay = b.MaNguoiThamGiaChuyenBay
    GROUP BY a.MaSoMayBay, a.MaNguoiThamGiaChuyenBay
    HAVING SUM(a.SoLuong) > 9
);
    RAISERROR('Số lượng hành lý đã quá 9 kiện.', 16, 1);
  END;
END;

  