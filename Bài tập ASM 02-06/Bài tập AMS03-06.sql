CREATE DATABASE AMS03
USE AMS03;
GO
CREATE TABLE KhachHang (
    KhachHangID INT PRIMARY KEY,
    TenKhachHang NVARCHAR(100),
    SoCMND NVARCHAR(20),
    DiaChi NVARCHAR(200),
    SoDienThoai NVARCHAR(15),
    LoaiThueBao NVARCHAR(50),
    NgayDangKy DATE
);
GO
-- Tạo bảng ThueBao
CREATE TABLE ThueBao (
    ThueBaoID INT PRIMARY KEY,
    KhachHangID INT REFERENCES KhachHang(KhachHangID),
    SoThueBao NVARCHAR(15)
);
GO
-- Thêm dữ liệu vào bảng KhachHang và ThueBao
INSERT INTO KhachHang (KhachHangID, TenKhachHang, SoCMND, DiaChi, SoDienThoai, LoaiThueBao, NgayDangKy)
VALUES
    (1, N'Nguyên Nguyệt Nga', N'123456789', N'Hà Nội', N'123456789', N'Tra trước', '2023-08-29');

INSERT INTO ThueBao (ThueBaoID, KhachHangID, SoThueBao)
VALUES
    (1, 1, N'123456789');
GO
SELECT *
FROM KhachHang;
GO
SELECT *
FROM ThueBao;
GO
SELECT *
FROM ThueBao
WHERE SoThueBao = N'0123456789';
GO
SELECT *
FROM KhachHang
WHERE SoCMND = N'123456789';
GO
SELECT ThueBao.*
FROM KhachHang
INNER JOIN ThueBao ON KhachHang.KhachHangID = ThueBao.KhachHangID
WHERE KhachHang.SoCMND = N'123456789';
GO
SELECT *
FROM ThueBao
WHERE NgayDangKy = '2023-08-29';
GO
SELECT ThueBao.*
FROM KhachHang
INNER JOIN ThueBao ON KhachHang.KhachHangID = ThueBao.KhachHangID
WHERE KhachHang.DiaChi = N'Hà Nội';
GO
SELECT COUNT(*) AS TongSoKhachHang
FROM KhachHang;
GO
SELECT COUNT(*) AS TongSoThueBao
FROM ThueBao;
GO
SELECT COUNT(*) AS TongSoThueBao
FROM ThueBao
WHERE NgayDangKy = '2023-08-29';
SELECT KhachHang.*, ThueBao.*
FROM KhachHang
INNER JOIN ThueBao ON KhachHang.KhachHangID = ThueBao.KhachHangID;
GO
SELECT COUNT(DISTINCT Manufacturer) AS NumberOfManufacturers
FROM Product;
GO
SELECT COUNT(*) AS TotalProducts
FROM Product;
GO
SELECT Manufacturer, COUNT(*) AS TotalProducts
FROM Product
GROUP BY Manufacturer;
GO
SELECT SUM(StockQuantity) AS TotalStockQuantity
FROM Product;
GO
UPDATE Product
SET Price = 20
WHERE Price < 0;
GO
UPDATE KhachHang
SET SoDienThoai = CONCAT('0', SoDienThoai)
WHERE SoDienThoai NOT LIKE '0%';
EXEC sp_fkeys 'KhachHang';
EXEC sp_fkeys 'ThueBao';
CREATE INDEX IX_TenHang ON Product (ProductName);
GO
CREATE VIEW View_SanPham AS
SELECT ProductID, ProductName, Price
FROM Product;
GO
CREATE VIEW View_SanPham_Hang AS
SELECT ProductID, ProductName, Manufacturer
FROM Product;
GO
CREATE PROCEDURE SP_SanPham_TenHang
    @TenHang NVARCHAR(100)
AS
BEGIN
    SELECT ProductID, ProductName
    FROM Product
    WHERE ProductName = @TenHang;
END;
GO
CREATE PROCEDURE SP_SanPham_Gia
    @Gia MONEY
AS
BEGIN
    SELECT ProductID, ProductName
    FROM Product
    WHERE Price >= @Gia;
END;
GO
CREATE PROCEDURE SP_SanPham_HetHang
AS
BEGIN
    SELECT ProductID, ProductName
    FROM Product
    WHERE StockQuantity = 0;
END;
GO
CREATE TRIGGER TG_XoaHang
ON Product
INSTEAD OF DELETE
AS
BEGIN
    RAISEERROR('Ngăn không cho phép xóa hãng sản xuất.', 16, 1);
END;
GO
CREATE TRIGGER TG_XoaSanPham
ON Product
AFTER DELETE
AS
BEGIN
    DELETE FROM PhoneNumber
    WHERE ProductID IN (SELECT deleted.ProductID FROM deleted);
END;
GO
